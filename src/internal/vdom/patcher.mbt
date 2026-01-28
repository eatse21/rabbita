// ///|
// trait Patcher {
//   set_anchor(Self, VNode?) -> Unit
//   /// insert new node before anchor
//   insert(Self, new~ : VNode) -> Unit
//   // delete the node, under current parent
//   remove(Self, old~ : VNode) -> Unit
//   relocate(
//     Self,
//     cell1 : &Cell,
//     start1 : @dom.Comment,
//     end1 : @dom.Comment,
//     start2 : @dom.Comment,
//     end2 : @dom.Comment,
//   ) -> Unit
//   patch_text(Self, old~ : VNode, String) -> Unit
//   patch_frag(Self, old~ : VNode, () -> Unit) -> Unit
//   patch_elem(Self, old~ : VNode, () -> Unit) -> Unit
//   // patch attr
//   attr_remove(Self, String) -> Unit
//   attr_insert(Self, String, String) -> Unit
//   // patch property 
//   prop_remove(Self, String) -> Unit
//   prop_insert(Self, String, @variant.Variant) -> Unit
//   // patch style
//   style_remove(Self, String) -> Unit
//   style_insert(Self, String, String) -> Unit
//   // patch listener 
//   add_listener(Self, String, @dom.Listener) -> Unit
// }

// ///|
// enum Current {
//   Elem(@dom.Element)
//   Frag(@dom.Node, @dom.Comment, @dom.Comment)
// }

// ///|
// priv struct DomPatcher {
//   stack : Array[Current]
//   scheduler : &Scheduler
//   captured_link_listener : @dom.Listener
//   cell_stack : Array[Id]
//   mut anchor : @js.Nullable[@dom.Node]
// }

// ///|
// fn DomPatcher::new(
//   root : @dom.Element,
//   root_id : Id,
//   scheduler : &Scheduler,
//   captured_link_listener : @dom.Listener,
// ) -> DomPatcher {
//   {
//     stack: [Elem(root)],
//     cell_stack: [root_id],
//     scheduler,
//     captured_link_listener,
//     anchor: @js.Nullable::null(),
//   }
// }

// ///|
// fn DomPatcher::current(self : Self) -> @dom.Node {
//   match self.stack.last() {
//     None => panic()
//     Some(Elem(e)) => e.as_node()
//     Some(Frag(n, _, _)) => n
//   }
// }

// ///|
// fn DomPatcher::element(self : Self) -> @dom.Element {
//   match self.stack.last() {
//     Some(Elem(e)) => e
//     _ => panic()
//   }
// }

// ///|
// fn DomPatcher::html_element(self : Self) -> @dom.HTMLElement {
//   match self.stack.last() {
//     Some(Elem(e)) => e.to_html_element().unwrap()
//     _ => panic()
//   }
// }

// ///|
// impl Patcher for DomPatcher with set_anchor(self, node) {
//   match node {
//     None => self.anchor = @js.Nullable::null()
//     Some(Elem(_, _, _, node=Some(n), ..) | Text(_, node=Some(n))) =>
//       self.anchor = @js.Nullable::from_option(Some(n))
//     Some(Frag(_, end=Some(c), ..) | Cell(_, end=Some(c), ..)) =>
//       self.anchor = @js.Nullable::from_option(Some(c.as_node()))
//     _ => panic()
//   }
// }

// ///|
// impl Patcher for DomPatcher with patch_elem(self, old~, f) {
//   self.stack.push(Elem(old.get_node().to_element().unwrap()))
//   f()
//   self.stack.pop() |> ignore
// }

// ///|
// impl Patcher for DomPatcher with insert(self, new~) {
//   let new = self.create_node(new)
//   self.current().insert_before(new, self.anchor)
// }

// ///|
// impl Patcher for DomPatcher with patch_frag(self, old~, f) {
//   guard old is Frag(_, start~, end~)
//   let parent = end.unwrap().get_parent_node().unwrap()
//   self.stack.push(Frag(parent, start.unwrap(), end.unwrap()))
//   f()
//   self.stack.pop() |> ignore
// }

// ///|
// extern "js" fn log_node(x : @dom.Node) -> Unit = "(x) => console.log(x)"

// ///|
// impl Patcher for DomPatcher with relocate(self, cell1, s1, e1, s2, e2) {
//   self.scheduler.unsubscribe(self.cell_stack.last().unwrap(), cell1)
//   let n = self.current()
//   remove_range(n, s1, e1)
//   let e2 = e2.as_node()
//   while s2.get_next_sibling().to_option() is Some(next) &&
//         !next.is_same_node(e2) {
//     n.insert_before(next, self.anchor)
//   }
// }


