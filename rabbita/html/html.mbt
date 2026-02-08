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
#inline
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
fn[C : IsChildren] common_node(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  tag : String,
  attributes : Array[Attribute],
  children : C,
) -> Html {
  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if class is Some(class) {
    attrs.push(attribute("class", class))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  node(tag, attributes + attrs, children)
}

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
  children : C,
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  common_node(style~, class?, id?, "button", attrs, children)
}

///|
pub fn[C : IsChildren] h1(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h1", [], children)
}

///|
pub fn[C : IsChildren] h2(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h2", [], children)
}

///|
pub fn[C : IsChildren] h3(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h3", [], children)
}

///|
pub fn[C : IsChildren] h4(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h4", [], children)
}

///|
pub fn[C : IsChildren] h5(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h5", [], children)
}

///|
pub fn[C : IsChildren] h6(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "h6", [], children)
}

// ------ grouping content ------

///|
pub fn[C : IsChildren] div(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  children : C,
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  common_node(style~, class?, id?, "div", attrs, children)
}

///|
pub fn[C : IsChildren] p(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "p", [], children)
}

///|
pub fn[C : IsChildren] hr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "hr", [], children)
}

///|
pub fn[C : IsChildren] pre(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "pre", [], children)
}

///|
pub fn[C : IsChildren] blockquote(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "blockquote", [], children)
}

///|
pub fn[C : IsChildren] section(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "section", [], children)
}

///|
pub fn[C : IsChildren] header(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "header", [], children)
}

///|
pub fn[C : IsChildren] footer(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "footer", [], children)
}

///|
pub fn[C : IsChildren] nav(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "nav", [], children)
}

///|
pub fn[C : IsChildren] main_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "main", [], children)
}

///|
pub fn[C : IsChildren] article(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "article", [], children)
}

///|
pub fn[C : IsChildren] aside(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "aside", [], children)
}

///|
pub fn[C : IsChildren] figure(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "figure", [], children)
}

///|
pub fn[C : IsChildren] figcaption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "figcaption", [], children)
}

///|
pub fn[C : IsChildren] details(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  open? : Bool,
  children : C,
) -> Html {
  let attrs = []
  if open is Some(open) {
    attrs.push(property("open", Boolean(open)))
  }
  common_node(style~, class?, id?, "details", attrs, children)
}

///|
pub fn[C : IsChildren] summary(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "summary", [], children)
}

// ---- text ----

///|
pub fn[C : IsChildren] span(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "span", [], children)
}

///|
pub fn[C : IsChildren] small(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "small", [], children)
}

///|
pub fn[C : IsChildren] mark(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "mark", [], children)
}

///|
pub fn[C : IsChildren] del(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "del", [], children)
}

///|
pub fn[C : IsChildren] ins(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "ins", [], children)
}

///|
pub fn[C : IsChildren] s(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "s", [], children)
}

///|
pub fn[C : IsChildren] cite(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "cite", [], children)
}

///|
pub fn[C : IsChildren] q(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "q", [], children)
}

///|
pub fn[C : IsChildren] abbr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "abbr", [], children)
}

///|
pub fn[C : IsChildren] kbd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "kbd", [], children)
}

///|
pub fn[C : IsChildren] samp(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "samp", [], children)
}

///|
pub fn[C : IsChildren] var_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "var", [], children)
}

///|
pub fn[C : IsChildren] time(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  datetime? : String,
  children : C,
) -> Html {
  let attrs = []
  if datetime is Some(datetime) {
    attrs.push(attribute("datetime", datetime))
  }
  common_node(style~, class?, id?, "time", attrs, children)
}

///|
pub fn[C : IsChildren] address(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "address", [], children)
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
  children : C,
  escape? : Bool = false,
) -> Html {
  let attrs = [Attribute("href", href), Attribute("target", target.to_string())]
  if style.length() > 0 {
    attrs.push(Attribute("style", style.join(";")))
  }
  if class is Some(class) {
    attrs.push(Attribute("class", class))
  }
  if id is Some(id) {
    attrs.push(Attribute("id", id))
  }
  @runtime.VNode::link(
    attributes_to_props(attrs),
    children.to_children(),
    escape~,
  )
}

