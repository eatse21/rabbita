///|
using @url {type Url, type UrlRequest}

///|
enum Cmd {
  Effect((&Scheduler) -> Unit)
  Message(Id, () -> Unit)
  Batch(Array[Cmd])
  Empty
}

///|
#inline
pub fn message(id : Id, f : () -> Unit) -> Cmd {
  Message(id, f)
}

///|
#inline
pub fn effect(f : (&Scheduler) -> Unit) -> Cmd {
  Effect(f)
}

///|
pub let none : Cmd = Cmd::Empty

///|
#inline
pub fn batch(xs : Array[Cmd]) -> Cmd {
  Batch(xs)
}
