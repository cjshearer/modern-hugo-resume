import { fileURLToPath, URL } from "url";
import { defineConfig } from "vite";
import { svelte } from "@sveltejs/vite-plugin-svelte";

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte()],
  resolve: {
    alias: {
      "@assets": fileURLToPath(new URL("src/assets", import.meta.url)),
      "@lib": fileURLToPath(new URL("src/lib", import.meta.url)),
      "@components": fileURLToPath(
        new URL("src/lib/components", import.meta.url)
      ),
      "@themes": fileURLToPath(new URL("src/lib/themes", import.meta.url)),
    },
  },
});
