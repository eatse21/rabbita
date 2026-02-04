///|
#external
type Text

///|
pub impl @js.Cast for Text with into(value) {
  value |> ffi_to_text |> _.to_option()
}

///|
pub impl @js.Cast for Text with from(value) {
  value |> js_identity
}

///|
pub impl IsEventTarget for Text

///|
pub impl IsNode for Text

///|
pub extern "js" fn Text::to_node(self : Self) -> Node = "(x) => x"
