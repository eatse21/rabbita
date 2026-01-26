///|
struct TEA[Model, Msg] {
  mut model : Model
  mut node : @vdom.VNode
  mut is_dirty : Bool
  dispatcher : Dispatcher[Msg]
  update : (Dispatcher[Msg], Msg, Model) -> (@cmd.Cmd, Model)
  view : (Dispatcher[Msg], Model) -> @html.Html
  id : @vdom.Id
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with dirty_flag(self) {
  self.is_dirty
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with id(self) {
  self.id
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with step(self, scheduler) {
  if self.dispatcher.inbox.pop() is Some(msg) {
    let (cmd, model) = (self.update)(self.dispatcher, msg, self.model)
    self.model = model
    scheduler.add(cmd)
    self.is_dirty = true
  } else {
    // violate the invariant
  }
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with node(self) {
  self.node
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with refersh(self) {
  self.node = (self.view)(self.dispatcher, self.model).to_virtual_dom()
  self.is_dirty = false
}

///|
struct Dispatcher[Msg] {
  id : @vdom.Id
  inbox : @queue.Queue[Msg]
}

///|
pub fn[Msg] Dispatcher::message(self : Self[Msg], msg : Msg) -> Cmd {
  // carry the drain (which own model and update) in message will cause memeory leak in RC
  Message(self.id, () => self.inbox.push(msg))
}

///|
pub fn[Model, Msg] TEA::new(
  model~ : Model,
  update~ : (Dispatcher[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Dispatcher[Msg], Model) -> Html,
) -> TEA[Model, Msg] {
  let id = @vdom.Id::new()
  let dispatcher = { id, inbox: @queue.new() }
  let node = @vdom.VNode::fragment([])
  let self = { view, update, dispatcher, id, model, node, is_dirty: true }
  self
}