// ///|
// impl Patcher for DomPatcher with remove(self, old~) {
//   let n = self.current()
//   match old {
//     Frag(_, start=Some(s), end=Some(e)) => remove_range(n, s, e)
//     Cell(c, start=Some(s), end=Some(e)) => {
//       self.scheduler.unsubscribe(self.cell_stack.last().unwrap(), c)
//       remove_range(n, s, e)
//     }
//     _ => n.remove_child(old.get_node())
//   }
// }

// ///|
// impl Patcher for DomPatcher with style_insert(self, k, v) {
//   self.html_element().get_style().set_property(k, v)
// }

// ///|
// impl Patcher for DomPatcher with style_remove(self, k) {
//   self.html_element().get_style().remove_property(k) |> ignore
// }

// ///|
// impl Patcher for DomPatcher with patch_text(_, old~, str) {
//   old
//   .get_node()
//   .to_text()
//   .unwrap()
//   .set_node_value(@js.Nullable::from_option(Some(str)))
// }

// ///|
// impl Patcher for DomPatcher with attr_remove(self, key) {
//   self.element().remove_attribute(key)
// }

// ///|
// impl Patcher for DomPatcher with attr_insert(self, key, value) {
//   self.element().set_attribute(key, value)
// }

// ///|
// impl Patcher for DomPatcher with prop_remove(self, key) {
//   self.element().remove_property(key)
// }

// ///|
// impl Patcher for DomPatcher with prop_insert(self, key, value) {
//   self.element().set_property(key, variant_to_js_value(value))
// }

// ///|
// impl Patcher for DomPatcher with add_listener(self, event, listener) {
//   self.element().add_event_listener(event, listener)
// }

// ///|
// fn DomPatcher::create_node(self : Self, vnode : VNode) -> @dom.Node {
//   match vnode {
//     Text(s, ..) as v => {
//       let node = @dom.document().create_text_node(s).as_node()
//       v.node = Some(node)
//       node
//     }
//     Cell(c, ..) as v => {
//       self.scheduler.subscribe(self.cell_stack.last().unwrap(), c)
//       if c.dirty_flag() {
//         c.refersh()
//       }
//       let start = @dom.document().create_comment("")
//       let end = @dom.document().create_comment("")
//       v.start = Some(start)
//       v.end = Some(end)
//       let fragment = @dom.document().create_document_fragment()
//       fragment.append_child(start.as_node())
//       fragment.append_child(self.create_node(c.node()))
//       fragment.append_child(end.as_node())
//       fragment.as_node()
//     }
//     Frag(childs, ..) as v => {
//       let fragment = @dom.document().create_document_fragment()
//       let start = @dom.document().create_comment("start")
//       let end = @dom.document().create_comment("end")
//       fragment.append_child(start.as_node())
//       for child in childs {
//         let child = self.create_node(child)
//         fragment.append_child(child)
//       }
//       fragment.append_child(end.as_node())
//       v.start = Some(start)
//       v.end = Some(end)
//       fragment.as_node()
//     }
//     Elem(tag, props, childs, namespace_uri=_, ..) as v => {
//       let element = @dom.document().create_element(
//         if tag == CAPTURED_LINK_TAG {
//           "a"
//         } else {
//           tag
//         },
//       )
//       let { slots, handlers, attrs, props, styles } = props
//       for e, h in handlers {
//         let slot = @ref.new(h)
//         let scheduler = self.scheduler
//         element.add_event_listener(e, x => (slot.val)(x, scheduler))
//         slots[e] = slot
//       }
//       if tag == CAPTURED_LINK_TAG {
//         element.add_event_listener("click", self.captured_link_listener)
//       }
//       for n, val in attrs {
//         element.set_attribute(n, val)
//       }
//       for n, val in props {
//         element.set_property(n, variant_to_js_value(val))
//       }
//       let style_sheet = element.to_html_element().unwrap().get_style()
//       for n, val in styles {
//         style_sheet.set_property(n, val)
//       }
//       match childs {
//         Array(xs) =>
//           for x in xs {
//             element.append_child(self.create_node(x))
//           }
//         Map(mp) =>
//           for _, x in mp {
//             element.append_child(self.create_node(x))
//           }
//       }
//       let node = element.as_node()
//       v.node = Some(node)
//       node
//     }
//   }
// }
