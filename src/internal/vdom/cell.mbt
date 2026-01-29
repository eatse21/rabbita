///|
pub(open) trait Cell {
  id(Self) -> Id
  step(Self, &Scheduler) -> Unit
  dirty_flag(Self) -> Bool
  view(Self) -> VNode
  inode(Self) -> Ref[INode?]
}
