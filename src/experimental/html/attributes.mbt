// ///|
// priv struct Attribute[Msg](@runtime.Attribute[Msg])

// ///| Specify an style
// // fn[Msg] style_(key : String, value : String) -> Attribute[Msg] {
// //   @runtime.style(key, value)
// // }

// ///|
// fn[Msg] attribute(key : String, value : String) -> Attribute[Msg] {
//   @runtime.attribute(key, value)
// }

// ///|
// fn[M] property(key : String, value : @variant.Variant) -> Attribute[M] {
//   @runtime.property(key, value)
// }

// ///|
// // fn[Msg] href(value : String) -> Attribute[Msg] {
// //   // Note: `href` will be the value you specified, but by property, the value 
// //   // will be resolved to an absolute URL.
// //   @runtime.property("href", @variant.String(value))
// // }

// ///|
// // pub(all) enum Target {
// //   Self
// //   Blank
// // }

// ///|
// // fn to_string(self : Target) -> String {
// //   match self {
// //     Self => "_self"
// //     Blank => "_blank"
// //   }
// // }

// ///|
// // fn[Msg] target(value : Target) -> Attribute[Msg] {
// //   @runtime.attribute("target", value.to_string())
// // }
