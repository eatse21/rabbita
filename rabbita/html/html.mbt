///|
using @runtime {type VNode, type Props, type Cmd}

///|
#alias(T)
pub(all) struct Html(@runtime.VNode)

///|
pub fn Html::to_virtual_dom(self : Html) -> @runtime.VNode {
  self.0
}

///|
fn attributes_to_props(attributes : Array[Attribute]) -> Props {
  let attrs = {}
  let props = {}
  let handlers = {}
  let styles = {}
  for x in attributes {
    match x {
      Style(k, v) => styles[k] = v
      Property(k, v) => props[k] = v
      Attribute(k, v) => attrs[k] = v
      Handler(k, v) => handlers[k] = v
    }
  }
  Props::new(attrs, props, styles, handlers)
}

///|
pub fn[C : IsChildren] node(
  tag : String,
  attributes : Array[Attribute],
  children : C,
) -> Html {
  let props = attributes_to_props(attributes)
  VNode::elem(tag, props, children.to_children())
}

///|

///|
/// Represents an empty element
pub fn nothing() -> Html {
  node("div", [], ([] : Array[Html])) //TODO: use frag instead
}

///|
pub trait IsChildren {
  to_children(Self) -> @runtime.Children[VNode]
}

// ///|
// pub trait IsHtml {
//   to_html(Self) -> @runtime.VNode
// }

// pub impl IsHtml for Html with to_html(self) {
//   self.0
// }

// pub impl IsHtml for Unit with to_html(_) {
//   nothing().0
// }

///|
pub impl IsChildren for Html with to_children(html) {
  Array([html.0])
}

///|
pub impl IsChildren for String with to_children(str) {
  Array([text(str).0])
}

///|
pub impl IsChildren for Map[String, Html] with to_children(self) {
  Map(self.map((_, v) => v.0))
}

///|
pub impl IsChildren for Array[Html] with to_children(self) {
  Array(self.map(x => x.0))
}
// ///|
// pub impl[H : IsHtml] IsChildren for Array[H] with to_children(self) {
//   Array(self.map(x => x.to_html()))
// }

///|
pub impl IsChildren for @runtime.Children[VNode] with to_children(children) {
  children
}

///|
pub fn[C : IsChildren] fragment(children : C) -> Html {
  match children.to_children() {
    Array(nodes) => @runtime.VNode::fragment(nodes)
    Map(nodes) => {
      let values = []
      for _, node in nodes {
        values.push(node)
      }
      @runtime.VNode::fragment(values)
    }
  }
}

///|
pub fn[C : IsChildren] button(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("button", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h1(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h1", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h2(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h2", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h3(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h3", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h4(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h4", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h5(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h5", attrs + extra, children)
}

///|
pub fn[C : IsChildren] h6(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h6", attrs + extra, children)
}

// ------ grouping content ------

///|
pub fn[C : IsChildren] div(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("div", attrs + extra, children)
}

///|
pub fn[C : IsChildren] p(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("p", attrs + extra, children)
}

///|
pub fn[C : IsChildren] hr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("hr", attrs + extra, children)
}

///|
pub fn[C : IsChildren] pre(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("pre", attrs + extra, children)
}

///|
pub fn[C : IsChildren] blockquote(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("blockquote", attrs + extra, children)
}

///|
pub fn[C : IsChildren] section(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("section", attrs + extra, children)
}

///|
pub fn[C : IsChildren] header(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("header", attrs + extra, children)
}

///|
pub fn[C : IsChildren] footer(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("footer", attrs + extra, children)
}

///|
pub fn[C : IsChildren] nav(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("nav", attrs + extra, children)
}

///|
pub fn[C : IsChildren] main_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("main", attrs + extra, children)
}

///|
pub fn[C : IsChildren] article(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("article", attrs + extra, children)
}

///|
pub fn[C : IsChildren] aside(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("aside", attrs + extra, children)
}

///|
pub fn[C : IsChildren] figure(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("figure", attrs + extra, children)
}

///|
pub fn[C : IsChildren] figcaption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("figcaption", attrs + extra, children)
}

///|
pub fn[C : IsChildren] details(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  open? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_open(open, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("details", attrs + extra, children)
}

///|
pub fn[C : IsChildren] summary(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("summary", attrs + extra, children)
}

// ---- text ----

///|
pub fn[C : IsChildren] span(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("span", attrs + extra, children)
}

///|
pub fn[C : IsChildren] small(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("small", attrs + extra, children)
}

///|
pub fn[C : IsChildren] mark(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("mark", attrs + extra, children)
}

///|
pub fn[C : IsChildren] del(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("del", attrs + extra, children)
}

///|
pub fn[C : IsChildren] ins(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ins", attrs + extra, children)
}

///|
pub fn[C : IsChildren] s(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("s", attrs + extra, children)
}

///|
pub fn[C : IsChildren] cite(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("cite", attrs + extra, children)
}

///|
pub fn[C : IsChildren] q(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("q", attrs + extra, children)
}

///|
pub fn[C : IsChildren] abbr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("abbr", attrs + extra, children)
}

///|
pub fn[C : IsChildren] kbd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("kbd", attrs + extra, children)
}

