<script lang="ts">
  import { theme } from "@lib/stores";
  import { onMount } from "svelte";

  function handleThemeChange(e: MediaQueryListEvent) {
    theme.set(e.matches ? "dark" : "light");
  }

  onMount(() => {
    const themeQuery = matchMedia("(prefers-color-scheme: dark)");
    themeQuery.addEventListener("change", handleThemeChange);
    return () => themeQuery.removeEventListener("change", handleThemeChange);
  });
</script>

<svelte:head>
  <!-- SMUI Style -->
  <link rel="stylesheet" href={`/static/smui-${$theme}.css`} />
  <!-- Material Icons -->
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/icon?family=Material+Icons"
  />
  <!-- Roboto -->
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,600,700"
  />
  <!-- Roboto Mono -->
  <link
    rel="stylesheet"
    href="https://fonts.googleapis.com/css?family=Roboto+Mono"
  />
</svelte:head>
