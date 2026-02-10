///|
struct Mouse(@dom.MouseEvent)

///|
pub(all) struct Pos {
  x : Int
  y : Int
} derive(Show, Debug)

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
struct Keyboard(@dom.KeyboardEvent)

///|
pub fn Keyboard::key(self : Keyboard) -> String {
  self.0.key()
}

///|
pub fn Keyboard::code(self : Keyboard) -> String {
  self.0.code()
}

///|
pub fn Keyboard::alt_key(self : Keyboard) -> Bool {
  self.0.alt_key()
}

///|
pub fn Keyboard::ctrl_key(self : Keyboard) -> Bool {
  self.0.ctrl_key()
}

///|
pub fn Keyboard::shift_key(self : Keyboard) -> Bool {
  self.0.shift_key()
}

///|
pub fn Keyboard::meta_key(self : Keyboard) -> Bool {
  self.0.meta_key()
}

///|
pub fn Keyboard::is_composing(self : Keyboard) -> Bool {
  self.0.is_composing()
}

///|
pub fn Keyboard::repeat(self : Keyboard) -> Bool {
  self.0.repeat()
}

///|
pub fn Keyboard::location(self : Keyboard) -> Int {
  self.0.location()
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
