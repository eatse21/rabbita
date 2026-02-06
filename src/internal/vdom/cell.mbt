///|
pub(open) trait Cell {
  step(Self, &Scheduler) -> Unit
  view(Self) -> VNode
  state(Self) -> State
}

///|
struct State {
  mut inode : INode?
  mut old_childs : Map[Id, Link]
  mut new_childs : Map[Id, Link]
  mut dirty : Bool
  id : Id
}

///|
struct Link {
  mut link : &Cell?
}

///|
fn Link::detach(s : Self) -> Unit {
  s.link = None
}

///|
fn Link::new(c : &Cell) -> Link {
  { link: Some(c) }
}

///|
fn Link::empty() -> Link {
  { link: None }
}

///|
pub fn State::id(s : Self) -> Id {
  s.id
}

///|
pub fn State::mark_dirty(s : Self) -> Unit {
  s.dirty = true
}

///|
pub fn State::new() -> State {
  {
    inode: None,
    new_childs: {},
    old_childs: {},
    dirty: true,
    id: Id::new(),
  }
}
