///|
pub(all) enum Cmd {
  Effect((&Scheduler) -> Unit)
  Message(Id, () -> Unit)
  Batch(Array[Cmd])
  Empty
}

///|
struct Id {
  mut value : Int?
} derive(Eq, Hash, Compare, Show)

///|
pub fn Id::new() -> Id {
  { value: None }
}
