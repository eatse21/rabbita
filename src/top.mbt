///|
pub using @runtime {trait Cell, type Cmd, none, batch, perform, attempt}

///|
pub using @html {type Html}

///|
/// Start the application.
/// 
/// - `model` is the state of your application.
/// - `view` is a way to turn your model into HTML.
/// - `update` a way to update your state based on messages.
/// 
/// These three are the core of the TEA. rabbita is highly unstable at this time, 
/// but it follows the same pattern as Elm. You can visit https://guide.elm-lang.org/ 
/// to get more intuition!
/// 
/// To start the application with router, you can use the `application` function.
pub fn new(root : &@runtime.Cell) -> App {
  let sandbox = @runtime.Sandbox::new(root)
  App::{ sandbox, }
}

///|
pub fn App::with_route(
  self : Self,
  url_changed? : (@url.Url) -> Cmd,
  url_request? : (@url.UrlRequest) -> Cmd,
) -> Unit {
  @dom.window()
  .to_event_target()
  .add_event_listener("popstate", _ => {
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    match url_changed {
      Some(f) => self.sandbox.add(f(url))
      None => ()
    }
  })
  self.sandbox.on_url_changed = url_changed.map(f => url => f(url))
  self.sandbox.on_url_request = url_request.map(f => url => f(url))
  if self.sandbox.mount != "" {
    self.trigger_initial_url_changed()
  }
}

///|
pub fn App::mount(self : Self, element : String) -> Unit {
  self.sandbox.mount = element
  self.trigger_initial_url_changed()
  @dom.document()
  .get_element_by_id(element)
  .unwrap()
  .set_inner_html("<div></div>")
  self.sandbox.initialize()
  self.sandbox.flush()
}

///|
fn App::trigger_initial_url_changed(self : Self) -> Unit {
  match self.sandbox.on_url_changed {
    None => ()
    Some(_) => {
      guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
      self.sandbox.add_url_changed(url)
    }
  }
}

///|
struct App {
  sandbox : @runtime.Sandbox
}
