///|
#external
type DocumentFragment

///|
pub impl @js.Cast for DocumentFragment with into(value) {
  value |> ffi_to_document_fragment |> _.to_option()
}

///|
pub impl @js.Cast for DocumentFragment with from(value) {
  value |> js_identity
}

pub impl IsEventTarget for DocumentFragment
///|
pub impl IsNode for DocumentFragment

///|
pub extern "js" fn DocumentFragment::to_node(self : Self) -> Node = "(x) => x"
