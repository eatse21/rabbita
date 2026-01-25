///|
trait Patcher {
  /// insert new node to the end
  insert(Self, new~ : VNode) -> Unit
  // create a new node from vnode, replace the old one
  replace(Self, old~ : VNode, new~ : VNode) -> Unit
  // delete the node, under current parent
  remove(Self, old~ : VNode) -> Unit
  replace_old(Self, old1 : VNode, old2 : VNode) -> Unit
  patch_text(Self, old~ : VNode, new~ : VNode, String) -> Unit
  patch_elem(Self, old~ : VNode, () -> Unit) -> Unit
  // patch_frag(Self, @dom.Node, () -> Unit) -> Unit
  // patch attr
  attr_remove(Self, String) -> Unit
  attr_insert(Self, String, String) -> Unit
  // patch property 
  prop_remove(Self, String) -> Unit
  prop_insert(Self, String, @variant.Variant) -> Unit
  // patch style
  style_remove(Self, String) -> Unit
  style_insert(Self, String, String) -> Unit
  // patch listener 
  add_listener(Self, String, @dom.Listener) -> Unit
}

///|
struct DomPatcher {
  stack : Array[@dom.Element]
  scheduler : &Scheduler
}

///|
fn DomPatcher::new(root : @dom.Element, scheduler : &Scheduler) -> DomPatcher {
  { stack: [root], scheduler }
}

///|
fn DomPatcher::current(self : Self) -> @dom.Element {
  self.stack.last().unwrap()
}

///|
impl Patcher for DomPatcher with insert(self, new~) {
  if new is Cell(c) {
    self.scheduler.subscribe(c)
    if c.dirty_flag() {
      c.refersh()
    }
  }
  self.current().append_child(self.create_node(new))
}

///|
impl Patcher for DomPatcher with replace(self, old~, new~) {
  if old is Cell(c) {
    self.scheduler.unsubscribe(c)
  }
  if new is Cell(c) {
    self.scheduler.subscribe(c)
  }
  self.current().replace_child(old.get_node(), self.create_node(new))
}

///|
impl Patcher for DomPatcher with replace_old(self, old1, old2) {
  self.current().replace_child(old1.get_node(), old2.get_node())
}

///|
impl Patcher for DomPatcher with remove(self, old~) {
  if old is Cell(c) {
    self.scheduler.unsubscribe(c)
  }
  self.current().remove_child(old.get_node())
}

///|
impl Patcher for DomPatcher with style_insert(self, k, v) {
  self.current().to_html_element().unwrap().get_style().set_property(k, v)
}

///|
impl Patcher for DomPatcher with style_remove(self, k) {
  self.current().to_html_element().unwrap().get_style().remove_property(k)
  |> ignore
}

///|
impl Patcher for DomPatcher with patch_text(_, old~, new~, str) {
  old
  .get_node()
  .to_text()
  .unwrap()
  .set_node_value(@js.Nullable::from_option(Some(str)))
}

///|
impl Patcher for DomPatcher with patch_elem(self, old~, f) {
  self.stack.push(old.get_node().to_element().unwrap())
  f()
}

///|
impl Patcher for DomPatcher with attr_remove(self, key) {
  self.current().remove_attribute(key)
}

///|
impl Patcher for DomPatcher with attr_insert(self, key, value) {
  self.current().set_attribute(key, value)
}

///|
impl Patcher for DomPatcher with prop_remove(self, key) {
  self.current().remove_property(key)
}

///|
impl Patcher for DomPatcher with prop_insert(self, key, value) {
  self.current().set_property(key, variant_to_js_value(value))
}

///|
impl Patcher for DomPatcher with add_listener(self, event, listener) {
  self.current().add_event_listener(event, listener)
}

///|
fn DomPatcher::create_node(self : Self, vnode : VNode) -> @dom.Node {
  match vnode {
    Empty => @dom.document().create_text_node("").as_node() // TODO: use frag
    Text(s, ..) as v => {
      let node = @dom.document().create_text_node(s).as_node()
      v.node = Some(node)
      node
    }
    Cell(c) => {
      self.scheduler.subscribe(c)
      if c.dirty_flag() {
        c.refersh()
      }
      self.create_node(c.node())
    }
    Elem(tag, props, childs, namespace_uri=_, ..) as v => {
      let element = @dom.document().create_element(tag)
      let { slots, handlers, attrs, props, styles } = props
      for e, h in handlers {
        let slot = @ref.new(h)
        let scheduler = self.scheduler
        element.add_event_listener(e, x => (slot.val)(x, scheduler))
        slots[e] = slot
      }
      for n, val in attrs {
        element.set_attribute(n, val)
      }
      for n, val in props {
        element.set_property(n, variant_to_js_value(val))
      }
      let style_sheet = element.to_html_element().unwrap().get_style()
      for n, val in styles {
        style_sheet.set_property(n, val)
      }
      match childs {
        Array(xs) =>
          for x in xs {
            element.append_child(self.create_node(x))
          }
        Map(mp) =>
          for _, x in mp {
            element.append_child(self.create_node(x))
          }
      }
      let node = element.as_node()
      v.node = Some(node)
      node
    }
  }
}

///|
struct DebugPatcher {
  inner : DomPatcher
  mut depth : Int
}

///|
fn DebugPatcher::new(
  root : @dom.Element,
  scheduler : &Scheduler,
) -> DebugPatcher {
  { inner: DomPatcher::new(root, scheduler), depth: 0 }
}

///|
fn DebugPatcher::current(self : Self) -> @dom.Element {
  self.inner.current()
}

