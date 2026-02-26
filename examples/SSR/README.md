# Server side rendering

This example shows a minimal Rabbita setup that combines:

- server-side rendering (SSR) on `native` using `@rabbita.render_to_string`
- client-side mounting on `js` for interactive SPA updates

When you open `/`, the native server returns a full HTML page with pre-rendered
markup in `<div id="app">...</div>`. The browser then loads `assets/main.js`,
starts the Rabbita app, and continues as a normal SPA.

## build step

In this module's directory:

1. install dependencies

  ```
  npm install
  ```

2. generate the client assets

  ```
  npm run build
  ```

3. run the server

  ```
  moon run ./main --target native
  ```

Then open `http://localhost:8006`.
