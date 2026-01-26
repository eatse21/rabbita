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
  patch_frag(Self, old~ : VNode, () -> Unit) -> Unit
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
enum Current {
  Elem(@dom.Element)
  Frag(@dom.Node, @dom.Comment, @dom.Comment)
}

///|
priv struct DomPatcher {
  stack : Array[Current]
  scheduler : &Scheduler
}

///|
fn DomPatcher::new(root : @dom.Element, scheduler : &Scheduler) -> DomPatcher {
  { stack: [Elem(root)], scheduler }
}

///|
fn DomPatcher::current(self : Self) -> Current {
  self.stack.last().unwrap()
}

///|
fn DomPatcher::end_anchor(self : Self) -> @dom.Node? {
  match self.stack.last().unwrap() {
    Elem(_) => None
    Frag(_, _, e) => Some(e.as_node())
  }
}

///|
impl Patcher for DomPatcher with insert(self, new~) {
  let new = self.create_node(new)
  match self.current() {
    Elem(e) => e.append_child(new)
    Frag(n, _, c) => n.insert_before(new, c.as_node())
  }
}

///|
impl Patcher for DomPatcher with patch_frag(self, old~, f) {
  guard old is Frag(_, start~, end~)
  let parent = end.unwrap().get_parent_node().unwrap()
  self.stack.push(Frag(parent, start.unwrap(), end.unwrap()))
  f()
  self.stack.pop() |> ignore
}

///|
impl Patcher for DomPatcher with replace(self, old~, new~) {
  if old is Cell(c) {
    self.scheduler.unsubscribe(c)
  }
  let n = match self.current() {
    Elem(e) => e.as_node()
    Frag(n, _, _) => n
  }
  fn handle_fragment(n : @dom.Node, s : @dom.Comment, e : @dom.Comment) {
    while s.get_next_sibling().to_option() is Some(next) &&
          !next.is_same_node(e.as_node()) {
      n.remove_child(next)
    }
    n.replace_child(s.as_node(), self.create_node(new))
    n.remove_child(e.as_node())
  }

  match old {
    Frag(_, start=Some(s), end=Some(e)) => handle_fragment(n, s, e)
    Cell(c) if c.node() is Frag(_, start=Some(s), end=Some(e)) =>
      handle_fragment(n, s, e)
    _ => n.replace_child(old.get_node(), self.create_node(new))
  }
}

///|
impl Patcher for DomPatcher with replace_old(self, old1, old2) {
  if old1 is Cell(c) {
    self.scheduler.unsubscribe(c)
  }
  let n = match self.current() {
    Elem(e) => e.as_node()
    Frag(n, _, _) => n
  }
  fn handle_fragment(n : @dom.Node, s : @dom.Comment, e : @dom.Comment) {
    while s.get_next_sibling().to_option() is Some(next) &&
          !next.is_same_node(e.as_node()) {
      n.remove_child(next)
    }
    n.replace_child(s.as_node(), old2.get_node())
    n.remove_child(e.as_node())
  }

  match old1 {
    Frag(_, start=Some(s), end=Some(e)) => handle_fragment(n, s, e)
    Cell(c) if c.node() is Frag(_, start=Some(s), end=Some(e)) =>
      handle_fragment(n, s, e)
    _ => n.replace_child(old1.get_node(), old2.get_node())
  }
}

///|
impl Patcher for DomPatcher with remove(self, old~) {
  if old is Cell(c) {
    self.scheduler.unsubscribe(c)
  }
  let n = match self.current() {
    Elem(e) => e.as_node()
    Frag(n, _, _) => n
  }
  fn handle_fragment(n : @dom.Node, s : @dom.Comment, e : @dom.Comment) {
    while s.get_next_sibling().to_option() is Some(next) &&
          !next.is_same_node(e.as_node()) {
      n.remove_child(next)
    }
    n.remove_child(s.as_node())
    n.remove_child(e.as_node())
  }

  match old {
    Frag(_, start=Some(s), end=Some(e)) => handle_fragment(n, s, e)
    Cell(c) if c.node() is Frag(_, start=Some(s), end=Some(e)) =>
      handle_fragment(n, s, e)
    _ => n.remove_child(old.get_node())
  }
}

///|
impl Patcher for DomPatcher with style_insert(self, k, v) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.get_style().set_property(k, v)
}

///|
impl Patcher for DomPatcher with style_remove(self, k) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.get_style().remove_property(k) |> ignore
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
  self.stack.push(Elem(old.get_node().to_element().unwrap()))
  f()
  self.stack.pop() |> ignore
}

///|
impl Patcher for DomPatcher with attr_remove(self, key) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.remove_attribute(key)
}

///|
impl Patcher for DomPatcher with attr_insert(self, key, value) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.set_attribute(key, value)
}

///|
impl Patcher for DomPatcher with prop_remove(self, key) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.remove_property(key)
}

///|
impl Patcher for DomPatcher with prop_insert(self, key, value) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.set_property(key, variant_to_js_value(value))
}

///|
impl Patcher for DomPatcher with add_listener(self, event, listener) {
  let h = match self.current() {
    Elem(e) => e.to_html_element().unwrap()
    Frag(_) => panic()
  }
  h.add_event_listener(event, listener)
}

///|
fn DomPatcher::create_node(self : Self, vnode : VNode) -> @dom.Node {
  match vnode {
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
    Frag(childs, ..) as vnode => {
      let fragment = @dom.document().create_document_fragment()
      let start = @dom.document().create_comment("start")
      let end = @dom.document().create_comment("end")
      fragment.append_child(start.as_node())
      for child in childs {
        let child = self.create_node(child)
        fragment.append_child(child)
      }
      fragment.append_child(end.as_node())
      vnode.start = Some(start)
      vnode.end = Some(end)
      fragment.as_node()
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
