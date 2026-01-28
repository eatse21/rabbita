///|
pub enum VNode {
  Elem(
    String,
    Props,
    Children,
    namespace_uri~ : String?,
    mut binding~ : Binding
  )
  Text(String, mut binding~ : Binding)
  Frag(Array[VNode], mut binding~ : Binding)
  Cell(&Cell, mut binding~ : Binding)
}

///|
pub enum Binding {
  Empty
  Single(@dom.Element)
  Range(@dom.Comment, @dom.Comment)
}

///|
pub fn Binding::start(self : Self) -> @dom.Node {
  match self {
    Empty => panic()
    Single(e) => e.as_node()
    Range(s, _) => s.as_node()
  }
}

///|
pub fn Binding::end(self : Self) -> @dom.Node {
  match self {
    Empty => panic()
    Single(e) => e.as_node()
    Range(_, e) => e.as_node()
  }
}

///|
fn Binding::to_string(self : Self) -> String {
  fn node_desc(n : @dom.Node) -> String {
    let node_type = n.get_node_type()
    let name = n.get_node_name()
    let value = n.get_node_value()
    match node_type {
      1 => "<\{name}>"
      3 => "text(\"\{value}\")"
      8 => "comment(\"\{value}\")"
      _ => "node(type=\{node_type}, name=\{name}, value=\{value})"
    }
  }

  match self {
    Empty => "binding: Empty"
    Single(e) => "binding: Single " + node_desc(e.as_node())
    Range(s, e) =>
      "binding: Range(" +
      node_desc(s.as_node()) +
      "," +
      node_desc(e.as_node()) +
      ")"
  }
}

///|
fn VNode::remove(
  self : Self,
  sandbox : Sandbox,
  cell_id : Id,
  parent : @dom.Node,
) -> Unit {
  if self is Cell(c, ..) {
    sandbox.unsubscribe(cell_id, c)
  }
  match self.binding() {
    Empty => panic()
    Single(e) => parent.remove_child(e.as_node())
    Range(s, e) => {
      let s = s.as_node()
      let e = e.as_node()
      // guard s.get_parent_node().to_option() is Some(a) &&
      //   e.get_parent_node().to_option() is Some(b) &&
      //   a.is_same_node(b)
      while s.get_next_sibling().to_option() is Some(n) && !n.is_same_node(e) {
        parent.remove_child(n)
      }
      parent.remove_child(s)
      parent.remove_child(e)
    }
  }
}

///|
fn VNode::relocate(
  self : Self,
  sandbox : Sandbox,
  cell_id : Id,
  parent : @dom.Node,
  before : @js.Nullable[@dom.Node],
) -> Unit {
  match self.binding() {
    Single(e) => parent.insert_before(e.as_node(), before)
    Range(s, e) if s.get_parent_node().to_option() is Some(_) &&
      !e.get_parent_node().is_null() => {
      let s = s.as_node()
      let e = e.as_node()
      let mut anchor = before
      while e.get_previous_sibling().to_option() is Some(n) &&
            !n.is_same_node(s) {
        parent.insert_before(n, anchor)
        anchor = nullable(n)
      }
      let new_start = @dom.document().create_comment("\{rand.int()}")
      let new_end = @dom.document().create_comment("")
      parent.insert_before(new_end.as_node(), before)
      parent.insert_before(new_start.as_node(), anchor)
      self.bind(Range(new_start, new_end))
    }
    // _ => self.insert(sandbox, cell_id, parent, before)
    _ => panic()
  }
}

///|
fn VNode::insert(
  self : Self,
  sandbox : Sandbox,
  cell_id : Id,
  parent : @dom.Node,
  before : @js.Nullable[@dom.Node],
) -> Unit {
  if self is Cell(c, ..) {
    sandbox.subscribe(cell_id, c)
  }
  if self is Cell(c, binding=Range(_)) {
    // always reuse DOM for cell
    self.relocate(sandbox, cell_id, parent, before)
  } else {
    let n = self.mount(sandbox, cell_id)
    parent.insert_before(n, before)
  }
}

