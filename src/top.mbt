///|
pub using @cmd {type Cmd}

///|
pub using @cmd {none, batch, perform, attempt}

///|
using @html {type Html}

///|
/// Start the application.
/// 
/// - `model` is the state of your application.
/// - `view` is a way to turn your model into HTML.
/// - `update` a way to update your state based on messages.
/// 
/// These three are the core of the TEA. Rabbit-TEA is highly unstable at this time, 
/// but it follows the same pattern as Elm. You can visit https://guide.elm-lang.org/ 
/// to get more intuition!
/// 
/// To start the application with router, you can use the `application` function.
pub fn[Msg] new(component : Component[Msg]) -> App {
  let mut curr_dom = @vdom.node("div", [], [])
  let mut sandbox : @vdom.Sandbox? = None
  fn render() -> Unit {
    let html = component.view()
    let new_dom = html.to_virtual_dom()
    new_dom.patch(
      curr_dom,
      sandbox.unwrap(),
      mount=sandbox.unwrap().mount_element,
    )
    curr_dom = new_dom
  }

  sandbox = Some(@vdom.Sandbox::new(render))
  App::{ sandbox: sandbox.unwrap() }
}

///|
pub fn App::with_route(
  self : Self,
  url_changed? : (@url.Url) -> @cmd.Effect,
  url_request? : (@url.UrlRequest) -> @cmd.Effect,
) -> Unit {
  @dom.window()
  .to_event_target()
  .add_event_listener("popstate", _ => {
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    match url_changed {
      Some(f) => self.sandbox.pending(f(url))
      None => ()
    }
  })
  self.sandbox.on_url_changed = url_changed.map(f => url => f(url))
  self.sandbox.on_url_request = url_request.map(f => url => f(url))
}

///|
pub fn App::mount(self : Self, element : String) -> Unit {
  self.sandbox.mount_element = element
  @dom.document()
  .get_element_by_id(element)
  .unwrap()
  .set_inner_html("<div></div>")
  self.sandbox.schedule()
}

///|
struct App {
  sandbox : @vdom.Sandbox
}
