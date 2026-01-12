///|
using @cmd {type Message}

///|
struct Model {
  element : @dom.HTMLCanvasElement
  wrapper : @html.Html
}

///|
pub fn Model::context2d(self : Model) -> Context2D {
  self.element.get_context("2d").to0().unwrap()
}

///|
pub fn new(
  width~ : Double,
  height~ : Double,
  click? : (@html.Mouse) -> Message,
  mousemove? : (@html.Mouse) -> Message,
  mousedown? : (@html.Mouse) -> Message,
  mouseup? : (@html.Mouse) -> Message,
  mouseenter? : (@html.Mouse) -> Message,
  mouseleave? : (@html.Mouse) -> Message,
) -> Model {
  let canvas = @dom.document().create_element("canvas")
  let attributes = {
    let attrs = [
      @html.attribute("width", width.to_string()),
      @html.attribute("height", height.to_string()),
    ]
    [
      click.map(@html.on_click),
      mousemove.map(@html.on_mouse_move),
      mousedown.map(@html.on_mouse_down),
      mouseup.map(@html.on_mouse_up),
      mouseenter.map(@html.on_mouse_enter),
      mouseleave.map(@html.on_mouse_leave),
    ].each(x => match x {
      None => ()
      Some(attr) => attrs.push(attr)
    })
    @ref.new(Some(attrs))
  }
  let element = canvas.to_html_canvas_element().unwrap()
  {
    element,
    wrapper: @html.external(
      canvas.as_node(),
      attributes,
      width=width.to_int(),
      height=height.to_int(),
    ),
  }
}

///|
pub fn Model::to_html(self : Model) -> @html.Html {
  self.wrapper
}
