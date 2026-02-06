///|
struct TEA[Model, Msg] {
  mut model : Model
  dispatcher : Dispatcher[Msg]
  dispatch : (Msg) -> Cmd
  update : (Dispatch[Msg], Msg, Model) -> (Cmd, Model)
  view : (Dispatch[Msg], Model) -> @html.Html
  state : @runtime.State
}

///|
pub impl[Model, Msg] Cell for TEA[Model, Msg] with state(self) {
  self.state
}

///|
pub impl[Model, Msg] Cell for TEA[Model, Msg] with step(self, scheduler) {
  if self.dispatcher.inbox.pop() is Some(msg) {
    let (cmd, model) = (self.update)(self.dispatch, msg, self.model)
    self.model = model
    scheduler.add(cmd)
    self.state.mark_dirty()
  } else {
    // violate the invariant
  }
}

///|
pub impl[Model, Msg] Cell for TEA[Model, Msg] with view(self) {
  (self.view)(self.dispatch, self.model).0
}

///|
priv struct Dispatcher[Msg] {
  id : @runtime.Id
  inbox : @queue.Queue[Msg]
}

///|
fn[Msg] Dispatcher::message(self : Self[Msg], msg : Msg) -> Cmd {
  // carry the drain (which own model and update) in message will cause memeory leak in RC
  Message(self.id, () => self.inbox.push(msg))
}

///|
pub type Dispatch[Msg] = (Msg) -> Cmd

///|
pub fn[Model, Msg] TEA::new(
  model~ : Model,
  update~ : (Dispatch[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Dispatch[Msg], Model) -> Html,
) -> TEA[Model, Msg] {
  let state = @runtime.State::new()
  let dispatcher = { id: state.id(), inbox: @queue.new() }
  let dispatch = m => dispatcher.message(m)
  { view, update, dispatcher, dispatch, model, state }
}
