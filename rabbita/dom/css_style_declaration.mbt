///|
#cfg(target="js")
/// The CSSStyleDeclaration interface represents an object that is a CSS declaration block, and exposes style information and various style-related methods and properties.
/// 
/// [mdn](https://developer.mozilla.org/en-US/docs/Web/API/CSSStyleDeclaration)
#external
type CSSStyleDeclaration

///|
#cfg(target="js")
#external
type CSSRule

///|
#cfg(target="js")
pub impl @js.Cast for CSSStyleDeclaration with into(value) {
  value |> ffi_to_css_style_declaration |> y => { y.to_option() }
}

///|
#cfg(target="js")
pub impl @js.Cast for CSSStyleDeclaration with from(value) {
  value |> js_identity
}

///|
#cfg(target="js")
/// Same as `get_property_value`
pub fn CSSStyleDeclaration::op_get(self : Self, property : String) -> String {
  self.get_property_value(property)
}

///|
#cfg(target="js")
/// Same as `set_property`
pub fn CSSStyleDeclaration::op_set(
  self : Self,
  property : String,
  value : String,
) -> Unit {
  self.set_property(property, value)
}

///|
#cfg(target="js")
/// Textual representation of the declaration block, if and only if it is exposed via HTMLElement.style.
pub extern "js" fn CSSStyleDeclaration::get_css_text(self : Self) -> String = "(self) => self.cssText"

///|
#cfg(target="js")
/// Textual representation of the declaration block, if and only if it is exposed via HTMLElement.style.
pub extern "js" fn CSSStyleDeclaration::set_css_text(
  self : Self,
  value : String,
) = "(self, value) => self.cssText = value"

///|
#cfg(target="js")
/// The number of properties.
pub extern "js" fn CSSStyleDeclaration::get_length(self : Self) -> Int = "(self) => self.length"

///|
#cfg(target="js")
/// The containing CSSRule.
pub fn CSSStyleDeclaration::get_parent_rule(self : Self) -> CSSRule? {
  ffi_css_style_declaration_get_parent_rule(self).to_option()
}

///|
#cfg(target="js")
/// Special alias for the float CSS property.
pub extern "js" fn CSSStyleDeclaration::get_css_float(self : Self) -> String = "(self) => self.cssFloat"

///|
#cfg(target="js")
/// Special alias for the float CSS property.
pub extern "js" fn CSSStyleDeclaration::set_css_float(
  self : Self,
  value : String,
) = "(self, value) => self.cssFloat = value"

///|
#cfg(target="js")
/// Returns the optional priority, "important".
pub extern "js" fn CSSStyleDeclaration::get_property_priority(
  self : Self,
  property : String,
) -> String = "(self, property) => self.getPropertyPriority(property)"

///|
#cfg(target="js")
/// Returns the property value given a property name.
pub extern "js" fn CSSStyleDeclaration::get_property_value(
  self : Self,
  property : String,
) -> String = "(self, property) => self.getPropertyValue(property)"

///|
#cfg(target="js")
/// Returns a CSS property name by its index, or the empty string if the index is out-of-bounds.
pub extern "js" fn CSSStyleDeclaration::item(
  self : Self,
  index : Int,
) -> String = "(self, index) => self.item(index)"

///|
#cfg(target="js")
/// Removes a property from the CSS declaration block.
pub extern "js" fn CSSStyleDeclaration::remove_property(
  self : Self,
  property : String,
) -> String = "(self, property) => self.removeProperty(property)"

///|
#cfg(target="js")
/// Modifies an existing CSS property or creates a new CSS property in the declaration block.
pub extern "js" fn CSSStyleDeclaration::set_property(
  self : Self,
  property : String,
  value : String,
) -> Unit = "(self, property, value) => self.setProperty(property, value)"

///|
#cfg(target="js")
/// Modifies an existing CSS property or creates a new CSS property in the declaration block with priority.
// FIXME: Can throw DOMException - ignoring error
pub extern "js" fn CSSStyleDeclaration::set_property_with_priority(
  self : Self,
  property : String,
  value : String,
  priority : String,
) = "(self, property, value, priority) => self.setProperty(property, value, priority)"

///|
#cfg(target="js")
extern "js" fn ffi_css_style_declaration_get_parent_rule(
  s : CSSStyleDeclaration,
) -> @js.Nullable[CSSRule] = "(s) => s.parentRule"

///|
#cfg(target="js")
extern "js" fn ffi_to_css_style_declaration(
  x : @js.Value,
) -> @js.Nullable[CSSStyleDeclaration] = "(x) => x instanceof CSSStyleDeclaration ? x : null"
