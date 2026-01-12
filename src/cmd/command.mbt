///|
pub(all) enum Message {
  Message(() -> Message)
  Batch(Array[Message])
  Empty
}

///|
/// Store the events that can be triggered by the command.
struct Events {
  on_url_changed : (@url.Url) -> Unit
  on_url_request : (@url.UrlRequest) -> Unit
  on_update : (Message) -> Unit
}

///|
/// Used by the runtime.
pub fn Events::new(
  on_url_changed : (@url.Url) -> Unit,
  on_url_request : (@url.UrlRequest) -> Unit,
  on_update : (Message) -> Unit,
) -> Events {
  { on_url_changed, on_url_request, on_update }
}

///|
/// Trigger the update function with `url_changed` message config by the user.
pub fn Events::trigger_url_changed(self : Events, url : @url.Url) -> Unit {
  (self.on_url_changed)(url)
}

///|
/// Trigger the update function with `url_request` message config by the user.
pub fn Events::trigger_url_request(
  self : Events,
  url : @url.UrlRequest,
) -> Unit {
  (self.on_url_request)(url)
}

///|
/// Trigger the update function with message.
pub fn Events::trigger_update(self : Events, msg : Message) -> Unit {
  (self.on_update)(msg)
}

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
/// fn[M] delay(msg : M, ms : Int) -> Cmd[M] {
///   Cmd(events => set_timeout(() => events.trigger_update(msg), ms))
/// }
///
/// extern "js" fn set_timeout(f : () -> Unit, ms : Int) = "(f,ms) => setTimeout(f, ms)"
/// ```
#alias(Command)
pub(all) struct Cmd((Events) -> Unit)

///|
/// Create a command that does nothing.
pub fn none() -> Cmd {
  Cmd(ignore)
}

///|
/// Create a command that runs multiple commands.
pub fn batch(xs : Array[Cmd]) -> Cmd {
  Cmd(events => xs.each(cmd => (cmd.0)(events)))
}

///|
/// Create a command that trigger another update for the given message.
pub fn task(message : Message) -> Cmd {
  Cmd(events => events.trigger_update(message))
}

///|
/// Create a command that runs an async function.
/// 
/// The async function `f` will be called, and the result will be wrapped in a 
/// message `msg`, then trigger another update with this message.
pub fn[A] perform(msg : (A) -> Message, f : async () -> A noraise) -> Cmd {
  Cmd(events => @js.async_run(() => events.trigger_update(msg(f()))))
}

///|
/// Create a command that runs an async function and handles errors.
/// 
/// This is similar to `perform`, but it converts the returned value 
/// or thrown error into a `Result`.
pub fn[A, E : Error] attempt(
  msg : (Result[A, E]) -> Message,
  f : async () -> A raise E,
) -> Cmd {
  Cmd(events => @js.async_run(() => {
    let msg = try f() catch {
      e => msg(Err(e))
    } noraise {
      r => msg(Ok(r))
    }
    events.trigger_update(msg)
  }))
}
