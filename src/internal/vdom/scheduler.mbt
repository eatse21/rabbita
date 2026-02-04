///|
pub(open) trait Scheduler {
  add(Self, Cmd) -> Unit
  add_url_changed(Self, Url) -> Unit
  add_url_request(Self, UrlRequest) -> Unit
  subscribe(Self, &Cell, &Cell) -> Unit
  unsubscribe(Self, &Cell, &Cell) -> Unit
}
