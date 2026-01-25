///|
using @vdom {type VNode, type Props}

///|
#alias(T)
pub(all) struct Html(@vdom.VNode)

///|
pub fn Html::to_virtual_dom(self : Html) -> @vdom.VNode {
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
pub fn node(
  tag : String,
  attributes : Array[Attribute],
  children : Array[Html],
) -> Html {
  let props = attributes_to_props(attributes)
  VNode::elem(tag, props, Array(children.map(x => x.0)))
}

///|
fn common_node(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  tag : String,
  attributes : Array[Attribute],
  children : Array[Html],
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
  node("div", [], []) //TODO: use frag instead
}

///|
pub fn cell(cell : &@vdom.Cell) -> Html {
  @vdom.VNode::cell(cell)
}

///|
pub fn button(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  children : Array[Html],
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  common_node(style~, class?, id?, "button", attrs, children)
}

///|
pub fn h1(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h1", [], children)
}

///|
pub fn h2(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h2", [], children)
}

///|
pub fn h3(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h3", [], children)
}

///|
pub fn h4(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h4", [], children)
}

///|
pub fn h5(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h5", [], children)
}

///|
pub fn h6(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "h6", [], children)
}

// ------ grouping content ------

///|
pub fn div(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  children : Array[Html],
) -> Html {
  let attrs = []
  if click is Some(click) {
    attrs.push(on_click(_ => click))
  }
  common_node(style~, class?, id?, "div", attrs, children)
}

///|
pub fn p(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "p", [], children)
}

///|
pub fn hr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children? : Array[Html] = [],
) -> Html {
  common_node(style~, class?, id?, "hr", [], children)
}

///|
pub fn pre(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "pre", [], children)
}

///|
pub fn blockquote(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "blockquote", [], children)
}

///|
pub fn section(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "section", [], children)
}

// ---- text ----

///|
pub fn span(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "span", [], children)
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
pub fn a(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  href~ : String,
  target? : Target = Self,
  children : Array[Html],
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
  @vdom.vlink(
    attributes_to_props(attrs),
    Array(children.map(x => x.0)),
    escape~,
  )
}

///|
pub fn code(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "code", [], children)
}

///|
pub fn em(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "em", [], children)
}

///|
pub fn strong(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "strong", [], children)
}

///|
pub fn i(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "i", [], children)
}

///|
pub fn b(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "b", [], children)
}

///|
pub fn u(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "u", [], children)
}

///|
pub fn sub(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "sub", [], children)
}

///|
pub fn sup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "sup", [], children)
}

///|
pub fn text(str : String) -> Html {
  VNode::text(str)
}

// ---- lists ----

///|
pub fn ul(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  click? : Cmd,
  children : Array[Html],
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
pub fn ol(
  style? : Array[String] = [],
  reversed? : Bool,
  start? : Int,
  id? : String,
  class? : String,
  children : Array[Html],
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
pub fn li(
  style? : Array[String] = [],
  value? : Int,
  id? : String,
  class? : String,
  click? : Cmd,
  children : Array[Html],
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
pub fn dl(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "dl", [], children)
}

///|
pub fn dt(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "dt", [], children)
}

///|
pub fn dd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node(style~, class?, id?, "dd", [], children)
}

// ---- embbded content ----

///|
pub fn img(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  src? : String,
  alt? : String,
  title? : String,
  width? : Int,
  height? : Int,
  border? : Int,
  children : Array[Html],
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
  common_node(style~, class?, id?, "iframe", attrs, [])
}

// ---- inputs ----

///|
pub fn br(style? : Array[String] = [], id? : String, class? : String) -> Html {
  common_node(style~, class?, id?, "br", [], [])
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
pub fn form(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  action? : String,
  name? : String,
  children : Array[Html],
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
pub fn label(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  for_? : String,
  children : Array[Html],
) -> Html {
  let attrs = []
  if for_ is Some(for_) {
    attrs.push(attribute("for", for_))
  }
  common_node(style~, class?, id?, "label", attrs, children)
}

///|
pub fn input(
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
  children? : Array[Html] = [],
  change? : (String) -> Cmd,
  input? : (String) -> Cmd,
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
pub fn select(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  name? : String,
  change? : (String) -> Cmd,
  children : Array[Html],
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
pub fn option(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  disabled? : Bool,
  value? : String,
  selected? : Bool = false,
  children : Array[Html],
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

// ///|
// pub fn external(
//   node : @dom.Node,
//   attrs : Ref[Array[Attribute]?],
//   width~ : Int,
//   height~ : Int,
// ) -> Html {
//   let attrs = attrs.map(_.map(_.map(x => x.0)))
//   @vdom.external(node, attrs, width~, height~)
// }

// table

///|
pub fn table(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node("table", [], style~, id?, class?, children)
}

///|
pub fn caption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node("caption", [], style~, id?, class?, children)
}

///|
pub fn thead(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node("thead", [], style~, id?, class?, children)
}

///|
pub fn tbody(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node("tbody", [], style~, id?, class?, children)
}

///|
pub fn col(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  children : Array[Html],
) -> Html {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("col", attrs, style~, id?, class?, children)
}

///|
pub fn colgroup(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  children : Array[Html],
) -> Html {
  let attrs = []
  if span is Some(span) {
    attrs.push(attribute("span", span.to_string()))
  }
  common_node("colgroup", attrs, style~, id?, class?, children)
}

///|
pub fn tr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
) -> Html {
  common_node("tr", [], style~, id?, class?, children)
}

///|
pub fn td(
  style? : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  class? : String,
  children : Array[Html],
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
pub fn th(
  style? : Array[String] = [],
  id? : String,
  abbr? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  scope? : Scope,
  class? : String,
  children : Array[Html],
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
pub fn tfoot(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  children : Array[Html],
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
pub fn dialog(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  open? : Bool,
  close? : (String) -> Cmd,
  cancel? : Cmd,
  children : Array[Html],
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
