///|
pub enum VNode {
  Elem(
    String,
    Props,
    Children,
    namespace_uri~ : String?,
    mut node~ : @dom.Node?
  )
  Text(String, mut node~ : @dom.Node?)
  Frag(Array[VNode], mut start~ : @dom.Comment?, mut end~ : @dom.Comment?)
  Cell(&Cell)
}

///|
pub fn VNode::elem(
  tag : String,
  props : Props,
  children : Children,
  namespace_uri? : String,
) -> VNode {
  Elem(tag, props, children, namespace_uri~, node=None)
}

///|
pub fn VNode::text(s : String) -> VNode {
  Text(s, node=None)
}

///|
pub fn VNode::cell(cell : &Cell) -> VNode {
  Cell(cell)
}

///|
pub fn VNode::fragment(childs : Array[VNode]) -> VNode {
  Frag(childs, start=None, end=None)
}

///|
pub(all) enum Children {
  Array(Array[VNode])
  Map(Map[String, VNode])
}

///|
fn VNode::set_node(self : Self, node : @dom.Node) -> Unit {
  match self {
    Text(_) as n => n.node = Some(node)
    Elem(_) as n => n.node = Some(node)
    Cell(c) => c.node().set_node(node)
    Frag(_, ..) => panic()
  }
}

///|
fn VNode::get_node(self : Self) -> @dom.Node {
  match self {
    Elem(_, _, _, node~, ..) | Text(_, node~) => node.unwrap()
    Cell(c) => c.node().get_node()
    Frag(_, end~, ..) => end.unwrap().get_parent_node().unwrap()
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
fn[P : Patcher] diff_node(
  old : VNode,
  new : VNode,
  patcher : P,
  scheduler : &Scheduler,
) -> Unit {
  match (old, new) {
    (
      Elem(tag1, props1, childs1, namespace_uri=ns1, ..),
      Elem(tag2, props2, childs2, namespace_uri=ns2, ..) as new,
    ) =>
      if tag1 != tag2 {
        patcher.replace(old~, new~)
      } else {
        patcher.patch_elem(old~, fn() {
          diff_props(props1, props2, patcher, scheduler)
          diff_children(childs1, childs2, patcher, scheduler)
        })
        new.set_node(old.get_node())
      }
    (Text(s1, ..), Text(s2, ..)) => {
      if s1 != s2 {
        patcher.patch_text(old~, new~, s2)
      }
      new.set_node(old.get_node())
    }
    (Frag(childs1, ..) as old, Frag(childs2, ..) as new) => {
      patcher.patch_frag(old~, fn() {
        diff_children(Array(childs1), Array(childs2), patcher, scheduler)
      })
      new.start = old.start
      new.end = old.end
    }
    (Cell(c1), Cell(c2)) =>
      if c2.dirty_flag() {
        let c1_old = c1.node()
        c2.refersh()
        let c2_new = c2.node()
        diff_node(c1_old, c2_new, patcher, scheduler)
      } else if c1.id() != c2.id() {
        patcher.replace_old(c1.node(), c2.node())
      }
    (_, _) => patcher.replace(old~, new~)
  }
}

///|
fn[P : Patcher] diff_props(
  old : Props,
  new : Props,
  patcher : P,
  scheduler : &Scheduler,
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
        patcher.add_listener(event, e => (slot.val)(e, scheduler))
        slots[event] = slot
      }
    }
  }
  new.slots = slots

  // O(n+m), TODO: use small sorted array to optimize this 
  // patch attributes
  for k, _ in old.attrs {
    if !new.attrs.contains(k) {
      patcher.attr_remove(k)
    }
  }
  for k, v2 in new.attrs {
    match old.attrs.get(k) {
      None => patcher.attr_insert(k, v2)
      Some(v1) => if v1 != v2 { patcher.attr_insert(k, v2) }
    }
  }
  // patch properties
  for k, _ in old.props {
    if !new.attrs.contains(k) {
      patcher.prop_remove(k)
    }
  }
  for k, v2 in new.props {
    match old.props.get(k) {
      None => patcher.prop_insert(k, v2)
      Some(v1) => if v1 != v2 { patcher.prop_insert(k, v2) }
    }
  }
  // patch styles
  for k, _ in old.styles {
    if !new.styles.contains(k) {
      patcher.style_remove(k)
    }
  }
  for k, v2 in new.styles {
    match old.styles.get(k) {
      None => patcher.style_insert(k, v2)
      Some(v1) => if v1 != v2 { patcher.style_insert(k, v2) }
    }
  }
}

///|
fn[P : Patcher] diff_children(
  old : Children,
  new : Children,
  patcher : P,
  scheduler : &Scheduler,
) -> Unit {
  match (old, new) {
    (Array(old), Array(new)) =>
      loop (old[:], new[:]) {
        ([], []) => ()
        ([], ys) =>
          for y in ys {
            patcher.insert(new=y)
          }
        (xs, []) =>
          for x in xs {
            patcher.remove(old=x)
          }
        ([x, .. xs], [y, .. ys]) => {
          diff_node(x, y, patcher, scheduler)
          continue (xs, ys)
        }
      }
    (Map(old), Map(new)) => {
      for k, v1 in old {
        if !new.contains(k) {
          patcher.remove(old=v1)
        }
      }
      for k, v2 in new {
        match old.get(k) {
          None => patcher.insert(new=v2)
          Some(v1) => diff_node(v1, v2, patcher, scheduler)
        }
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
        patcher.remove(old=x)
      }
      for y in iter(new) {
        patcher.insert(new=y)
      }
    }
  }
}

///|
pub fn vlink(props : Props, children : Children, escape~ : Bool) -> VNode {
  let tag = if escape { ESCAPED_LINK_TAG } else { NORMAL_LINK_TAG }
  VNode::elem(tag, props, children)
}