///|
pub fn[C : IsChildren] code(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "code", [], children)
}

///|
pub fn[C : IsChildren] em(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "em", [], children)
}

///|
pub fn[C : IsChildren] strong(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "strong", [], children)
}

///|
pub fn[C : IsChildren] i(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "i", [], children)
}

///|
pub fn[C : IsChildren] b(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "b", [], children)
}

///|
pub fn[C : IsChildren] u(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "u", [], children)
}

///|
pub fn[C : IsChildren] sub(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "sub", [], children)
}

///|
pub fn[C : IsChildren] sup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "sup", [], children)
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
  children : C,
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  common_node(style~, class?, id?, "ul", attrs, children)
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
  children : C,
) -> Html {
  let attrs = []
  if reversed is Some(reversed) {
    // TODO: test this attribute
    attrs.push(attribute("reversed", reversed.to_string()))
  }
  if start is Some(start) {
    // TODO: test this attribute
    attrs.push(attribute("start", start.to_string()))
  }
  common_node(style~, class?, id?, "ol", attrs, children)
}

///|
pub fn[C : IsChildren] li(
  style? : Array[String] = [],
  value? : Int,
  id? : String,
  class? : String,
  click? : Cmd,
  children : C,
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  if value is Some(value) {
    attrs.push(attribute("value", value.to_string()))
  }
  common_node(style~, class?, id?, "li", attrs, children)
}

///|
pub fn[C : IsChildren] dl(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "dl", [], children)
}

///|
pub fn[C : IsChildren] dt(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "dt", [], children)
}

