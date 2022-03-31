import { writable } from "svelte/store";
import type { Writable } from "svelte/store";

const theme: Writable<Theme> = writable(
  matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"
);

export { theme };
