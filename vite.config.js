import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      'abi': fileURLToPath(new URL('./build/contracts', import.meta.url)),
      'store': fileURLToPath(new URL('./store', import.meta.url)),
    }
  }
})