///|
fn DebugPatcher::log(self : Self, msg : String) -> Unit {
  let level = if self.depth > 0 { self.depth - 1 } else { 0 }
  let indent = "  ".repeat(level)
  console_log(@js.Value::cast_from("\{indent}\{msg}"))
}

///|
fn describe_element(element : @dom.Element) -> String {
  "<\{element.get_node_name()}>"
}

///|
fn format_attrs(attrs : Map[String, String]) -> String {
  let items = []
  for k, v in attrs {
    items.push("\{k}=\"\{v}\"")
  }
  if items.length() == 0 {
    ""
  } else {
    let joined = items.join(", ")
    "attrs={\{joined}}"
  }
}

///|
fn format_styles(styles : Map[String, String]) -> String {
  let items = []
  for k, v in styles {
    items.push("\{k}: \{v}")
  }
  if items.length() == 0 {
    ""
  } else {
    let joined = items.join(", ")
    "styles={\{joined}}"
  }
}

///|
fn format_props(props : Map[String, @variant.Variant]) -> String {
  let items = []
  for k, v in props {
    items.push("\{k}=\{format_variant(v)}")
  }
  if items.length() == 0 {
    ""
  } else {
    let joined = items.join(", ")
    "props={\{joined}}"
  }
}

///|
fn format_handlers(
  handlers : Map[String, (@dom.Event, &Scheduler) -> Unit],
) -> String {
  let items = []
  for k, _ in handlers {
    items.push(k)
  }
  if items.length() == 0 {
    ""
  } else {
    let joined = items.join(", ")
    "handlers=[\{joined}]"
  }
}

///|
pub fn describe_vnode(vnode : VNode) -> String {
  match vnode {
    Text(value, ..) => "text \"\{value}\""
    Elem(tag, elem_props, _, namespace_uri=ns, ..) => {
      let base = match ns {
        None => "<\{tag}>"
        Some(uri) => "<\{tag} ns=\{uri}>"
      }
      let attrs_desc = format_attrs(elem_props.attrs)
      let props_desc = format_props(elem_props.props)
      let styles_desc = format_styles(elem_props.styles)
      let handlers_desc = format_handlers(elem_props.handlers)
      let parts = []
      if attrs_desc != "" {
        parts.push(attrs_desc)
      }
      if props_desc != "" {
        parts.push(props_desc)
      }
      if styles_desc != "" {
        parts.push(styles_desc)
      }
      if handlers_desc != "" {
        parts.push(handlers_desc)
      }
      if parts.length() == 0 {
        base
      } else {
        let joined = parts.join(" ")
        "\{base} \{joined}"
      }
    }
    Cell(c, ..) => "cell(\{c.id()})"
    Empty => "empty"
  }
}

///|
fn DebugPatcher::create_node(self : Self, new : VNode) -> @dom.Node {
  self.inner.create_node(new)
}

///|
impl Patcher for DebugPatcher with insert(self, new~) {
  let parent = describe_element(self.current())
  self.log("insert \{describe_vnode(new)} into \{parent}")
  self.current().append_child(self.create_node(new))
}

///|
impl Patcher for DebugPatcher with replace_old(self, old1, old2) {
  ...
}

///|
impl Patcher for DebugPatcher with replace(self, old~, new~) {
  let parent = describe_element(self.current())
  self.log(
    "replace \{describe_vnode(old)} with \{describe_vnode(new)} in \{parent}",
  )
  self.current().replace_child(old.get_node(), self.create_node(new))
}

///|
impl Patcher for DebugPatcher with remove(self, old~) {
  let parent = describe_element(self.current())
  self.log("remove \{describe_vnode(old)} from \{parent}")
  self.current().remove_child(old.get_node())
}

///|
impl Patcher for DebugPatcher with patch_text(self, old~, new~, str) {
  let before = match old {
    Text(value, ..) => value
    _ => "<non-text>"
  }
  let parent = describe_element(self.current())
  self.log("text \"\{before}\" -> \"\{str}\" in \{parent}")
  self.inner.patch_text(old~, new~, str)
}

///|
impl Patcher for DebugPatcher with patch_elem(self, old~, f) {
  self.depth += 1
  self.inner.patch_elem(old~, f)
  self.depth -= 1
}

///|
impl Patcher for DebugPatcher with attr_remove(self, key) {
  let parent = describe_element(self.current())
  self.log("remove attr \{key} from \{parent}")
  self.inner.attr_remove(key)
}

///|
impl Patcher for DebugPatcher with attr_insert(self, key, value) {
  let parent = describe_element(self.current())
  self.log("set attr \{key}=\"\{value}\" on \{parent}")
  self.inner.attr_insert(key, value)
}

///|
impl Patcher for DebugPatcher with prop_remove(self, key) {
  let parent = describe_element(self.current())
  self.log("remove prop \{key} from \{parent}")
  self.inner.prop_remove(key)
}

///|
impl Patcher for DebugPatcher with prop_insert(self, key, value) {
  let parent = describe_element(self.current())
  self.log("set prop \{key}=\{value} on \{parent}")
  self.inner.prop_insert(key, value)
}

///|
impl Patcher for DebugPatcher with style_remove(self, key) {
  let parent = describe_element(self.current())
  self.log("remove style \{key} from \{parent}")
  self.inner.style_remove(key)
}

///|
impl Patcher for DebugPatcher with style_insert(self, key, value) {
  let parent = describe_element(self.current())
  self.log("set style \{key}: \{value} on \{parent}")
  self.inner.style_insert(key, value)
}

///|
impl Patcher for DebugPatcher with add_listener(self, event, listener) {
  let parent = describe_element(self.current())
  self.log("add listener \{event} on \{parent}")
  self.inner.add_listener(event, listener)
}

///|
extern "js" fn console_log(x : @js.Value) = "(x) => console.log(x)"
