///|
pub(all) enum Item {
  Text(String)
}

///|
/// Returns a command that copies the given item to the clipboard.
/// 
/// # Message
/// 
/// - `copied` is triggered if the copy operation is successful.
/// - `failed` is triggered with the error message if the copy operation fails.
pub fn copy(
  item : Item,
  copied? : @cmd.Effect,
  failed? : (String) -> @cmd.Effect,
) -> @cmd.Effect {
  Effect(scheduler => @js.async_run(() => try {
    guard item is Text(text)  //TODO: support other formats
    @dom.window().navigator().clipboard().write_text(text).wait() |> ignore
    match copied {
      Some(msg) => scheduler.pending(msg)
      None => ()
    }
  } catch {
    e =>
      match failed {
        Some(to_msg) => scheduler.pending(to_msg(e.to_string()))
        None => ()
      }
  }))
}

///|
/// Returns a command that pastes the clipboard content and returns it as an item.
/// 
/// # Message
/// - `pasted` is triggered with the pasted item if the paste operation is successful.
/// - `failed` is triggered with the error message if the paste operation fails.
pub fn paste(
  pasted~ : (Item) -> @cmd.Effect,
  failed? : (String) -> @cmd.Effect,
) -> Cmd {
  Effect(scheduler => @js.async_run(() => try {
    // TODO: support other formats
    let str : String = @dom.window().navigator().clipboard().read_text().wait()
      |> @js.Value::cast()
    scheduler.pending(pasted(Text(str)))
  } catch {
    e =>
      match failed {
        Some(to_msg) => scheduler.pending(to_msg(e.to_string()))
        None => ()
      }
  }))
}
