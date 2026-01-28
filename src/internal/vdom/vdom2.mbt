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
      while s.get_next_sibling().to_option() is Some(n) && !n.is_same_node(e) {
        parent.remove_child(n)
      }
      parent.remove_child(s)
      parent.remove_child(e)
    }
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
  if self is Cell(c, ..) { //do not edit this
    sandbox.subscribe(cell_id, c)
  }
  match self.binding() {
    Empty => {
      let n = self.mount(sandbox, cell_id)
      parent.insert_before(n, before)
    }
    Single(e) => parent.insert_before(e.as_node(), before)
    Range(s, e) if !s.get_parent_node().is_null() &&
      !e.get_parent_node().is_null() => {
      let s = s.as_node()
      let e = e.as_node()
      let mut anchor = before
      while e.get_previous_sibling().to_option() is Some(n) &&
            !n.is_same_node(s) {
        parent.insert_before(n, anchor)
        anchor = nullable(n)
      }
      parent.insert_before(e, before)
      parent.insert_before(s, anchor)
    }
  }
}

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
      let start = doc.create_comment("start")
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
// pub fn VNode::validate(self : VNode) -> Bool {
//   fn validate_array(nodes : Array[VNode]) -> Bool {
//     let mut ok = true
//     for node in nodes {
//       if ok && !node.validate() {
//         ok = false
//       }
//     }
//     ok
//   }

//   fn validate_children(children : Children) -> Bool {
//     match children {
//       Array(nodes) => validate_array(nodes)
//       Map(map) => {
//         let mut ok = true
//         for _, node in map {
//           if ok && !node.validate() {
//             ok = false
//           }
//         }
//         ok
//       }
//     }
//   }

//   match self {
//     Elem(_, _, children, namespace_uri~, node~) =>
//       namespace_uri is Some(_) && node is Some(_) && validate_children(children)
//     Text(_, node~) => node is Some(_)
//     Frag(children, start~, end~) =>
//       start is Some(_) && end is Some(_) && validate_array(children)
//     Cell(cell, start~, end~) =>
//       start is Some(_) && end is Some(_) && cell.node().validate()
//   }
// }

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
fn remove_range(n : @dom.Node, s : @dom.Comment, e : @dom.Comment) -> Unit {
  while s.get_next_sibling().to_option() is Some(next) &&
        !next.is_same_node(e.as_node()) {
    n.remove_child(next)
  }
  n.remove_child(s.as_node())
  n.remove_child(e.as_node())
}

///|
fn create_node(new : VNode, sandbox : Sandbox) -> @dom.Node {
  ...
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
            v2.insert(sandbox, cell_id, parent, before)
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
