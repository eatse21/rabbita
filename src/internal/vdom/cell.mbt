///|
pub(open) trait Cell {
  id(Self) -> Id
  step(Self, &Scheduler) -> Unit
  node(Self) -> VNode
  refersh(Self) -> Unit
  dirty_flag(Self) -> Bool
}

