///|
using @url {type Url, type UrlRequest}

///|
struct Sandbox {
  queue : @queue.Queue[@cmd.Message]
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
  render : () -> Unit
  mut on_url_changed : ((Url) -> Unit)?
  mut on_url_request : ((UrlRequest) -> Unit)?
}

///|
pub fn Sandbox::set_on_url_changed(self : Self, f : ((Url) -> Unit)?) -> Unit {
  self.on_url_changed = f
}

///|
pub fn Sandbox::set_on_url_request(
  self : Self,
  f : ((UrlRequest) -> Unit)?,
) -> Unit {
  self.on_url_request = f
}

///|
pub fn Sandbox::new(
  render : () -> Unit,
  on_url_changed? : (Url) -> Unit,
  on_url_request? : (UrlRequest) -> Unit,
) -> Sandbox {
  @dom.window()
  .to_event_target()
  .add_event_listener("popstate", _ => {
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    match on_url_changed {
      Some(f) => f(url)
      None => ()
    }
  })
  { render, queue: @queue.Queue::new(), on_url_changed, on_url_request }
}

///|
/// Push a pending message to message queue.
pub fn Sandbox::pending(self : Self, m : @cmd.Message) -> Unit {
  self.queue.push(m)
}

///|
/// Schedules a drawing frame to be rendered on the next animation frame.
/// 
/// This function orchestrates the rendering pipeline by:
/// 1. Processing all pending messages in the message queue
/// 2. Updating all relevant models based on these messages
/// 3. Triggering the rendering process once the queue is fully drained
pub fn Sandbox::schedule(self : Self) -> Unit {
  while self.queue.pop() is Some(msg) {
    match msg {
      Batch(xs) => xs.each(x => self.queue.push(x))
      Message(f) => self.queue.push(f())
      Empty => ()
    }
  }
  (self.render)()
}
///|
/// Launch commands. It may trigger the update function.
pub fn Sandbox::launch(self : Self, cmd : @cmd.Cmd) -> Unit {
  let f = cmd.0
  let mut predefined = None
  let on_url_changed = self.on_url_changed.unwrap_or(ignore)
  let on_url_request = self.on_url_request.unwrap_or(ignore)
  predefined = Some(
    @cmd.Events::new(on_url_changed, on_url_request, x => {
      self.pending(x)
      self.schedule()
    }),
  )
  f(predefined.unwrap())
}
