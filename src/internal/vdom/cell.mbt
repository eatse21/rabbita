///|
pub(open) trait Cell {
  step(Self, &Scheduler) -> Unit
  view(Self) -> VNode
  state(Self) -> State
}

///|
struct State {
  mut inode : INode?
  mut childs : Set[Id]
  mut dirty : Bool
  id : Id
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
  { inode: None, childs: Set::new(), dirty: true, id: Id::new() }
}
