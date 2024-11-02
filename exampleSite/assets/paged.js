/* TODO: see caching behavior for GetRemote so we can fetch this during nix build  */
import "https://unpkg.com/pagedjs@0.4.3/dist/paged.min.js";

async function initializePagedJS() {
  await new Promise((resolve) => {
    if (document.readyState !== "loading") resolve();
    document.addEventListener("DOMContentLoaded", () => resolve());
  });

  const previewer = new PagedModule.Previewer();
  await previewer.preview();
}

async function showPrintPage() {
  const url = new URL(window.location.href);
  url.searchParams.set("print", "true");
  history.pushState({}, "", url);
  await initializePagedJS();
}

if (new URL(window.location.href).searchParams.has("print")) {
  initializePagedJS();
} else {
  window.onbeforeprint = showPrintPage;
}

window.onafterprint = () => {
  const url = new URL(window.location.href);
  url.searchParams.delete("print");
  window.location.href = url.href;
};
