///|
/// The command type, represents a task that can be executed.
/// 
/// You can define your own command to interoperate Rabbit-Tea with the outside JS world.
/// 
/// Before implementing your own command, check the existing commands in the `nav` and `http` packages.
/// 
/// # Example 
/// 
/// ```moonbit skip
/// fn delay(eff : Effect, ms : Int) -> Effect {
///   Effect(scheduler => set_timeout(() => scheduler.pending(msg), ms))
/// }
///
/// extern "js" fn set_timeout(f : () -> Unit, ms : Int) = "(f,ms) => setTimeout(f, ms)"
/// ```
#alias(Cmd)
pub(all) enum Effect {
  Effect((Scheduler) -> Unit)
  Batch(Array[Effect])
  Empty
}

///|
struct Scheduler {
  pending : (Effect) -> Unit
  url_changed : ((@url.Url) -> Effect)?
  url_request : ((@url.UrlRequest) -> Effect)?
}

///|
pub fn Scheduler::new(
  pending : (Effect) -> Unit,
  url_changed : ((@url.Url) -> Effect)?,
  url_request : ((@url.UrlRequest) -> Effect)?,
) -> Scheduler {
  { pending, url_changed, url_request }
}

///|
pub fn Scheduler::pending(self : Self, effect : Effect) -> Unit {
  (self.pending)(effect)
}

///|
pub fn Scheduler::pending_url_changed(self : Self, url : @url.Url) -> Unit {
  match self.url_changed {
    None => ()
    Some(f) => self.pending(f(url))
  }
}

///|
pub fn Scheduler::pending_url_request(
  self : Self,
  request : @url.UrlRequest,
) -> Unit {
  match self.url_request {
    None => ()
    Some(f) => self.pending(f(request))
  }
}

///|
/// Create a command that does nothing.
pub fn none() -> Cmd {
  Empty
}

///|
/// Create a command that runs multiple commands.
pub fn batch(xs : Array[Cmd]) -> Cmd {
  Batch(xs)
}

///|
/// Create a command that runs an async function.
/// 
/// The async function `f` will be called, and the result will be wrapped in a 
/// message `msg`, then trigger another update with this message.
pub fn[A] perform(msg : (A) -> Cmd, f : async () -> A noraise) -> Cmd {
  Effect(scheduler => @js.async_run(() => scheduler.pending(msg(f()))))
}

///|
/// Create a command that runs an async function and handles errors.
/// 
/// This is similar to `perform`, but it converts the returned value 
/// or thrown error into a `Result`.
pub fn[A, E : Error] attempt(
  msg : (Result[A, E]) -> Cmd,
  f : async () -> A raise E,
) -> Cmd {
  Effect(scheduler => @js.async_run(() => {
    let msg = try f() catch {
      e => msg(Err(e))
    } noraise {
      r => msg(Ok(r))
    }
    scheduler.pending(msg)
  }))
}