///|
pub fn[C : IsChildren] dd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "dd", [], children)
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
  children : C,
) -> Html {
  let attrs = []
  if src is Some(src) {
    attrs.push(attribute("src", src))
  }
  if alt is Some(alt) {
    attrs.push(attribute("alt", alt))
  }
  if title is Some(title) {
    attrs.push(attribute("title", title))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  if border is Some(border) {
    attrs.push(attribute("border", border.to_string()))
  }
  common_node(style~, class?, id?, "img", attrs, children)
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
) -> Html {
  let attrs = []
  if src is Some(src) {
    attrs.push(attribute("src", src))
  }
  if title is Some(title) {
    attrs.push(attribute("title", title))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  common_node(style~, class?, id?, "iframe", attrs, ([] : Array[Html]))
}

// ---- inputs ----

///|
pub fn br(style? : Array[String] = [], id? : String, class? : String) -> Html {
  common_node(style~, class?, id?, "br", [], ([] : Array[Html]))
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
  children : C,
) -> Html {
  let attrs = []
  if action is Some(action) {
    attrs.push(attribute("action", action))
  }
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  common_node(style~, class?, id?, "form", attrs, children)
}

///|
pub fn[C : IsChildren] label(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  for_? : String,
  children : C,
) -> Html {
  let attrs = []
  if for_ is Some(for_) {
    attrs.push(attribute("for", for_))
  }
  common_node(style~, class?, id?, "label", attrs, children)
}

///|
pub fn[C : IsChildren] fieldset(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  children : C,
) -> Html {
  let attrs = []
  if disabled is Some(disabled) {
    attrs.push(property("disabled", Boolean(disabled)))
  }
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  common_node(style~, class?, id?, "fieldset", attrs, children)
}

///|
pub fn[C : IsChildren] legend(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "legend", [], children)
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
  let attrs = []
  attrs.push(attribute("type", input_type))
  attrs.push(attribute("autocomplete", auto_complete))
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if value is Some(value) {
    attrs.push(property("value", String(value)))
  }
  if checked is Some(checked) {
    attrs.push(property("checked", Boolean(checked)))
  }
  if read_only is Some(read_only) {
    attrs.push(property("readonly", Boolean(read_only)))
  }
  if multiple is Some(multiple) {
    attrs.push(property("multiple", Boolean(multiple)))
  }
  if accept is Some(accept) {
    attrs.push(attribute("accept", accept))
  }
  if max is Some(max) {
    attrs.push(attribute("max", max.to_string()))
  }
  if min is Some(min) {
    attrs.push(attribute("min", min.to_string()))
  }
  if step is Some(step) {
    attrs.push(attribute("step", step.to_string()))
  }
  if maxlength is Some(maxlength) {
    attrs.push(attribute("maxlength", maxlength.to_string()))
  }
  if minlength is Some(minlength) {
    attrs.push(attribute("minlength", minlength.to_string()))
  }
  if pattern is Some(pattern) {
    attrs.push(attribute("pattern", pattern))
  }
  if size is Some(size) {
    attrs.push(attribute("size", size.to_string()))
  }
  if width is Some(width) {
    attrs.push(attribute("width", width.to_string()))
  }
  if height is Some(height) {
    attrs.push(attribute("height", height.to_string()))
  }
  if placeholder is Some(placeholder) {
    attrs.push(attribute("placeholder", placeholder))
  }
  if change is Some(to_msg) {
    attrs.push(on_change(to_msg))
  }
  if input is Some(to_msg) {
    attrs.push(on_input(to_msg))
  }
  common_node("input", attrs, children, style~, id?, class?)
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
  children : C,
) -> Html {
  let attrs = []
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if value is Some(value) {
    attrs.push(property("value", String(value)))
  }
  if rows is Some(rows) {
    attrs.push(attribute("rows", rows.to_string()))
  }
  if cols is Some(cols) {
    attrs.push(attribute("cols", cols.to_string()))
  }
  if placeholder is Some(placeholder) {
    attrs.push(attribute("placeholder", placeholder))
  }
  if read_only is Some(read_only) {
    attrs.push(property("readonly", Boolean(read_only)))
  }
  if disabled is Some(disabled) {
    attrs.push(property("disabled", Boolean(disabled)))
  }
  if maxlength is Some(maxlength) {
    attrs.push(attribute("maxlength", maxlength.to_string()))
  }
  if minlength is Some(minlength) {
    attrs.push(attribute("minlength", minlength.to_string()))
  }
  if change is Some(to_msg) {
    attrs.push(on_change(to_msg))
  }
  if input is Some(to_msg) {
    attrs.push(on_input(to_msg))
  }
  common_node(style~, class?, id?, "textarea", attrs, children)
}

///|
pub fn[C : IsChildren] select(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  change? : (String) -> Cmd,
  children : C,
) -> Html {
  // TODO: support more attribute for select tag
  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  if class is Some(class) {
    attrs.push(attribute("class", class))
  }
  if disabled is Some(value) {
    attrs.push(property("disabled", Boolean(value)))
  }
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if change is Some(to_msg) {
    attrs.push(on_change(to_msg))
  }
  node("select", attrs, children)
}

///|
pub fn[C : IsChildren] optgroup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  label? : String,
  disabled? : Bool,
  children : C,
) -> Html {
  let attrs = []
  if label is Some(label) {
    attrs.push(attribute("label", label))
  }
  if disabled is Some(disabled) {
    attrs.push(property("disabled", Boolean(disabled)))
  }
  common_node(style~, class?, id?, "optgroup", attrs, children)
}

///|
pub fn[C : IsChildren] option(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  value? : String,
  selected? : Bool = false,
  children : C,
) -> Html {
  // TODO: support more attribute for option tag

  let attrs = []
  if style.length() > 0 {
    attrs.push(attribute("style", style.join(";")))
  }
  if id is Some(id) {
    attrs.push(attribute("id", id))
  }
  if class is Some(class) {
    attrs.push(attribute("class", class))
  }
  if disabled is Some(value) {
    attrs.push(property("disabled", Boolean(value)))
  }
  if value is Some(value) {
    attrs.push(attribute("value", value))
  }
  attrs.push(property("selected", Boolean(selected)))
  node("option", attrs, children)
}

