///|
#external
type Comment

///|
pub impl @js.Cast for Comment with into(value) {
  value |> ffi_to_comment |> _.to_option()
}

///|
pub impl @js.Cast for Comment with from(value) {
  value |> js_identity
}

pub impl IsEventTarget for Comment
///|
pub impl IsNode for Comment

///|
pub extern "js" fn Comment::to_node(self : Self) -> Node = "(x) => x"
