///|
#cfg(target="js")
#external
type Document

///|
#cfg(target="js")
pub extern "js" fn document() -> Document = "() => document"

///|
#cfg(target="js")
pub extern "js" fn Document::create_element(
  self : Self,
  tag : String,
) -> Element = "(doc,tag) => doc.createElement(tag)"

///|
#cfg(target="js")
pub let namespace_html = "http://www.w3.org/1999/xhtml"

///|
#cfg(target="js")
pub let namespace_svg = "http://www.w3.org/2000/svg"

///|
#cfg(target="js")
pub let namespace_mathml = "http://www.w3.org/1998/Math/MathML"

///|
#cfg(target="js")
pub extern "js" fn Document::create_element_ns(
  self : Self,
  namespace_uri : String,
  qualified_name : String,
  on_namespace_error? : (DOMException) -> Element = default_exception_handler,
  on_invalid_character_error? : (DOMException) -> Element = default_exception_handler,
) -> Element = "(doc,namespace,qualifiedName) => doc.createElementNS(namespace, qualifiedName)"

///|
#cfg(target="js")
pub extern "js" fn Document::create_text_node(
  self : Self,
  str : String,
) -> Element = "(doc,str) => doc.createTextNode(str)"

///|
#cfg(target="js")
pub extern "js" fn Document::create_comment(
  self : Self,
  str : String,
) -> Comment = "(doc,str) => doc.createComment(str)"

///|
#cfg(target="js")
pub extern "js" fn Document::create_document_fragment(
  self : Self,
) -> DocumentFragment = "(doc) => doc.createDocumentFragment()"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementById
pub extern "js" fn Document::get_element_by_id(
  self : Self,
  id : String,
) -> @js.Nullable[Element] = "(doc,id) => doc.getElementById(id)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByClassName
pub extern "js" fn Document::get_elements_by_class_name(
  self : Self,
  names : String,
) -> HTMLCollection = "(doc,names) => doc.getElementsByClassName(names)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByName
pub extern "js" fn Document::get_elements_by_name(
  self : Self,
  name : String,
) -> NodeList = "(doc,name) => doc.getElementsByName(name)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagName
pub extern "js" fn Document::get_elements_by_tag_name(
  self : Self,
  tag : String,
) -> HTMLCollection = "(doc,tag) => doc.getElementsByTagName(tag)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/getElementsByTagNameNS
pub extern "js" fn Document::get_elements_by_tag_name_ns(
  self : Self,
  namespace_ : String,
  name : String,
) -> HTMLCollection = "(doc,namespace,name) => doc.getElementsByTagNameNS(namespace, name)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector
pub extern "js" fn Document::query_selector(
  self : Self,
  selectors : String,
) -> @js.Nullable[Element] = "(self,selectors) => self.querySelector(selectors)"

///|
#cfg(target="js")
/// https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll
pub extern "js" fn Document::query_selector_all(
  self : Self,
  selectors : String,
) -> NodeList = "(self,selectors) => self.querySelectorAll(selectors)"

///|
#cfg(target="js")
pub extern "js" fn Document::to_node(self : Self) -> Node = "(x) => x"
