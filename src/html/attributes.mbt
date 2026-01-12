///|
enum Attribute {
  Attribute(String, String)
  Property(String, @variant.Variant)
  Style(String, String)
  Handler(String, (@dom.Event, &@vdom.Scheduler) -> Unit)
}

///|
/// Specify an style
pub fn style(key : String, value : String) -> Attribute {
  Style(key, value)
}

///|
pub fn attribute(key : String, value : String) -> Attribute {
  Attribute(key, value)
}

///|
pub fn property(key : String, value : @variant.Variant) -> Attribute {
  Property(key, value)
}

///|
pub fn href(value : String) -> Attribute {
  // Note: `href` will be the value you specified, but by property, the value 
  // will be resolved to an absolute URL.
  Property("href", String(value))
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
  Attribute("target", value.to_string())
}
