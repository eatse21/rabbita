# Rabbita (Rabbit-TEA)

A declarative and functional web UI framework inspired by The Elm Architecture.

## Features

- Refactor Safety

    By leveraging *pattern matching* and *tagged union*, exhaustive checks provide 
    a better refactoring experience. MoonBit helps prevent common runtime errors 
    ensuring more robust and reliable code.

- Maintainable State

    The state is globally managed, making it easier to maintain the entire application.
    By utilizing persistent data structures from `moonbitlang/core/immut`, 
    you can implement advanced features such as undo/redo functionality with ease.

- Lightweight Runtime

    The generated JavaScript file is 33KB after minified for a project like 
    `src/example/counter`, including the virtual DOM.

## Basic Example

```moonbit
using @html {div, h1, button}

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

For more examples, see [rabbit-tea-examples](https://github.com/moonbit-community/rabbit-tea-examples).

# Getting started 

To get started, you can use the [Rabbit-TEA template](https://github.com/Yoorkin/rabbit-tea-tailwind).

It also includes instructions for debugging your code with Rabbit-TEA.
