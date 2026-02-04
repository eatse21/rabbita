///|
using @url {type Url, type UrlRequest}

///|
/// The render function will do the following step:
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
  subscriptions : Map[Id, &Cell]
  subscription_tree : Map[Id, Set[Id]]
  queue : @queue.Queue[Id]
  root : &Cell
  mut captured_link_listener : @dom.Listener
  mut is_initial : Bool
  mut next_id : Int
  mut scheduled : Bool
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
    subscriptions: Map::from_array([(root.state().id, root)]),
    subscription_tree: Map::from_array([(root.state().id, Set::new())]),
    queue: @queue.new(),
    on_url_changed: None,
    on_url_request: None,
    next_id: 1,
    scheduled: false,
    mount: "",
    is_initial: true,
    captured_link_listener,
  })
  sandbox.unwrap()
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
/// 
/// This function orchestrates the rendering pipeline by:
/// 1. Processing all pending effects in the effect queue
/// 2. Updating all relevant models based on these effects
/// 3. Triggering the rendering process once the queue is fully drained
pub fn Sandbox::flush(self : Self) -> Unit {
  let dirty_set = Set::new()
  while self.queue.pop() is Some(id) {
    if self.subscriptions.get(id) is Some(cell) {
      dirty_set.add(id)
      cell.step(self)
    }
  }
  println("dirty set: \{dirty_set}")
  let root_element = @dom.document().get_element_by_id(self.mount).unwrap() // TODO: handle error
  let root_node = root_element.as_node()
  if self.is_initial {
    self.is_initial = false
    let root = self.root
    let vnode = root.view()
    let id = root.state().id
    let inode = vnode.insert(self, id, root_node, null())
    root.state().inode = Some(inode)
  } else {
    let dirty_ids = dirty_set.to_array()
    while dirty_ids.pop() is Some(id) {
      if self.subscriptions.get(id) is Some(cell) {
        let vnode = cell.view()
        let inode = cell.state().inode.unwrap()
        let inode = diff_node(inode, vnode, self, root_node, null(), id)
        cell.state().inode = Some(inode)
      }
    }
  }
  // self.root.node().validate()
}

///|
pub impl Scheduler for Sandbox with add(self, cmd) {
  match cmd {
    Empty => ()
    Batch(xs) => xs.each(x => self.add(x))
    Effect(effect) => effect(self)
    Message(id, send_message) => {
      send_message()
      self.queue.push(id)
    }
  }
  if !self.scheduled {
    self.scheduled = true
    @dom.window().request_animation_frame(fn(_) {
      self.flush()
      self.scheduled = false
    })
    |> ignore
  }
}

///|
pub impl Scheduler for Sandbox with subscribe(self, parent, cell) {
  let id = cell.state().id
  if id.value is None {
    id.value = Some(self.next_id)
    self.next_id += 1
  }
  if !self.subscriptions.contains(id) {
    self.subscriptions[id] = cell
    self.subscription_tree[parent].add(id)
    self.subscription_tree[id] = Set::new()
    self.queue.push(id)
  }
}

///|
pub impl Scheduler for Sandbox with unsubscribe(self, parent, cell) {
  self.subscriptions.remove(cell.state().id)
  self.subscription_tree[parent].remove(cell.state().id)
  self.subscription_tree.remove(cell.state().id)
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
