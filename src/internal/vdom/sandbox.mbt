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
  queue : @queue.Queue[Id]
  root : &Cell
  mut next_id : Int
  mut scheduled : Bool
  mut mount : String
  mut on_url_changed : ((Url) -> Cmd)?
  mut on_url_request : ((UrlRequest) -> Cmd)?
}

///|
pub fn Sandbox::new(root : &Cell) -> Sandbox {
  root.id().value = Some(0)
  let sandbox : Sandbox = {
    root,
    subscriptions: Map::from_array([(root.id(), root)]),
    queue: @queue.new(),
    on_url_changed: None,
    on_url_request: None,
    next_id: 1,
    scheduled: false,
    mount: "",
  }
  sandbox
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
/// 
/// This function orchestrates the rendering pipeline by:
/// 1. Processing all pending effects in the effect queue
/// 2. Updating all relevant models based on these effects
/// 3. Triggering the rendering process once the queue is fully drained
pub fn Sandbox::flush(self : Self) -> Unit {
  while self.queue.pop() is Some(id) {
    if self.subscriptions.get(id) is Some(component) {
      component.step(self)
    }
  }
  let old = self.root.node()
  self.root.refersh()
  let new = self.root.node()
  let root_element = @dom.document().get_element_by_id(self.mount).unwrap() // TODO: handle error
  let dom_patcher = DomPatcher::new(root_element, self)
   diff_node(old, new, dom_patcher, self)
  // let debug_patcher = DebugPatcher::new(root_element, self)
  // let debug_subs = self.subscriptions.map((_, _) => ())
  // let debug_ques = self.queue.to_string()
  // println("\{debug_subs}, \{debug_ques}")
  // println("---------------- old: \n\{pretty_vnode(old)}")
  // diff_node(old, new, debug_patcher, self)
  // println("---------------- new: \n\{pretty_vnode(new)}")
}

///|
pub impl Scheduler for Sandbox with add(self, cmd) {
  println("scheduler.add: \{self.queue}")
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
pub impl Scheduler for Sandbox with subscribe(self, cell) {
  cell.id().value = Some(self.next_id)
  self.subscriptions[cell.id()] = cell
  println("subscribe \{cell.id()}")
  self.queue.push(cell.id())
  self.next_id += 1
}

///|
pub impl Scheduler for Sandbox with unsubscribe(self, cell) {
  self.subscriptions.remove(cell.id())
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
