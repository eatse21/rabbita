///|
pub(open) trait Cell {
  step(Self, &Scheduler) -> Unit
  view(Self) -> VNode
  state(Self) -> State
}

///|
struct State {
  mut inode : INode?
  mut childs : Map[Id, Link]
  mut parent_link : Link
  mut dirty : Bool
  id : Id
}

///|
priv struct Link {
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
    childs: {},
    dirty: true,
    id: Id::new(),
    parent_link: Link::empty(),
  }
}