///|
pub fn[C : IsChildren] samp(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("samp", attrs + extra, children)
}

///|
pub fn[C : IsChildren] var_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("var", attrs + extra, children)
}

///|
pub fn[C : IsChildren] time(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  datetime? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_datetime(datetime, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("time", attrs + extra, children)
}

///|
pub fn[C : IsChildren] address(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("address", attrs + extra, children)
}

///|
/// Create `a` element.
/// 
/// # Parameters
/// 
/// - `escape`: an optional boolean that determines whether the link 
///  should be escaped. By default, it is set to `false`. 
/// 
///   When `escape` is set to `true`, clicking the escaped link will cause the browser 
///   to immediately navigate to the `href` target, bypassing any interception logic. 
///   As a result, the `UrlRequest` message will not be triggered.
/// 
/// - `target`: an optional `Target` that specifies where to open the link.
/// 
/// If the user holds the `ctrl` key (or the command key on macOS) while clicking the link,
/// the click event will be handled by the browser, and the `UrlRequest` will not be triggered either.
pub fn[C : IsChildren] a(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  href~ : String,
  target? : Target = Self,
  attrs? : Array[Attribute] = [],
  children : C,
  escape? : Bool = false,
) -> Html {
  let extra = []
  extra.push(Attribute("href", href))
  extra.push(Attribute("target", target.to_string()))
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  @runtime.VNode::link(
    attributes_to_props(attrs + extra),
    children.to_children(),
    escape~,
  )
}

///|
pub fn[C : IsChildren] code(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("code", attrs + extra, children)
}

///|
pub fn[C : IsChildren] em(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("em", attrs + extra, children)
}

///|
pub fn[C : IsChildren] strong(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("strong", attrs + extra, children)
}

///|
pub fn[C : IsChildren] i(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("i", attrs + extra, children)
}

///|
pub fn[C : IsChildren] b(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("b", attrs + extra, children)
}

///|
pub fn[C : IsChildren] u(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("u", attrs + extra, children)
}

///|
pub fn[C : IsChildren] sub(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("sub", attrs + extra, children)
}

///|
pub fn[C : IsChildren] sup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("sup", attrs + extra, children)
}

///|
pub fn text(str : String) -> Html {
  VNode::text(str)
}

// ---- lists ----

///|
pub fn[C : IsChildren] ul(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ul", attrs + extra, children)
}

