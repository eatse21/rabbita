# rabbita-vite-plugin

Vite plugin for Rabbita applications built with MoonBit.

## What it handles

- Modern MoonBit output layout: `_build/js/<debug|release>/build`
- Main-package discovery via build metadata (`_build/packages.json`), so both `moon.pkg` and legacy `moon.pkg.json` projects work

## Install

```bash
npm i -D @rabbita/vite
```

## Usage

```ts
import { defineConfig } from 'vite'
import rabbita from '@rabbita/vite'

export default defineConfig({
  plugins: [rabbita()],
})
```

## Select the main package in Vite (optional)

If your module has multiple `is-main` packages, pass `main` to
choose one:

```ts
import { defineConfig } from 'vite'
import rabbita from '@rabbita/vite'

export default defineConfig({
  plugins: [rabbita({ main: 'relative/path/to/main2' })],
})
```

`main` is the package directory path relative to your module root
(for example: `main2` or `apps/web`).
