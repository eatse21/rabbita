///|
struct Component[Msg] {
  make_message : (Msg) -> @cmd.Effect
  make_view : () -> Html
}

///|
pub fn[Msg] Component::view(self : Self[Msg]) -> Html {
  (self.make_view)()
}

///|
pub fn[Msg] Component::message(self : Self[Msg], msg : Msg) -> @cmd.Effect {
  (self.make_message)(msg)
}

///|
pub fn[Msg, Model] component(
  model~ : Model,
  update~ : (Component[Msg], Msg, Model) -> (Cmd, Model),
  view~ : (Component[Msg], Model) -> Html,
) -> Component[Msg] {
  let mut component : Component[Msg]? = None
  let curr_model = @ref.new(model)
  fn make_message(msg : Msg) -> @cmd.Effect {
    Effect(_ => {
      let (cmd, model) = update(component.unwrap(), msg, curr_model.val)
      curr_model.val = model
      ignore(cmd) //fixme
    })
  }

  fn make_view() -> Html {
    view(component.unwrap(), curr_model.val)
  }

  component = Some(Component::{ make_message, make_view })
  component.unwrap()
}
