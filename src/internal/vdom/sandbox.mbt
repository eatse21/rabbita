///|
using @url {type Url, type UrlRequest}

///|
using @cmd {type Effect, type Scheduler}

///|
pub(all) struct Sandbox {
  queue : @queue.Queue[Effect]
  /// This function will do the following step:
  ///
  /// 1. view(model) -> newView  
  ///      compute new vdom from model
  ///
  /// 2. diff(oldView, newView) -> patch
  ///      generate patches by comparing to old vdom
  ///
  /// 3. mount(patch)
  ///      apply patches to real DOM
  priv render : () -> Unit
  mut on_url_changed : ((Url) -> Effect)?
  mut on_url_request : ((UrlRequest) -> Effect)?
  mut mount_element : String
}

///|
pub fn Sandbox::new(render : () -> Unit) -> Sandbox {
  let sandbox = {
    render,
    queue: @queue.Queue::new(),
    on_url_changed: None,
    on_url_request: None,
    mount_element: "",
  }
  sandbox
}

///|
/// Push a pending effect to effect queue.
pub fn Sandbox::pending(self : Self, m : Effect) -> Unit {
  self.queue.push(m)
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
/// 
/// This function orchestrates the rendering pipeline by:
/// 1. Processing all pending effects in the effect queue
/// 2. Updating all relevant models based on these effects
/// 3. Triggering the rendering process once the queue is fully drained
pub fn Sandbox::schedule(self : Self) -> Unit {
  let scheduler = Scheduler::new(
    e => self.pending(e),
    self.on_url_changed,
    self.on_url_request,
  )
  while self.queue.pop() is Some(msg) {
    match msg {
      Batch(xs) => xs.each(x => self.queue.push(x))
      Effect(f) => f(scheduler)
      Empty => ()
    }
  }
  (self.render)()
}
