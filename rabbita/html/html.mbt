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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/button)
pub fn[C : IsChildren] button(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  type_? : String,
  disabled? : Bool,
  name? : String,
  value? : String,
  autofocus? : Bool,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_type(type_, extra)
  push_disabled(disabled, extra)
  push_name(name, extra)
  push_value_attr_string(value, extra)
  push_autofocus(autofocus, extra)
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("button", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h1)
pub fn[C : IsChildren] h1(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  cite? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_cite(cite, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h1", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h2)
pub fn[C : IsChildren] h2(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h2", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h3)
pub fn[C : IsChildren] h3(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h3", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h4)
pub fn[C : IsChildren] h4(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h4", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h5)
pub fn[C : IsChildren] h5(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h5", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/h6)
pub fn[C : IsChildren] h6(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("h6", attrs + extra, children)
}

// ------ grouping content ------

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/div)
pub fn[C : IsChildren] div(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("div", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/p)
pub fn[C : IsChildren] p(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("p", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/hr)
pub fn[C : IsChildren] hr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("hr", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/pre)
pub fn[C : IsChildren] pre(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("pre", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/blockquote)
pub fn[C : IsChildren] blockquote(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("blockquote", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/section)
pub fn[C : IsChildren] section(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("section", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/header)
pub fn[C : IsChildren] header(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("header", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/footer)
pub fn[C : IsChildren] footer(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("footer", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/nav)
pub fn[C : IsChildren] nav(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("nav", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/main)
pub fn[C : IsChildren] main_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("main", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/article)
pub fn[C : IsChildren] article(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("article", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/aside)
pub fn[C : IsChildren] aside(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("aside", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/figure)
pub fn[C : IsChildren] figure(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("figure", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/figcaption)
pub fn[C : IsChildren] figcaption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("figcaption", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/details)
pub fn[C : IsChildren] details(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  open? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_open(open, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("details", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/summary)
pub fn[C : IsChildren] summary(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("summary", attrs + extra, children)
}

// ---- text ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/span)
pub fn[C : IsChildren] span(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("span", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/small)
pub fn[C : IsChildren] small(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("small", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/mark)
pub fn[C : IsChildren] mark(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("mark", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/del)
pub fn[C : IsChildren] del(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("del", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/ins)
pub fn[C : IsChildren] ins(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ins", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/s)
pub fn[C : IsChildren] s(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("s", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/cite)
pub fn[C : IsChildren] cite(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("cite", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/q)
pub fn[C : IsChildren] q(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("q", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/abbr)
pub fn[C : IsChildren] abbr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("abbr", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/kbd)
pub fn[C : IsChildren] kbd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("kbd", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/samp)
pub fn[C : IsChildren] samp(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("samp", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/var)
pub fn[C : IsChildren] var_(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("var", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/time)
pub fn[C : IsChildren] time(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  datetime? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_datetime(datetime, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("time", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/address)
pub fn[C : IsChildren] address(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("address", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/a)
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
  title? : String,
  hidden? : Bool,
  href~ : String,
  target? : Target = Self,
  rel? : String,
  download? : String,
  attrs? : Array[Attribute] = [],
  children : C,
  escape? : Bool = false,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  extra.push(Attribute("href", href))
  extra.push(Attribute("target", target.to_string()))
  push_rel(rel, extra)
  push_download(download, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/code)
pub fn[C : IsChildren] code(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("code", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/em)
pub fn[C : IsChildren] em(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("em", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/strong)
pub fn[C : IsChildren] strong(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("strong", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/i)
pub fn[C : IsChildren] i(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("i", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/b)
pub fn[C : IsChildren] b(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("b", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/u)
pub fn[C : IsChildren] u(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("u", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/sub)
pub fn[C : IsChildren] sub(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("sub", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/sup)
pub fn[C : IsChildren] sup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/ul)
pub fn[C : IsChildren] ul(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_click(click, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ul", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/ol)
/// Notice that the `type` attribute for `ol` is not important for the browser now.
/// If you want to change the type of the list, you should use the `list-style-type` property in CSS.
pub fn[C : IsChildren] ol(
  style? : Array[String] = [],
  reversed? : Bool,
  start? : Int,
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_reversed(reversed, extra)
  push_start(start, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ol", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/li)
pub fn[C : IsChildren] li(
  style? : Array[String] = [],
  value? : Int,
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  click? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_click(click, extra)
  push_value_attr_int(value, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("li", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dl)
pub fn[C : IsChildren] dl(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dl", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dt)
pub fn[C : IsChildren] dt(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dt", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dd)
pub fn[C : IsChildren] dd(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dd", attrs + extra, children)
}

// ---- embbded content ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/img)
pub fn[C : IsChildren] img(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  hidden? : Bool,
  src? : String,
  alt? : String,
  title? : String,
  width? : Int,
  height? : Int,
  srcset? : String,
  sizes? : String,
  loading? : String,
  decoding? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_alt(alt, extra)
  push_title(title, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_srcset(srcset, extra)
  push_sizes(sizes, extra)
  push_loading(loading, extra)
  push_decoding(decoding, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("img", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/iframe)
pub fn iframe(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  hidden? : Bool,
  src? : String,
  title? : String,
  width? : Int,
  height? : Int,
  loading? : String,
  allow? : String,
  sandbox? : String,
  allowfullscreen? : Bool,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_title(title, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_loading(loading, extra)
  push_allow(allow, extra)
  push_sandbox(sandbox, extra)
  push_allowfullscreen(allowfullscreen, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("iframe", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/fencedframe)
pub fn fencedframe(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  hidden? : Bool,
  src? : String,
  title? : String,
  width? : Int,
  height? : Int,
  loading? : String,
  allow? : String,
  sandbox? : String,
  allowfullscreen? : Bool,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_title(title, extra)
  push_width(width, extra)
  push_height(height, extra)
  push_loading(loading, extra)
  push_allow(allow, extra)
  push_sandbox(sandbox, extra)
  push_allowfullscreen(allowfullscreen, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("fencedframe", attrs + extra, ([] : Array[Html]))
}

// ---- inputs ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/br)
pub fn br(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/form)
pub fn[C : IsChildren] form(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  action? : String,
  name? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_action(action, extra)
  push_name(name, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("form", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/label)
pub fn[C : IsChildren] label(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  for_? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_for(for_, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("label", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/fieldset)
pub fn[C : IsChildren] fieldset(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  disabled? : Bool,
  name? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_disabled(disabled, extra)
  push_name(name, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("fieldset", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/legend)
pub fn[C : IsChildren] legend(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("legend", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/input)
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
  title? : String,
  hidden? : Bool,
  required? : Bool,
  autofocus? : Bool,
  list? : String,
  inputmode? : String,
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
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_required(required, extra)
  push_autofocus(autofocus, extra)
  push_list(list, extra)
  push_inputmode(inputmode, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/textarea)
pub fn[C : IsChildren] textarea(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  name? : String,
  value? : String,
  rows? : Int,
  cols? : Int,
  placeholder? : String,
  read_only? : Bool,
  disabled? : Bool,
  maxlength? : Int,
  minlength? : Int,
  required? : Bool,
  autofocus? : Bool,
  wrap? : String,
  change? : (String) -> Cmd,
  input? : (String) -> Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_name(name, extra)
  push_value_prop_string(value, extra)
  push_rows(rows, extra)
  push_cols(cols, extra)
  push_placeholder(placeholder, extra)
  push_readonly(read_only, extra)
  push_disabled(disabled, extra)
  push_maxlength(maxlength, extra)
  push_minlength(minlength, extra)
  push_required(required, extra)
  push_autofocus(autofocus, extra)
  push_wrap(wrap, extra)
  push_change(change, extra)
  push_input(input, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("textarea", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/select)
pub fn[C : IsChildren] select(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  disabled? : Bool,
  name? : String,
  multiple? : Bool,
  size? : Int,
  required? : Bool,
  autofocus? : Bool,
  change? : (String) -> Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  // TODO: support more attribute for select tag
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_disabled(disabled, extra)
  push_name(name, extra)
  push_multiple(multiple, extra)
  push_size(size, extra)
  push_required(required, extra)
  push_autofocus(autofocus, extra)
  push_change(change, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("select", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/optgroup)
pub fn[C : IsChildren] optgroup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  label? : String,
  disabled? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_label(label, extra)
  push_disabled(disabled, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("optgroup", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/option)
pub fn[C : IsChildren] option(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  label? : String,
  disabled? : Bool,
  value? : String,
  selected? : Bool = false,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  // TODO: support more attribute for option tag

  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_label(label, extra)
  push_disabled(disabled, extra)
  push_value_attr_string(value, extra)
  extra.push(property("selected", Boolean(selected)))
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("option", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/datalist)
pub fn[C : IsChildren] datalist(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("datalist", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/output)
pub fn[C : IsChildren] output(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  name? : String,
  for_? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_name(name, extra)
  push_for(for_, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("output", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/progress)
pub fn[C : IsChildren] progress(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  value? : Int,
  max? : Int,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_value_attr_int(value, extra)
  push_max(max, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("progress", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/meter)
pub fn[C : IsChildren] meter(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
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
  push_title(title, extra)
  push_hidden(hidden, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/table)
pub fn[C : IsChildren] table(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("table", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/caption)
pub fn[C : IsChildren] caption(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("caption", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/thead)
pub fn[C : IsChildren] thead(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("thead", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/tbody)
pub fn[C : IsChildren] tbody(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tbody", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/col)
pub fn[C : IsChildren] col(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_span(span, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("col", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/colgroup)
pub fn[C : IsChildren] colgroup(
  style? : Array[String] = [],
  id? : String,
  span? : Int,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_span(span, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("colgroup", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/tr)
pub fn[C : IsChildren] tr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tr", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/td)
pub fn[C : IsChildren] td(
  style? : Array[String] = [],
  id? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/th)
pub fn[C : IsChildren] th(
  style? : Array[String] = [],
  id? : String,
  abbr? : String,
  colspan? : Int,
  rowspan? : Int,
  headers? : String,
  scope? : Scope,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
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
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/tfoot)
pub fn[C : IsChildren] tfoot(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("tfoot", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dialog)
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
  title? : String,
  hidden? : Bool,
  open? : Bool,
  close? : (String) -> Cmd,
  cancel? : Cmd,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_open(open, extra)
  push_close(close, extra)
  push_cancel(cancel, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dialog", attrs + extra, children)
}

// ---- document ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/html)
pub fn[C : IsChildren] html(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  lang? : String,
  dir? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_lang(lang, extra)
  push_dir(dir, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("html", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/head)
pub fn[C : IsChildren] head(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("head", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/body)
pub fn[C : IsChildren] body(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  lang? : String,
  dir? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_lang(lang, extra)
  push_dir(dir, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("body", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/title)
pub fn[C : IsChildren] title(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("title", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/base)
pub fn base(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  href? : String,
  target? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_href(href, extra)
  push_target(target, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("base", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/meta)
pub fn meta(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  charset? : String,
  name? : String,
  content? : String,
  http_equiv? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_charset(charset, extra)
  push_name(name, extra)
  push_content(content, extra)
  push_http_equiv(http_equiv, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("meta", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/link)
pub fn link(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  href? : String,
  rel? : String,
  type_? : String,
  media? : String,
  sizes? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_href(href, extra)
  push_rel(rel, extra)
  push_type(type_, extra)
  push_media(media, extra)
  push_sizes(sizes, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("link", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/style)
pub fn[C : IsChildren] style_tag(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("style", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/script)
pub fn[C : IsChildren] script(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  src? : String,
  type_? : String,
  async_? : Bool,
  defer_? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_type(type_, extra)
  push_async(async_, extra)
  push_defer(defer_, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("script", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/noscript)
pub fn[C : IsChildren] noscript(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("noscript", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/template)
pub fn[C : IsChildren] template(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("template", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/slot)
pub fn[C : IsChildren] slot(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("slot", attrs + extra, children)
}

// ---- inline text (extra) ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/data)
pub fn[C : IsChildren] data(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("data", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/dfn)
pub fn[C : IsChildren] dfn(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("dfn", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/bdi)
pub fn[C : IsChildren] bdi(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("bdi", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/bdo)
pub fn[C : IsChildren] bdo(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("bdo", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/ruby)
pub fn[C : IsChildren] ruby(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("ruby", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/rt)
pub fn[C : IsChildren] rt(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("rt", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/rp)
pub fn[C : IsChildren] rp(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("rp", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/wbr)
pub fn wbr(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("wbr", attrs + extra, ([] : Array[Html]))
}

// ---- sectioning (extra) ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/hgroup)
pub fn[C : IsChildren] hgroup(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("hgroup", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/menu)
pub fn[C : IsChildren] menu(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("menu", attrs + extra, children)
}

// ---- embedded content (extra) ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/canvas)
pub fn[C : IsChildren] canvas(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("canvas", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/SVG/Reference/Element/svg)
pub fn[C : IsChildren] svg(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("svg", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/MathML/Reference/Element/math)
pub fn[C : IsChildren] math(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("math", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/picture)
pub fn[C : IsChildren] picture(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("picture", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/audio)
pub fn[C : IsChildren] audio(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  src? : String,
  controls? : Bool,
  autoplay? : Bool,
  loop_? : Bool,
  muted? : Bool,
  preload? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_controls(controls, extra)
  push_autoplay(autoplay, extra)
  push_loop(loop_, extra)
  push_muted(muted, extra)
  push_preload(preload, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("audio", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/video)
pub fn[C : IsChildren] video(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  src? : String,
  controls? : Bool,
  autoplay? : Bool,
  loop_? : Bool,
  muted? : Bool,
  preload? : String,
  poster? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_controls(controls, extra)
  push_autoplay(autoplay, extra)
  push_loop(loop_, extra)
  push_muted(muted, extra)
  push_preload(preload, extra)
  push_poster(poster, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("video", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/map)
pub fn[C : IsChildren] map(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  name? : String,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_name(name, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("map", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/area)
pub fn area(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  alt? : String,
  coords? : String,
  shape? : String,
  href? : String,
  target? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_alt(alt, extra)
  push_coords(coords, extra)
  push_shape(shape, extra)
  push_href(href, extra)
  push_target(target, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("area", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/source)
pub fn source(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  src? : String,
  srcset? : String,
  media? : String,
  type_? : String,
  sizes? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_src(src, extra)
  push_srcset(srcset, extra)
  push_media(media, extra)
  push_type(type_, extra)
  push_sizes(sizes, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("source", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/track)
pub fn track(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  kind? : String,
  srclang? : String,
  label? : String,
  default? : Bool,
  src? : String,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_kind(kind, extra)
  push_srclang(srclang, extra)
  push_label(label, extra)
  push_default(default, extra)
  push_src(src, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("track", attrs + extra, ([] : Array[Html]))
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/object)
pub fn[C : IsChildren] object(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("object", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/embed)
pub fn embed(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("embed", attrs + extra, ([] : Array[Html]))
}

// ---- additional elements ----

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/search)
pub fn[C : IsChildren] search(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("search", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/selectedcontent)
pub fn[C : IsChildren] selectedcontent(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("selectedcontent", attrs + extra, children)
}

///|
/// [MDN](https://developer.mozilla.org/en-US/docs/Web/HTML/Reference/Elements/geolocation)
pub fn[C : IsChildren] geolocation(
  style? : Array[String] = [],
  id? : String,
  class? : String,
  title? : String,
  hidden? : Bool,
  attrs? : Array[Attribute] = [],
  children : C,
) -> Html {
  let extra = []
  push_title(title, extra)
  push_hidden(hidden, extra)
  push_style(style, extra)
  push_class(class, extra)
  push_id(id, extra)
  node("geolocation", attrs + extra, children)
}
