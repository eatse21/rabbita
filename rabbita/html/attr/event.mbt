///|
using @runtime {type Cmd}

///|
fn on_mouse_event(event : String, msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_mouse_event().unwrap()),
  ))
}

///|
fn on_keyboard_event(
  event : String,
  msg : (@dom.KeyboardEvent) -> Cmd,
) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_keyboard_event().unwrap()),
  ))
}

///|
fn on_focus_event(event : String, msg : (@dom.FocusEvent) -> Cmd) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_focus_event().unwrap()),
  ))
}

///|
fn on_drag_event(event : String, msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_drag_event().unwrap()),
  ))
}

///|
fn on_clipboard_event(
  event : String,
  msg : (@dom.ClipboardEvent) -> Cmd,
) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_clipboard_event().unwrap()),
  ))
}

///|
fn on_composition_event(
  event : String,
  msg : (@dom.CompositionEvent) -> Cmd,
) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_composition_event().unwrap()),
  ))
}

///|
fn on_wheel_event(event : String, msg : (@dom.WheelEvent) -> Cmd) -> Attribute {
  handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_wheel_event().unwrap()),
  ))
}

///|
pub fn on_click(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("click", msg)
}

///|
pub fn on_dblclick(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("dblclick", msg)
}

///|
pub fn on_dbclick(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_dblclick(msg)
}

///|
pub fn on_mousedown(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mousedown", msg)
}

///|
pub fn on_mouseup(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mouseup", msg)
}

///|
pub fn on_mousemove(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mousemove", msg)
}

///|
pub fn on_mouseenter(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mouseenter", msg)
}

///|
pub fn on_mouseover(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mouseover", msg)
}

///|
pub fn on_mouseleave(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mouseleave", msg)
}

///|
pub fn on_mouseout(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("mouseout", msg)
}

///|
pub fn on_contextmenu(msg : (@dom.MouseEvent) -> Cmd) -> Attribute {
  on_mouse_event("contextmenu", msg)
}

///|
pub fn on_scroll(msg : (@dom.UIEvent) -> Cmd) -> Attribute {
  handler("scroll", (event, scheduler) => scheduler.add(
    msg(event.to_ui_event().unwrap()),
  ))
}

///|
pub fn on_wheel(msg : (@dom.WheelEvent) -> Cmd) -> Attribute {
  on_wheel_event("wheel", msg)
}

///|
pub fn on_input(msg : (@dom.InputEvent) -> Cmd) -> Attribute {
  handler("input", (event, scheduler) => scheduler.add(
    msg(event.to_input_event().unwrap()),
  ))
}

///|
pub fn on_change(msg : (@dom.InputEvent) -> Cmd) -> Attribute {
  handler("change", (event, scheduler) => scheduler.add(
    msg(event.to_input_event().unwrap()),
  ))
}

///|
pub fn on_focus(msg : (@dom.FocusEvent) -> Cmd) -> Attribute {
  on_focus_event("focus", msg)
}

///|
pub fn on_blur(msg : (@dom.FocusEvent) -> Cmd) -> Attribute {
  on_focus_event("blur", msg)
}

///|
pub fn on_keydown(msg : (@dom.KeyboardEvent) -> Cmd) -> Attribute {
  on_keyboard_event("keydown", msg)
}

///|
pub fn on_keyup(msg : (@dom.KeyboardEvent) -> Cmd) -> Attribute {
  on_keyboard_event("keyup", msg)
}

///|
pub fn on_submit(msg : (@dom.Event) -> Cmd) -> Attribute {
  handler("submit", (event, scheduler) => scheduler.add(msg(event)))
}

///|
pub fn on_reset(msg : (@dom.Event) -> Cmd) -> Attribute {
  handler("reset", (event, scheduler) => scheduler.add(msg(event)))
}

///|
pub fn on_dragstart(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("dragstart", msg)
}

///|
pub fn on_dragover(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("dragover", msg)
}

///|
pub fn on_dragenter(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("dragenter", msg)
}

///|
pub fn on_dragleave(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("dragleave", msg)
}

///|
pub fn on_dragend(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("dragend", msg)
}

///|
pub fn on_drop(msg : (@dom.DragEvent) -> Cmd) -> Attribute {
  on_drag_event("drop", msg)
}

///|
pub fn on_copy(msg : (@dom.ClipboardEvent) -> Cmd) -> Attribute {
  on_clipboard_event("copy", msg)
}

///|
pub fn on_cut(msg : (@dom.ClipboardEvent) -> Cmd) -> Attribute {
  on_clipboard_event("cut", msg)
}

///|
pub fn on_paste(msg : (@dom.ClipboardEvent) -> Cmd) -> Attribute {
  on_clipboard_event("paste", msg)
}

///|
pub fn on_compositionstart(msg : (@dom.CompositionEvent) -> Cmd) -> Attribute {
  on_composition_event("compositionstart", msg)
}

///|
pub fn on_compositionupdate(msg : (@dom.CompositionEvent) -> Cmd) -> Attribute {
  on_composition_event("compositionupdate", msg)
}

///|
pub fn on_compositionend(msg : (@dom.CompositionEvent) -> Cmd) -> Attribute {
  on_composition_event("compositionend", msg)
}
