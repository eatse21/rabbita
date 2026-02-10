///|
using @url {type Url, type UrlRequest}

///|
pub(all) enum Cmd {
  Effect((&Scheduler) -> Unit)
  Message(Id, () -> Unit)
  Batch(Array[Cmd])
  Empty
}

///|
/// A command that does nothing.
pub let none : Cmd = Cmd::Empty

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
  Effect(scheduler => @js.async_run(() => scheduler.add(msg(f()))))
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
  Effect(scheduler => {
    @js.async_run(() => {
      let msg = try f() catch {
        e => msg(Err(e))
      } noraise {
        r => msg(Ok(r))
      }
      scheduler.add(msg)
    })
  })
}