///|
/// Notice that the `type` attribute for `ol` is not important for the browser now.
/// If you want to change the type of the list, you should use the `list-style-type` property in CSS.
pub fn[C : IsChildren] ol(
  style? : Array[String] = [],
  reversed? : Bool,
  start? : Int,
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_reversed(reversed, extra)
  push_start(start, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ol", attrs + extra, children)
}

///|
pub fn[C : IsChildren] li(
  style? : Array[String] = [],
  value? : Int,
  id? : String,
  class? : String,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_click(click, extra)
  push_value_attr_int(value, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("li", attrs + extra, children)
}

///|
pub fn[C : IsChildren] dl(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dl", attrs + extra, children)
}

///|
pub fn[C : IsChildren] dt(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dt", attrs + extra, children)
}

///|
pub fn[C : IsChildren] dd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dd", attrs + extra, children)
}

// ---- embbded content ----

///|
pub fn[C : IsChildren] img(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  src? : String,
  alt? : String,
  title? : String,
  width? : Int,
  height? : Int,
  border? : Int,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_src(src, extra)
  push_alt(alt, extra)
  push_title(title, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_border(border, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("img", attrs + extra, children)
}

///|
pub fn iframe(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  src? : String,
  title? : String,
  width? : Int,
  height? : Int,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_src(src, extra)
  push_title(title, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("iframe", attrs + extra, ([] : Array[Html]))
}

// ---- inputs ----

///|
pub fn br(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("br", attrs + extra, ([] : Array[Html]))
}

///|
pub(all) enum InputType {
  Button
  Checkbox
  Color
  Date
  DateTimeLocal
  Email
  File
  Hidden
  Image
  Month
  Number
  Password
  Radio
  Range
  Reset
  Search
  Submit
  Tel
  Text
  Time
  Url
  Week
}

///|
pub(all) enum AutoComplete {
  On
  Off
}

///|
pub fn[C : IsChildren] form(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  action? : String,
  name? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_action(action, extra)
  push_name(name, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("form", attrs + extra, children)
}

///|
pub fn[C : IsChildren] label(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  for_? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_for(for_, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("label", attrs + extra, children)
}

///|
pub fn[C : IsChildren] fieldset(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_disabled(disabled, extra)
  push_name(name, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("fieldset", attrs + extra, children)
}

///|
pub fn[C : IsChildren] legend(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("legend", attrs + extra, children)
}

///|
pub fn[C : IsChildren] input(
  input_type? : InputType = Text,
  name? : String,
  value? : String,
  checked? : Bool,
  read_only? : Bool,
  multiple? : Bool,
  accept? : String,
  placeholder? : String,
  auto_complete? : AutoComplete,
  style? : Array[String] = [],
  max? : Int,
  min? : Int,
  step? : Int,
  maxlength? : Int,
  minlength? : Int,
  pattern? : String,
  size? : Int,
  width? : Int,
  height? : Int,
  id? : String,
  class? : String,
  change? : (String) -> Cmd,
  input? : (String) -> Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let input_type = match input_type {
    Button => "button"
    Checkbox => "checkbox"
    Color => "color"
    Date => "date"
    DateTimeLocal => "datetime-local"
    Email => "email"
    File => "file"
    Hidden => "hidden"
    Image => "image"
    Month => "month"
    Number => "number"
    Password => "password"
    Radio => "radio"
    Range => "range"
    Reset => "reset"
    Search => "search"
    Submit => "submit"
    Tel => "tel"
    Text => "text"
    Time => "time"
    Url => "url"
    Week => "week"
  }
  let auto_complete = match auto_complete {
    Some(On) => "on"
    _ => "off"
  }
  let extra = []
  extra.push(attribute("type", input_type))
  extra.push(attribute("autocomplete", auto_complete))
  push_name(name, extra)
  push_value_prop_string(value, extra)
  push_checked(checked, extra)
  push_readonly(read_only, extra)
  push_multiple(multiple, extra)
  push_accept(accept, extra)
  push_max(max, extra)
  push_min(min, extra)
  push_step(step, extra)
  push_maxlength(maxlength, extra)
  push_minlength(minlength, extra)
  push_pattern(pattern, extra)
  push_size(size, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_placeholder(placeholder, extra)
  push_change(change, extra)
  push_input(input, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("input", attrs + extra, children)
}

///|
pub fn[C : IsChildren] textarea(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  name? : String,
  value? : String,
  rows? : Int,
  cols? : Int,
  placeholder? : String,
  read_only? : Bool,
  disabled? : Bool,
  maxlength? : Int,
  minlength? : Int,
  change? : (String) -> Cmd,
  input? : (String) -> Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_name(name, extra)
  push_value_prop_string(value, extra)
  push_rows(rows, extra)
  push_cols(cols, extra)
  push_placeholder(placeholder, extra)
  push_readonly(read_only, extra)
  push_disabled(disabled, extra)
  push_maxlength(maxlength, extra)
  push_minlength(minlength, extra)
  push_change(change, extra)
  push_input(input, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("textarea", attrs + extra, children)
}

///|
pub fn[C : IsChildren] select(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  change? : (String) -> Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  // TODO: support more attribute for select tag
  let extra = []
  push_disabled(disabled, extra)
  push_name(name, extra)
  push_change(change, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("select", attrs + extra, children)
}

///|
pub fn[C : IsChildren] optgroup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  label? : String,
  disabled? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_label(label, extra)
  push_disabled(disabled, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("optgroup", attrs + extra, children)
}

///|
pub fn[C : IsChildren] option(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  value? : String,
  selected? : Bool = false,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  // TODO: support more attribute for option tag

  let extra = []
  push_disabled(disabled, extra)
  push_value_attr_string(value, extra)
  extra.push(property("selected", Boolean(selected)))
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("option", attrs + extra, children)
}

///|
pub fn[C : IsChildren] datalist(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("datalist", attrs + extra, children)
}

///|
pub fn[C : IsChildren] output(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  name? : String,
  for_? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_name(name, extra)
  push_for(for_, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("output", attrs + extra, children)
}

///|
pub fn[C : IsChildren] progress(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  value? : Int,
  max? : Int,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_value_attr_int(value, extra)
  push_max(max, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("progress", attrs + extra, children)
}

///|
pub fn[C : IsChildren] meter(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  value? : Int,
  min? : Int,
  max? : Int,
  low? : Int,
  high? : Int,
  optimum? : Int,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_value_attr_int(value, extra)
  push_min(min, extra)
  push_max(max, extra)
  push_low(low, extra)
  push_high(high, extra)
  push_optimum(optimum, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("meter", attrs + extra, children)
}

// ///|
// pub fn external(
//   node : @dom.Node,
//   attrs : Ref[Array[Attribute]?],
//   width~ : Int,
//   height~ : Int,
// ) -> Html {
//   let attrs = attrs.map(_.map(_.map(x => x.0)))
//   @runtime.external(node, attrs, width~, height~)
// }

// table

///|
pub fn[C : IsChildren] table(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("table", attrs + extra, children)
}

///|
pub fn[C : IsChildren] caption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("caption", attrs + extra, children)
}

///|
pub fn[C : IsChildren] thead(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("thead", attrs + extra, children)
}

///|
pub fn[C : IsChildren] tbody(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tbody", attrs + extra, children)
}

///|
pub fn[C : IsChildren] col(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_span(span, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("col", attrs + extra, children)
}

///|
pub fn[C : IsChildren] colgroup(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_span(span, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("colgroup", attrs + extra, children)
}

///|
pub fn[C : IsChildren] tr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tr", attrs + extra, children)
}

///|
pub fn[C : IsChildren] td(
  style? : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_colspan(colspan, extra)
  push_rowspan(rowspan, extra)
  push_headers(headers, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("td", attrs + extra, children)
}

///|
pub(all) enum Scope {
  Row
  Col
  RowGroup
  ColGroup
}

///|
pub fn[C : IsChildren] th(
  style? : Array[String] = [],
  id? : String,
  abbr? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  scope? : Scope,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_colspan(colspan, extra)
  push_rowspan(rowspan, extra)
  push_headers(headers, extra)
  push_abbr(abbr, extra)
  push_scope(scope, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("th", attrs + extra, children)
}

///|
pub fn[C : IsChildren] tfoot(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tfoot", attrs + extra, children)
}

///|
/// Dialog element. 
/// 
/// Hint: You can use the `show` and `close` commands in the `@dialog` package
/// to manipulate the dialog.
///
/// # Attributes
/// 
/// - `open`: indicates whether the dialog is open or closed by default.
/// 
/// # Messages
/// 
/// - `close`: triggered when the dialog is closed. 
///   
///   The string payload of the `close` message is the return value of the dialog.
/// 
/// - `cancel`: triggered when the user instructs the browser that they wish to 
///   dismiss the current open dialog.
/// 
///   It can be triggered when the user presses `esc` or uses the `request_close` command.
/// 
///   If the `cancel` argument is provided, **the dialog will not close automatically** 
///   after this message is triggered. You can use the `@dialog.close` command 
///   to close it or `@cmd.none` to keep it open.
/// 
/// # Example
/// 
/// ```moonbit skip
/// typealias Model = String
///
/// enum Msg {
///   Open
///   Closed(String)
///   YesNo(Bool)
/// }
///
/// fn update(msg : Msg, model : Model) -> (Cmd[Msg], Model) {
///   match msg {
///     Open => (@dialog.show("confirm"), model)
///     YesNo(answer) => (@dialog.close("confirm", return_value=answer.to_string()), model) 
///     Closed(value) => (none(), value)
///   }
/// }
///
/// fn view(model : Model) -> Html {
///   div([
///     h1([text(model)]),
///     button(click=Msg::Open, [text("open")]),
///     dialog(id="confirm", close=Msg::Closed, [
///       p([text("Are you sure?")]),
///       button(click=YesNo(true), [text("Yes")]),
///       button(click=YesNo(false), [text("No")]),
///     ]),
///   ])
/// }
/// ```
/// 
pub fn[C : IsChildren] dialog(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  open? : Bool,
  close? : (String) -> Cmd,
  cancel? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_open(open, extra)
  push_close(close, extra)
  push_cancel(cancel, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dialog", attrs + extra, children)
}