///|
pub fn[C : IsChildren] datalist(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node(style~, class?, id?, "datalist", [], children)
}

///|
pub fn[C : IsChildren] output(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  name? : String,
  for_? : String,
  children : C,
) -> Html {
  let attrs = []
  if name is Some(name) {
    attrs.push(attribute("name", name))
  }
  if for_ is Some(for_) {
    attrs.push(attribute("for", for_))
  }
  common_node(style~, class?, id?, "output", attrs, children)
}

///|
pub fn[C : IsChildren] progress(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  value? : Int,
  max? : Int,
  children : C,
) -> Html {
  let attrs = []
  if value is Some(value) {
    attrs.push(attribute("value", value.to_string()))
  }
  if max is Some(max) {
    attrs.push(attribute("max", max.to_string()))
  }
  common_node(style~, class?, id?, "progress", attrs, children)
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
  children : C,
) -> Html {
  let attrs = []
  if value is Some(value) {
    attrs.push(attribute("value", value.to_string()))
  }
  if min is Some(min) {
    attrs.push(attribute("min", min.to_string()))
  }
  if max is Some(max) {
    attrs.push(attribute("max", max.to_string()))
  }
  if low is Some(low) {
    attrs.push(attribute("low", low.to_string()))
  }
  if high is Some(high) {
    attrs.push(attribute("high", high.to_string()))
  }
  if optimum is Some(optimum) {
    attrs.push(attribute("optimum", optimum.to_string()))
  }
  common_node(style~, class?, id?, "meter", attrs, children)
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
  children : C,
) -> Html {
  common_node("table", [], style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] caption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node("caption", [], style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] thead(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node("thead", [], style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] tbody(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node("tbody", [], style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] col(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  children : C,
) -> Html {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("col", attrs, style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] colgroup(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  children : C,
) -> Html {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("colgroup", attrs, style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] tr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node("tr", [], style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] td(
  style? : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  class? : String,
  children : C,
) -> Html {
  let attrs = []
  if colspan is Some(colspan) {
    attrs.push(attribute("colspan", colspan.to_string()))
  }
  if rowspan is Some(rowspan) {
    attrs.push(attribute("rowspan", rowspan.to_string()))
  }
  if headers is Some(headers) {
    attrs.push(attribute("headers", headers))
  }
  common_node("td", attrs, style~, id?, class?, children)
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
  children : C,
) -> Html {
  let attrs = []
  if colspan is Some(colspan) {
    attrs.push(attribute("colspan", colspan.to_string()))
  }
  if rowspan is Some(rowspan) {
    attrs.push(attribute("rowspan", rowspan.to_string()))
  }
  if headers is Some(headers) {
    attrs.push(attribute("headers", headers))
  }
  if abbr is Some(abbr) {
    attrs.push(attribute("abbr", abbr))
  }
  if scope is Some(scope) {
    attrs.push(
      attribute(
        "scope",
        match scope {
          Row => "row"
          Col => "col"
          RowGroup => "rowgroup"
          ColGroup => "colgroup"
        },
      ),
    )
  }
  common_node("th", attrs, style~, id?, class?, children)
}

///|
pub fn[C : IsChildren] tfoot(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : C,
) -> Html {
  common_node("tfoot", [], style~, id?, class?, children)
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
  children : C,
) -> Html {
  let attrs = []
  if open is Some(open) {
    attrs.push(property("open", Boolean(open)))
  }
  if close is Some(close) {
    attrs.push(
      Handler("close", (event, scheduler) => {
        let html_element = event.target().to_html_dialog_element().unwrap()
        scheduler.add(close(html_element.return_value()))
      }),
    )
  }
  if cancel is Some(cancel) {
    attrs.push(
      Handler("cancel", (event, scheduler) => {
        event.prevent_default()
        scheduler.add(cancel)
      }),
    )
  }
  common_node("dialog", attrs, style~, id?, class?, children)
}
