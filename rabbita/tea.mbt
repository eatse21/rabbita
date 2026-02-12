///|
using @runtime {trait IsCell}

///|
priv struct TypedCell[Model, Msg] {
  model : Ref[Model]
  dispatcher : Dispatcher[Msg]
  dispatch : (Msg) -> Cmd
  update : (Dispatch[Msg], Msg, Model) -> (Cmd, Model)
  view : (Dispatch[Msg], Model) -> @html.Html
  flags : @runtime.Flags
}

///|
pub type Dispatch[Msg] = (Msg) -> Cmd

///|
impl[Model, Msg] IsCell for TypedCell[Model, Msg] with step(self, scheduler) {
  if self.dispatcher.inbox.pop() is Some(msg) {
    let (cmd, model) = (self.update)(self.dispatch, msg, self.model.val)
    self.model.val = model
    scheduler.add(cmd)
    self.flags.mark_dirty()
  } else {
    // violate the invariant
  }
}

///|
impl[Model, Msg] IsCell for TypedCell[Model, Msg] with view(self) {
  (self.view)(self.dispatch, self.model.val).0
}

///|
impl[Model, Msg] IsCell for TypedCell[Model, Msg] with flags(self) {
  self.flags
}

///|
priv struct Dispatcher[Msg] {
  id : @runtime.Id
  inbox : @queue.Queue[Msg]
}

///|
fn[Msg] Dispatcher::message(self : Self[Msg], msg : Msg) -> Cmd {
  // carry the drain (which own model and update) in message will cause memeory leak in RC
  @runtime.message(self.id, () => self.inbox.push(msg))
}

///|
struct Cell(&IsCell)

///|
pub fn Cell::view(self : Self) -> Html {
  Html::from_vnode(@runtime.VNode::slot(self.0))
}

///|
pub fn[Model, Msg] cell(
  model~ : Model,
  update~ : (Dispatch[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Dispatch[Msg], Model) -> Html,
) -> Cell {
  let flags = @runtime.Flags::new()
  let dispatcher = { id: flags.id(), inbox: @queue.new() }
  let dispatch = m => dispatcher.message(m)
  let model = @ref.new(model)
  Cell({ view, update, dispatcher, dispatch, model, flags })
}

///|
pub fn[Model, Msg] cell_with_dispatch(
  model~ : Model,
  update~ : (Dispatch[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Dispatch[Msg], Model) -> Html,
) -> (Dispatch[Msg], Cell) {
  let flags = @runtime.Flags::new()
  let dispatcher = { id: flags.id(), inbox: @queue.new() }
  let dispatch = m => dispatcher.message(m)
  let model = @ref.new(model)
  (dispatch, Cell({ view, update, dispatcher, dispatch, model, flags }))
}

///|
pub fn[Model, Msg] simple_cell(
  model~ : Model,
  update~ : (Msg, Model) -> Model,
  view~ : (Dispatch[Msg], Model) -> Html,
) -> Cell {
  cell(model~, update=(_, msg, model) => (none, update(msg, model)), view~)
}

///|
pub fn static_cell(html : Html) -> Cell {
  cell(model=(), update=fn(_, _ : Unit, _ : Unit) { (none, ()) }, view=fn(
    _,
    _,
  ) {
    html
  })
}
