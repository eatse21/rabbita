///|
struct Id {
  mut value : Int?
} derive(Eq, Hash, Compare, Show)

///|
pub fn Id::new() -> Id {
  { value: None }
}
