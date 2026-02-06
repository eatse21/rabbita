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
  mut attach_count : Int
  id : Id
}

///|
priv struct Link {
  mut val : &Cell?
}

///|
fn Link::detach(s : Self) -> Unit {
  s.val = None
}

///|
fn Link::new(c : &Cell) -> Link {
  { val: Some(c) }
}

///|

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
    attach_count: 0,
    id: Id::new(),
  }
}
