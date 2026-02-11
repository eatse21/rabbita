# Rabbita

A declarative, functional web UI framework inspired by The Elm Architecture.

This project was previously named `Rabbit-TEA` and is now renamed to `rabbita`.

## Features

* Predictable flow 

  State changes follow a single, predictable update path, with explicit side‑effect management.

* Strict Types

  Rigorous types. No `Any` sprawl. No stringly-typed APIs.

* Balanced bundle size

  ~15 KB min+gzip, includes streaming VDOM diff and the MoonBit standard library (DCE via moonc).

* Modular

  Use `Cell` to split logic and reuse stateful views. Skip diff and patching for non-dirty cells.

## Example

```mbt check
///|
using @html {div, h1, button}

///|
fn init {
  struct Model {
    count : Int
  }
  enum Msg {
    Inc
    Dec
  }
  let app = @rabbita.simple_cell(
    model={ count: 0 },
    update=(msg, model) => {
      let { count } = model
      match msg {
        Inc => { count: count + 1 }
        Dec => { count: count - 1 }
      }
    },
    view=(dispatch, model) => {
      div([
        h1("\{model.count}"),
        button(on_click=dispatch(Inc), "+"),
        button(on_click=dispatch(Dec), "-"),
      ])
    },
  )
  new(app).mount("main")
}
```
