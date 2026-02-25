import { defineConfig } from 'vite';
import rabbita from '../../src/index';
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
    plugins: [
        rabbita(),
        tailwindcss()
    ],
});
