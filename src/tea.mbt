///|
struct TEA[Model, Msg] {
  mut model : Model
  dispatcher : Dispatcher[Msg]
  update : (Dispatcher[Msg], Msg, Model) -> (@cmd.Cmd, Model)
  view : (Dispatcher[Msg], Model) -> @html.Html
  state : @vdom.State
}

///|
pub fn[Model, Msg] TEA::dispatcher(self : Self[Model, Msg]) -> Dispatcher[Msg] {
  self.dispatcher
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with state(self) {
  self.state
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with step(self, scheduler) {
  if self.dispatcher.inbox.pop() is Some(msg) {
    let (cmd, model) = (self.update)(self.dispatcher, msg, self.model)
    self.model = model
    scheduler.add(cmd)
    self.state.mark_dirty()
  } else {
    // violate the invariant
  }
}

///|
pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with view(self) {
  (self.view)(self.dispatcher, self.model).0
}

// ///|
// pub impl[Model, Msg] @vdom.Cell for TEA[Model, Msg] with refersh(self) {
//   self.node = (self.view)(self.dispatcher, self.model).to_virtual_dom()
//   self.is_dirty = false
// }

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
pub fn[Payload, Msg] Dispatcher::message1(
  self : Self[Msg],
  msg : (Payload) -> Msg,
) -> (Payload) -> Cmd {
  x => self.message(msg(x))
}

///|
pub fn[Model, Msg] TEA::new(
  model~ : Model,
  update~ : (Dispatcher[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Dispatcher[Msg], Model) -> Html,
) -> TEA[Model, Msg] {
  let state = @vdom.State::new()
  let dispatcher = { id: state.id(), inbox: @queue.new() }
  let self = { view, update, dispatcher, model, state }
  self
}
