import { defineConfig } from 'vite'
import rabbita from '@rabbita/vite'

export default defineConfig({
  base: process.env.VITE_BASE ?? '/',
  plugins: [rabbita()],
  server: {
    host: true,
  },
})
