///|
pub using @cmd {type Cmd, none, batch, perform, attempt, delay}

///|
pub using @html {type Html}

///|
/// Create an application from a root `Cell`.
///
/// Use `simple_cell()`, `static_cell()`, `cell()`, `cell_with_disptach()` to create a cell.
/// Call `mount` to attach it to a DOM element.
/// Optionally call `with_route` to install routing callbacks.
/// 
/// **For beginners, `simple_cell` is recommended. See its documentation for more details.**
/// 
/// ## Example
/// 
/// ```moonbit check
/// test "minimal static page" {
///   let app = @rabbita.static_cell(div("hello world"))
///   @rabbita.new(app).mount("main")
/// }
/// ```
pub fn new(root : Cell) -> App {
  let sandbox = @runtime.Sandbox::new(root.0)
  App::{ sandbox, }
}

///|
/// Configure routing callbacks for this app.
///
/// - `url_changed` is triggered for browser history navigation and when
///   `push_url` / `replace_url` commands are used.
/// - `url_request` is triggered when captured links `@html.a()` are clicked.
///
/// If the app is already mounted, a `url_changed` command for the current URL
/// will be enqueued immediately.
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
/// Mount the app into the DOM element identified by `element_id`.
///
/// This initializes the runtime and schedules the first render flush.
/// If routing is configured, the current URL is also dispatched on mount.
pub fn App::mount(self : Self, element_id : String) -> Unit {
  self.sandbox.mount = element_id
  self.trigger_initial_url_changed()
  @dom.document()
  .get_element_by_id(element_id)
  .unwrap()
  .set_inner_html("<div></div>")
  self.sandbox.initialize()
  self.sandbox.flush()
}

///|
fn App::trigger_initial_url_changed(self : Self) -> Unit {
  if self.sandbox.on_url_changed is Some(_) {
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    self.sandbox.add_url_changed(url)
  }
}

///|
/// A running Rabbita application.
struct App {
  sandbox : @runtime.Sandbox
}
