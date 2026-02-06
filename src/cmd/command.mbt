///|
pub using @runtime {type Cmd, trait Scheduler}

///|
/// Create a command that does nothing.
pub fn none() -> @runtime.Cmd {
  Empty
}

///|
/// Create a command that runs multiple commands.
pub fn batch(xs : Array[@runtime.Cmd]) -> @runtime.Cmd {
  Batch(xs)
}

///|
/// Create a command that runs an async function.
/// 
/// The async function `f` will be called, and the result will be wrapped in a 
/// message `msg`, then trigger another update with this message.
pub fn[A] perform(
  msg : (A) -> @runtime.Cmd,
  f : async () -> A noraise,
) -> @runtime.Cmd {
  Effect(scheduler => @js.async_run(() => scheduler.add(msg(f()))))
}

///|
/// Create a command that runs an async function and handles errors.
/// 
/// This is similar to `perform`, but it converts the returned value 
/// or thrown error into a `Result`.
pub fn[A, E : Error] attempt(
  msg : (Result[A, E]) -> @runtime.Cmd,
  f : async () -> A raise E,
) -> @runtime.Cmd {
  Effect(scheduler => @js.async_run(() => {
    let msg = try f() catch {
      e => msg(Err(e))
    } noraise {
      r => msg(Ok(r))
    }
    scheduler.add(msg)
  }))
}
