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
    while self.msg_queue.pop() is Some(msg) {
      if self.live_map.get(msg) is Some(cell) {
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
  let cells = [self.root]
  while cells.pop() is Some(cell) {
    let state = cell.state()
    self.update_cell_tree(state)
    for _, link in state.childs {
      if link.link is Some(child) {
        cells.push(child)
      }
    }
  }
  println(self.live_map.keys())
}

///|
fn Sandbox::update_cell_tree(_self : Self, parent : State) -> Unit {
  // Update cell tree and live map: invalidate old link and update childs map
  for _, old_child in parent.childs {
    if old_child.link is None {
      continue
    }
    old_child.detach()
  }
  parent.childs.clear()
  for new_child in parent.inode.unwrap().scan_childs() {
    let new_child_state = new_child.state()
    // invalidate old link
    new_child.state().parent_link.detach()
    // add new link
    let link = Link::new(new_child)
    new_child_state.parent_link = link
    parent.childs[new_child_state.id] = link
  }
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
pub fn Sandbox::flush(self : Self) -> Unit {
  if !self.paint_scheduled {
    self.paint_scheduled = true
    @dom.window().request_animation_frame(fn(_) {
      // println("dirty set: \{dirty_set}")
      let cells = Queue::from_array([self.root])
      let new_live_map = {}
      while cells.pop() is Some(cell) {
        let state = cell.state()
        new_live_map[state.id] = cell
        if state.dirty {
          let vnode = cell.view()
          // The parent cell helps child cells initialize their inodes during vdom diff,
          // so initially child cells are not in the dirty set
          guard state.inode is Some(inode)
          let (parent, before) = match inode {
            Frag(_, _, e) | Cell(_, _, _, e) =>
              (e.get_parent_node().unwrap(), e.get_next_sibling())
            Text(_, e) | Elem(_, _, _, e, ..) =>
              (e.get_parent_node().unwrap(), e.get_next_sibling())
          }
          let inode = diff_node(inode, vnode, self, parent, before, cell)
          state.inode = Some(inode)
          self.update_cell_tree(state)
          state.dirty = false
        }
        for _, link in state.childs {
          match link.link {
            None => continue
            Some(c) => cells.push(c)
          }
        }
      }
      // self.root.node().validate()
      self.live_map = new_live_map
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

// ///|
// pub impl Scheduler for Sandbox with subscribe(self, parent, cell) {
//   let state = cell.state()
//   if state.id.value is None {
//     state.id.value = Some(self.next_id)
//     self.next_id += 1
//   }
//   state.live_count += 1
//   state.parent = Some(parent.state().id)
//   parent.state().childs.set(state.id, cell)
// }

// ///|
// pub impl Scheduler for Sandbox with unsubscribe(self, _parent, cell) {
//   let state = cell.state()
//   state.live_count -= 1
//   if state.live_count < 1 &&
//     state.parent is Some(pid) &&
//     self.live_map.get(pid) is Some(parent) {
//     parent.state().childs.remove(state.id)
//   }
// }

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