///|
let rand : @random.Rand = @random.Rand::new()

///|
fn VNode::mount(self : Self, sandbox : Sandbox, cell_id : Id) -> @dom.Node {
  match self {
    Text(s, ..) as v => {
      let e = @dom.document().create_text_node(s)
      v.binding = Single(e)
      e.as_node()
    }
    Cell(c, ..) as v => {
      if c.dirty_flag() {
        c.refersh()
      }
      let start = @dom.document().create_comment("")
      let end = @dom.document().create_comment("")
      v.binding = Range(start, end)
      let fragment = @dom.document().create_document_fragment()
      fragment.append_child(start.as_node())
      c.node().insert(sandbox, c.id(), fragment.as_node(), null())
      fragment.append_child(end.as_node())
      fragment.as_node()
    }
    Frag(childs, ..) as v => {
      let doc = @dom.document()
      let fragment = doc.create_document_fragment()
      let start = doc.create_comment("start\{rand.int()}")
      let end = doc.create_comment("end")
      fragment.append_child(start.as_node())
      for child in childs {
        child.insert(sandbox, cell_id, fragment.as_node(), null())
      }
      fragment.append_child(end.as_node())
      v.binding = Range(start, end)
      fragment.as_node()
    }
    Elem(tag, props, childs, namespace_uri=_, ..) as v => {
      let s = if tag == CAPTURED_LINK_TAG { "a" } else { tag }
      let element = @dom.document().create_element(s)
      let { slots, handlers, attrs, props, styles } = props
      for e, h in handlers {
        let slot = @ref.new(h)
        element.add_event_listener(e, x => (slot.val)(x, sandbox))
        slots[e] = slot
      }
      if tag == CAPTURED_LINK_TAG {
        element.add_event_listener("click", sandbox.captured_link_listener)
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
      let parent = element.as_node()
      match childs {
        Array(xs) =>
          for x in xs {
            x.insert(sandbox, cell_id, parent, null())
          }
        Map(mp) =>
          for _, x in mp {
            x.insert(sandbox, cell_id, parent, null())
          }
      }
      v.binding = Single(element)
      parent
    }
  }
}

///|
const CAPTURED_LINK_TAG : String = "RABBITA_CAPTURED_LINK"

///|
pub fn VNode::elem(
  tag : String,
  props : Props,
  children : Children,
  namespace_uri? : String,
) -> VNode {
  Elem(tag, props, children, namespace_uri~, binding=Empty)
}

///|
pub fn VNode::text(s : String) -> VNode {
  Text(s, binding=Empty)
}

///|
pub fn VNode::link(
  props : Props,
  children : Children,
  escape? : Bool = false,
) -> VNode {
  let tag = if escape { "a" } else { CAPTURED_LINK_TAG }
  VNode::elem(tag, props, children)
}

///|
pub fn VNode::cell(cell : &Cell) -> VNode {
  Cell(cell, binding=Empty)
}

///|
pub fn VNode::fragment(childs : Array[VNode]) -> VNode {
  Frag(childs, binding=Empty)
}

///|
pub(all) enum Children {
  Array(Array[VNode])
  Map(Map[String, VNode])
}

///|
fn VNode::binding(self : Self) -> Binding {
  match self {
    Frag(_, binding~)
    | Text(_, binding~)
    | Elem(_, _, _, binding~, ..)
    | Cell(_, binding~) => binding
  }
}

///|
fn VNode::bind(self : Self, binding : Binding) -> Unit {
  match self {
    Frag(_) as v => v.binding = binding
    Text(_) as v => v.binding = binding
    Elem(_) as v => v.binding = binding
    Cell(_) as v => v.binding = binding
  }
}

///|
pub fn VNode::validate(self : VNode) -> Unit {
  fn validate_array(nodes : Array[VNode]) -> Unit {
    for node in nodes {
      node.validate()
    }
  }

  fn validate_children(children : Children) -> Unit {
    match children {
      Array(nodes) => validate_array(nodes)
      Map(map) =>
        for _, node in map {
          node.validate()
        }
    }
  }

  match self {
    Frag(cs, ..) => validate_array(cs)
    Elem(_, _, cs, ..) => validate_children(cs)
    Cell(c, ..) => c.node().validate()
    Text(_) => ()
  }
  match self.binding() {
    Single(e) => if e.get_parent_node().is_null() { panic() }
    Range(s, e) => {
      guard s.get_parent_node().to_option() is Some(a) else {
        log_node(nullable(s.as_node()))
        panic()
      }
      guard e.get_parent_node().to_option() is Some(b) else {
        log_node(nullable(e.as_node()))
        panic()
      }
      guard a.is_same_node(b) else {
        log_node(nullable(s.as_node()))
        panic()
      }
    }
    Empty => panic()
  }
}

///|
pub struct Props {
  mut slots : Map[String, Ref[(@dom.Event, &Scheduler) -> Unit]]
  handlers : Map[String, (@dom.Event, &Scheduler) -> Unit]
  attrs : Map[String, String]
  props : Map[String, @variant.Variant]
  styles : Map[String, String]
}

///|
pub fn Props::new(
  attrs : Map[String, String],
  props : Map[String, @variant.Variant],
  styles : Map[String, String],
  handlers : Map[String, (@dom.Event, &Scheduler) -> Unit],
) -> Props {
  { slots: {}, handlers, attrs, styles, props }
}

///|
pub fn Props::empty() -> Props {
  { slots: {}, handlers: {}, attrs: {}, styles: {}, props: {} }
}

///|
fn[T] nullable(x : T) -> @js.Nullable[T] {
  @js.Nullable::from_option(Some(x))
}

///|
fn[T] null() -> @js.Nullable[T] {
  @js.Nullable::null()
}

///|
extern "js" fn log_node(x : @js.Nullable[@dom.Node]) = "(x) => console.log(x)"

///|
fn diff_node(
  old : VNode,
  new : VNode,
  sandbox : Sandbox,
  parent : @dom.Node,
  anchor : @js.Nullable[@dom.Node],
  cell_id : Id,
) -> Unit {
  match (old, new) {
    (
      Elem(tag1, props1, childs1, namespace_uri=ns1, binding=Single(e) as b),
      Elem(tag2, props2, childs2, namespace_uri=ns2, ..),
    ) =>
      if tag1 != tag2 {
        old.remove(sandbox, cell_id, parent.as_node())
        new.insert(sandbox, cell_id, parent.as_node(), anchor)
      } else {
        diff_props(props1, props2, sandbox, e)
        diff_children(childs1, childs2, sandbox, e.as_node(), null(), cell_id)
        new.bind(b)
      }
    (Text(s1, binding=Single(e) as b), Text(s2, ..)) => {
      if s1 != s2 {
        e.set_node_value(@js.Nullable::from_option(Some(s2)))
      }
      new.bind(b)
    }
    (Frag(childs1, binding=Range(_, e) as b), Frag(childs2, ..)) => {
      diff_children(
        Array(childs1),
        Array(childs2),
        sandbox,
        parent.as_node(),
        nullable(e.as_node()),
        cell_id,
      )
      new.bind(b)
    }
    (Cell(c1, binding=Range(_) as b), Cell(c2, ..)) => {
      if c1.id() != c2.id() {
        old.remove(sandbox, cell_id, parent.as_node())
        new.insert(sandbox, cell_id, parent.as_node(), anchor)
      }
      new.bind(b)
    }
    (_, _) => {
      old.remove(sandbox, cell_id, parent.as_node())
      new.insert(sandbox, cell_id, parent.as_node(), anchor)
    }
  }
}

///|
fn diff_props(
  old : Props,
  new : Props,
  sandbox : Sandbox,
  parent : @dom.Element,
) -> Unit {
  // update event listeners slots
  let slots = old.slots
  for event, slot in slots {
    if !new.handlers.contains(event) {
      slot.val = fn(_, _) {  }
    }
  }
  for event, handler in new.handlers {
    match slots.get(event) {
      Some(slot) => slot.val = handler
      None => {
        let slot = @ref.new(handler)
        parent.add_event_listener(event, e => (slot.val)(e, sandbox))
        slots[event] = slot
      }
    }
  }
  new.slots = slots

  // O(n+m), TODO: use small sorted array to optimize this 
  // patch attributes
  for k, _ in old.attrs {
    if !new.attrs.contains(k) {
      parent.remove_attribute(k)
    }
  }
  for k, v2 in new.attrs {
    match old.attrs.get(k) {
      None => parent.set_attribute(k, v2)
      Some(v1) => if v1 != v2 { parent.set_attribute(k, v2) }
    }
  }
  // patch properties
  for k, _ in old.props {
    if !new.attrs.contains(k) {
      parent.remove_property(k)
    }
  }
  for k, v2 in new.props {
    match old.props.get(k) {
      None => parent.set_property(k, variant_to_js_value(v2))
      Some(v1) =>
        if v1 != v2 {
          parent.set_property(k, variant_to_js_value(v2))
        }
    }
  }
  // patch styles
  let stylesheet = parent.to_html_element().unwrap().get_style()
  for k, _ in old.styles {
    if !new.styles.contains(k) {
      stylesheet.remove_property(k) |> ignore
    }
  }
  for k, v2 in new.styles {
    match old.styles.get(k) {
      None => stylesheet.set_property(k, v2)
      Some(v1) => if v1 != v2 { stylesheet.set_property(k, v2) }
    }
  }
}

///|
fn diff_children(
  old : Children,
  new : Children,
  sandbox : Sandbox,
  parent : @dom.Node,
  anchor : @js.Nullable[@dom.Node],
  cell_id : Id,
) -> Unit {
  match (old, new) {
    (Array(old), Array(new)) => {
      if old.length() == 3 && new.length() == 3 {
        println("---------------diff_children(Arr,Arr)")
        println(old.map(x => x.binding().to_string()))
        println(new.map(x => x.binding().to_string()))
        println("-------------------------------------")
      }
      let len1 = old.length()
      let len2 = new.length()
      let mut before = anchor
      let len = if len1 > len2 {
        for i in len1>..len2 {
          old[i].remove(sandbox, cell_id, parent)
        }
        len2
      } else {
        for i in len2>..len1 {
          new[i].insert(sandbox, cell_id, parent, before)
          before = nullable(new[i].binding().start())
        }
        len1
      }
      for i in len>..0 {
        diff_node(old[i], new[i], sandbox, parent, before, cell_id)
        before = nullable(new[i].binding().start())
      }
    }
    (Map(old), Map(new)) => {
      for k, v1 in old {
        if !new.contains(k) {
          v1.remove(sandbox, cell_id, parent)
        }
      }
      let order = new.to_array()
      let mut before = null()
      for i in order.length()>..0 {
        let (k, v2) = order[i]
        match old.get(k) {
          None => v2.insert(sandbox, cell_id, parent, before)
          Some(v1) => {
            diff_node(v1, v2, sandbox, parent, before, cell_id)
            v2.relocate(sandbox, cell_id, parent, before)
          }
        }
        before = nullable(v2.binding().start())
      }
    }
    (_, _) => {
      fn iter(c : Children) -> Iter[VNode] {
        match c {
          Array(arr) => arr.iter()
          Map(map) => map.values()
        }
      }

      for x in iter(old) {
        x.remove(sandbox, cell_id, parent)
      }
      for y in iter(new) {
        y.insert(sandbox, cell_id, parent, null())
      }
    }
  }
}

///|
pub fn vlink(props : Props, children : Children, escape~ : Bool) -> VNode {
  let tag = if escape { ESCAPED_LINK_TAG } else { NORMAL_LINK_TAG }
  VNode::elem(tag, props, children)
}
