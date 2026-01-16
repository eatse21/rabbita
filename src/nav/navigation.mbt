///|
/// Create a command to go back in history. 
/// This will cause the page to reload.
pub fn back() -> Cmd {
  Effect(_ => @dom.window().history_go_back())
}

///|
/// Create a command to go forward in history. 
/// This will cause the page to reload.
pub fn forward() -> Cmd {
  Effect(_ => @dom.window().history_go_forward())
}

///|
/// Create a command to load a new URL. 
/// This will cause the page to reload.
pub fn load(url : String) -> Cmd {
  Effect(_ => @dom.window().load_url(url))
}

///|
/// Create a command to reload the current url.
pub fn reload() -> Cmd {
  Effect(_ => @dom.window().reload_url())
}

///|
/// Create a command to push a new URL to history but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn push_url(url : String) -> Cmd {
  Effect(scheduler => {
    @dom.window().push_url(url)
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    scheduler.pending_url_changed(url)
  })
}

///|
/// Create a command to change the URL but not trigger a page load.
/// 
/// This will trigger the `url_changed` message.
pub fn replace_url(url : String) -> Cmd {
  Effect(scheduler => {
    @dom.window().replace_url(url)
    guard (try? @url.parse(@dom.window().current_url())) is Ok(url)
    scheduler.pending_url_changed(url)
  })
}
