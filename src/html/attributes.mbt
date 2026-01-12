///|
struct Attribute(@vdom.Attribute)

///|
/// Specify an style
pub fn style(key : String, value : String) -> Attribute {
  @vdom.style(key, value)
}

///|
pub fn attribute(key : String, value : String) -> Attribute {
  @vdom.attribute(key, value)
}

///|
pub fn property(key : String, value : @variant.Variant) -> Attribute {
  @vdom.property(key, value)
}

///|
pub fn href(value : String) -> Attribute {
  // Note: `href` will be the value you specified, but by property, the value 
  // will be resolved to an absolute URL.
  @vdom.property("href", @variant.String(value))
}

///|
pub(all) enum Target {
  Self
  Blank
}

///|
fn Target::to_string(self : Target) -> String {
  match self {
    Self => "_self"
    Blank => "_blank"
  }
}

///|
pub fn target(value : Target) -> Attribute {
  @vdom.attribute("target", value.to_string())
}
