# Rabbita

A declarative and functional web UI framework inspired by The Elm Architecture.

## Example

```moonbit
///|
using @html {div, h1, button}

///|
fn main {
  struct Model {
    count : Int
  }
  enum Msg {
    Inc
    Dec
  }
  let app = cell(
    model={ count: 0 },
    update=(_, msg, model) => match msg {
      Inc => (none, { count: model.count + 1 })
      Dec => (none, { count: model.count - 1 })
    },
    view=(dispatch, model) => div([
      h1(model.count.to_string()),
      button(click=dispatch(Inc), "+"),
      button(click=dispatch(Dec), "-"),
    ]),
  )
  new(app).mount("main")
}
```

