///|
struct Mouse(@dom.MouseEvent)

///|
pub(all) struct Pos {
  x : Int
  y : Int
}

///|
pub fn Mouse::screen_pos(self : Mouse) -> Pos {
  { x: self.0.get_screen_x(), y: self.0.get_screen_y() }
}

///|
pub fn Mouse::offset_pos(self : Mouse) -> Pos {
  { x: self.0.get_offset_x(), y: self.0.get_offset_y() }
}

///|
pub fn Mouse::client_pos(self : Mouse) -> Pos {
  { x: self.0.get_client_x(), y: self.0.get_client_y() }
}

///|
struct Scroll(@dom.Element)

///|
pub fn Scroll::offset_pos(self : Self) -> Pos {
  { x: self.0.get_scroll_left().to_int(), y: self.0.get_scroll_top().to_int() }
}

///|
pub fn Scroll::width(self : Self) -> Int {
  self.0.get_scroll_width().to_int()
}

///|
pub fn Scroll::height(self : Self) -> Int {
  self.0.get_scroll_height().to_int()
}

///|
fn on_mouse(event : String, msg : (Mouse) -> Cmd) -> Attribute {
  Handler(event, (event, scheduler) => scheduler.add(
    msg(event.to_mouse_event().unwrap()),
  ))
}

///|
pub fn on_click(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("click", msg)
}

///|
pub fn on_input(msg : (String) -> Cmd) -> Attribute {
  Handler("input", (event, scheduler) => {
    let value : String = event.target().to_html_input_element().unwrap().value()
    scheduler.add(msg(value))
  })
}

///|
pub fn on_change(msg : (String) -> Cmd) -> Attribute {
  Handler("change", (event, scheduler) => {
    let target = event.target()
    let value = if target.to_html_input_element() is Some(x) {
      x.value()
    } else if target.to_html_select_element() is Some(x) {
      x.value()
    } else {
      panic() // TODO: check for other HTMLElement types
    }
    scheduler.add(msg(value))
  })
}

///|
pub fn on_double_click(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("dblclick", msg)
}

///|
pub fn on_mouse_down(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mousedown", msg)
}

///|
pub fn on_mouse_up(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mouseup", msg)
}

///|
pub fn on_mouse_move(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mousemove", msg)
}

///|
pub fn on_mouse_enter(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mouseenter", msg)
}

///|
pub fn on_mouse_over(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mouseover", msg)
}

///|
pub fn on_mouse_leave(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mouseleave", msg)
}

///|
pub fn on_mouse_out(msg : (Mouse) -> Cmd) -> Attribute {
  on_mouse("mouseout", msg)
}

///|
pub fn on_scroll(msg : (Scroll) -> Cmd) -> Attribute {
  Handler("scroll", (event, scheduler) => scheduler.add(
    msg(event.target().to_element().unwrap()),
  ))
}
