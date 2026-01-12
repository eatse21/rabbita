///|
pub using @cmd {type Cmd, type Command}

///|
pub using @cmd {none, batch, task, perform, attempt}

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
pub fn[Msg] new(component : Component[Msg], mount? : String = "app") -> App {
  @dom.document()
  .get_element_by_id(mount)
  .unwrap()
  .set_inner_html("<div></div>")
  let mut curr_dom = @vdom.node("div", [], [])
  let mut sandbox : @vdom.Sandbox? = None
  fn render() -> Unit {
    let html = component.view()
    let new_dom = html.to_virtual_dom()
    new_dom.patch(curr_dom, sandbox.unwrap(), mount~)
    curr_dom = new_dom
  }

  sandbox = Some(
    @vdom.Sandbox::new(render, on_url_changed=ignore, on_url_request=ignore),
  )
  App::{ sandbox: sandbox.unwrap() }
}

///|
pub fn App::with_route(
  self : Self,
  url_changed? : (@url.Url) -> @cmd.Message,
  url_request? : (@url.UrlRequest) -> @cmd.Message,
) -> Unit {
  self.sandbox.set_on_url_changed(
    url_changed.map(f => url => self.sandbox..pending(f(url))..schedule()),
  )
  self.sandbox.set_on_url_request(
    url_request.map(f => url => self.sandbox..pending(f(url))..schedule()),
  )
}

///|
pub fn App::startup(self : Self) -> Unit {
  self.sandbox.schedule()
}

///|
struct App {
  sandbox : @vdom.Sandbox
}
