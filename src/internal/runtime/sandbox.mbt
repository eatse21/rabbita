///|
using @url {type Url, type UrlRequest}

///|
using @queue {type Queue}

///|
/// The rendering pipeline will do the following step:
///
/// 1. view(model) -> newView  
///      compute new vdom from model
///
/// 2. diff(oldView, newView) -> patch
///      generate patches by comparing to old vdom
///
/// 3. mount(patch)
///      apply patches to real DOM
pub(all) struct Sandbox {
  mut live_map : Map[Id, &Cell]
  msg_queue : Queue[Id]
  mut drain_scheduled : Bool
  dirty_set : Set[Id]
  mut paint_scheduled : Bool
  root : &Cell
  mut captured_link_listener : @dom.Listener
  mut next_id : Int
  mut mount : String
  mut on_url_changed : ((Url) -> Cmd)?
  mut on_url_request : ((UrlRequest) -> Cmd)?
}

///|
pub fn Sandbox::new(root : &Cell) -> Sandbox {
  root.state().id.value = Some(0)
  let mut sandbox : Sandbox? = None
  let captured_link_listener = fn(event : @dom.Event) {
    let mouse_event = event.to_mouse_event().unwrap()
    if not(mouse_event.get_meta_key() || mouse_event.get_ctrl_key()) {
      event.prevent_default()
      let href = event
        .current_target()
        .unwrap()
        .to_element()
        .unwrap()
        .get_property("href")
        .unwrap()
      let curr = try! @url.parse(@dom.window().current_url())
      let next = try! @url.parse(href)
      let request = if curr.protocol == next.protocol &&
        curr.host == next.host &&
        curr.port == next.port {
        @url.Internal(next)
      } else {
        External(href)
      }
      sandbox.unwrap().add_url_request(request)
    }
  }
  sandbox = Some({
    root,
    live_map: Map::from_array([(root.state().id, root)]),
    msg_queue: Queue::new(),
    dirty_set: Set::new(),
    on_url_changed: None,
    on_url_request: None,
    next_id: 1,
    paint_scheduled: false,
    drain_scheduled: false,
    mount: "",
    captured_link_listener,
  })
  sandbox.unwrap()
}

///|
/// Processing all pending messages FIFO to update all relevant models
pub fn Sandbox::drain(self : Self) -> Unit {
  if !self.drain_scheduled {
    self.drain_scheduled = true
    while self.msg_queue.pop() is Some(id) {
      if self.live_map.get(id) is Some(cell) {
        cell.step(self)
        self.dirty_set.add(cell.state().id)
      }
    }
    self.drain_scheduled = false
    self.flush()
  }
}

///|
pub fn Sandbox::initialize(self : Self) -> Unit {
  let root = self.root
  let element = @dom.document().get_element_by_id(self.mount).unwrap() // TODO: handle error
  self.dirty_set.add(root.state().id)
  let vnode = root.view()
  let inode = vnode.insert(self, root, element.as_node(), null())
  root.state().inode = Some(inode)
}

///|
fn Sandbox::drop_live_subtree(self : Self, root : &Cell) -> Unit {
  let stack = [root]
  while stack.pop() is Some(cell) {
    let state = cell.state()
    state.attach_count -= 1
    if state.attach_count <= 0 {
      self.live_map.remove(state.id)
      self.dirty_set.remove(state.id)
    }
    // Removal can happen mid-diff; scan both old/new links to avoid leaving orphans.
    // Example: parent replaces child A with B (B goes to new_childs), then the
    // parent subtree is removed before commit. If we only scan old_childs,
    // B would stay live even though its DOM is gone.
    for _, link in state.old_childs {
      if link.val is Some(c) {
        stack.push(c)
      }
    }
    for _, link in state.new_childs {
      if link.val is Some(c) {
        stack.push(c)
      }
    }
  }
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
pub fn Sandbox::flush(self : Self) -> Unit {
  if !self.paint_scheduled {
    self.paint_scheduled = true
    @dom.window().request_animation_frame(fn(_) {
      let dirty = self.dirty_set.to_array()
      self.dirty_set.clear()
      for id in dirty {
        if self.live_map.get(id) is Some(cell) {
          let state = cell.state()
          // Dirty-set can contain stale ids; skip if already clean.
          // Example: a cell was marked dirty, then got removed or superseded
          // before flush; keeping this guard prevents redundant diff/crash.
          if !state.dirty {
            continue
          }
          let vnode = cell.view()
          // The parent cell helps child cells initialize their inodes during vdom diff,
          // so initially child cells are not in the dirty set
          guard state.inode is Some(inode)
          let end = inode.end()
          let parent = end.get_parent_node().unwrap()
          let next_sibling = end.get_next_sibling()
          let inode = diff_node(inode, vnode, self, parent, next_sibling, cell)
          state.inode = Some(inode)
          state.dirty = false
          for id, link in state.old_childs {
            if link.val is Some(_) {
              state.new_childs[id] = link
            }
          }
          state.old_childs = state.new_childs
          state.new_childs = Map::new()
        }
      }
      // self.root.node().validate()
      self.paint_scheduled = false
    })
    |> ignore
  }
}

///|
/// Run an effect immediately or pending a message.
pub impl Scheduler for Sandbox with add(self, cmd) {
  match cmd {
    Empty => ()
    Batch(xs) => xs.each(x => self.add(x))
    Effect(effect) => effect(self)
    Message(id, send_message) => {
      send_message()
      self.msg_queue.push(id)
    }
  }
  self.drain()
}

///|
pub impl Scheduler for Sandbox with add_url_changed(self, url) {
  match self.on_url_changed {
    None => ()
    Some(f) => self.add(f(url))
  }
}

///|
pub impl Scheduler for Sandbox with add_url_request(self, request) {
  match self.on_url_request {
    None => ()
    Some(f) => self.add(f(request))
  }
}
