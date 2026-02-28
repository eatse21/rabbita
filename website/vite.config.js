import { defineConfig } from 'vite'
import rabbita from '@rabbita/vite'
import { join } from 'path'
import { cpSync } from 'fs'

export default defineConfig({
  base: (process.env.VITE_BASE ?? '/').replace(/\/?$/, '/'),
  plugins: [
    rabbita(),
    {
      name: 'copy-doc',
      closeBundle() {
        cpSync(
          join(process.cwd(), '../doc'),
          join(process.cwd(), 'dist/doc'),
          { recursive: true },
        )
      },
    },
  ],
  server: {
    host: true,
    fs: { allow: ['..'] },
  },
})
