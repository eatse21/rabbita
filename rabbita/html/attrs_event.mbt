///|
fn Attrs::on_mouse_event(
  self : Attrs,
  event : String,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_mouse_event().unwrap()),
  ))
}

///|
fn Attrs::on_keyboard_event(
  self : Attrs,
  event : String,
  msg : (@dom.KeyboardEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_keyboard_event().unwrap()),
  ))
}

///|
fn Attrs::on_focus_event(
  self : Attrs,
  event : String,
  msg : (@dom.FocusEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_focus_event().unwrap()),
  ))
}

///|
fn Attrs::on_drag_event(
  self : Attrs,
  event : String,
  msg : (@dom.DragEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_drag_event().unwrap()),
  ))
}

///|
fn Attrs::on_clipboard_event(
  self : Attrs,
  event : String,
  msg : (@dom.ClipboardEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_clipboard_event().unwrap()),
  ))
}

///|
fn Attrs::on_composition_event(
  self : Attrs,
  event : String,
  msg : (@dom.CompositionEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_composition_event().unwrap()),
  ))
}

///|
fn Attrs::on_wheel_event(
  self : Attrs,
  event : String,
  msg : (@dom.WheelEvent) -> Cmd,
) -> Attrs {
  self.handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_wheel_event().unwrap()),
  ))
}

///|
pub fn Attrs::on_click(self : Attrs, msg : (@dom.MouseEvent) -> Cmd) -> Attrs {
  self.on_mouse_event("click", msg)
}

///|
pub fn Attrs::on_dblclick(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("dblclick", msg)
}

///|
pub fn Attrs::on_dbclick(self : Attrs, msg : (@dom.MouseEvent) -> Cmd) -> Attrs {
  self.on_dblclick(msg)
}

///|
pub fn Attrs::on_mousedown(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mousedown", msg)
}

///|
pub fn Attrs::on_mouseup(self : Attrs, msg : (@dom.MouseEvent) -> Cmd) -> Attrs {
  self.on_mouse_event("mouseup", msg)
}

///|
pub fn Attrs::on_mousemove(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mousemove", msg)
}

///|
pub fn Attrs::on_mouseenter(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mouseenter", msg)
}

///|
pub fn Attrs::on_mouseover(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mouseover", msg)
}

///|
pub fn Attrs::on_mouseleave(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mouseleave", msg)
}

///|
pub fn Attrs::on_mouseout(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("mouseout", msg)
}

///|
pub fn Attrs::on_contextmenu(
  self : Attrs,
  msg : (@dom.MouseEvent) -> Cmd,
) -> Attrs {
  self.on_mouse_event("contextmenu", msg)
}

///|
pub fn Attrs::on_scroll(self : Attrs, msg : (@dom.UIEvent) -> Cmd) -> Attrs {
  self.handler("scroll", (event, scheduler) => scheduler.add(
    msg(event.to_ui_event().unwrap()),
  ))
}

///|
pub fn Attrs::on_wheel(self : Attrs, msg : (@dom.WheelEvent) -> Cmd) -> Attrs {
  self.on_wheel_event("wheel", msg)
}

///|
pub fn Attrs::on_input(self : Attrs, msg : (@dom.InputEvent) -> Cmd) -> Attrs {
  self.handler("input", (event, scheduler) => scheduler.add(
    msg(event.to_input_event().unwrap()),
  ))
}

///|
pub fn Attrs::on_change(self : Attrs, msg : (@dom.InputEvent) -> Cmd) -> Attrs {
  self.handler("change", (event, scheduler) => scheduler.add(
    msg(event.to_input_event().unwrap()),
  ))
}

///|
pub fn Attrs::on_focus(self : Attrs, msg : (@dom.FocusEvent) -> Cmd) -> Attrs {
  self.on_focus_event("focus", msg)
}

///|
pub fn Attrs::on_blur(self : Attrs, msg : (@dom.FocusEvent) -> Cmd) -> Attrs {
  self.on_focus_event("blur", msg)
}

///|
pub fn Attrs::on_keydown(
  self : Attrs,
  msg : (@dom.KeyboardEvent) -> Cmd,
) -> Attrs {
  self.on_keyboard_event("keydown", msg)
}

///|
pub fn Attrs::on_keyup(
  self : Attrs,
  msg : (@dom.KeyboardEvent) -> Cmd,
) -> Attrs {
  self.on_keyboard_event("keyup", msg)
}

///|
pub fn Attrs::on_submit(self : Attrs, msg : (@dom.Event) -> Cmd) -> Attrs {
  self.handler("submit", (event, scheduler) => scheduler.add(msg(event)))
}

///|
pub fn Attrs::on_reset(self : Attrs, msg : (@dom.Event) -> Cmd) -> Attrs {
  self.handler("reset", (event, scheduler) => scheduler.add(msg(event)))
}

///|
pub fn Attrs::on_dragstart(
  self : Attrs,
  msg : (@dom.DragEvent) -> Cmd,
) -> Attrs {
  self.on_drag_event("dragstart", msg)
}

///|
pub fn Attrs::on_dragover(self : Attrs, msg : (@dom.DragEvent) -> Cmd) -> Attrs {
  self.on_drag_event("dragover", msg)
}

///|
pub fn Attrs::on_dragenter(
  self : Attrs,
  msg : (@dom.DragEvent) -> Cmd,
) -> Attrs {
  self.on_drag_event("dragenter", msg)
}

///|
pub fn Attrs::on_dragleave(
  self : Attrs,
  msg : (@dom.DragEvent) -> Cmd,
) -> Attrs {
  self.on_drag_event("dragleave", msg)
}

///|
pub fn Attrs::on_dragend(self : Attrs, msg : (@dom.DragEvent) -> Cmd) -> Attrs {
  self.on_drag_event("dragend", msg)
}

///|
pub fn Attrs::on_drop(self : Attrs, msg : (@dom.DragEvent) -> Cmd) -> Attrs {
  self.on_drag_event("drop", msg)
}

///|
pub fn Attrs::on_copy(
  self : Attrs,
  msg : (@dom.ClipboardEvent) -> Cmd,
) -> Attrs {
  self.on_clipboard_event("copy", msg)
}

///|
pub fn Attrs::on_cut(self : Attrs, msg : (@dom.ClipboardEvent) -> Cmd) -> Attrs {
  self.on_clipboard_event("cut", msg)
}

///|
pub fn Attrs::on_paste(
  self : Attrs,
  msg : (@dom.ClipboardEvent) -> Cmd,
) -> Attrs {
  self.on_clipboard_event("paste", msg)
}

///|
pub fn Attrs::on_compositionstart(
  self : Attrs,
  msg : (@dom.CompositionEvent) -> Cmd,
) -> Attrs {
  self.on_composition_event("compositionstart", msg)
}

///|
pub fn Attrs::on_compositionupdate(
  self : Attrs,
  msg : (@dom.CompositionEvent) -> Cmd,
) -> Attrs {
  self.on_composition_event("compositionupdate", msg)
}

///|
pub fn Attrs::on_compositionend(
  self : Attrs,
  msg : (@dom.CompositionEvent) -> Cmd,
) -> Attrs {
  self.on_composition_event("compositionend", msg)
}
