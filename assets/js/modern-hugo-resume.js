import("https://unpkg.com/pagedjs@0.4.3/dist/paged.min.js");

async function initializePagedJS() {
  await new Promise((resolve) => {
    if (document.readyState !== "loading") resolve();
    document.addEventListener("DOMContentLoaded", () => resolve());
  });

  // Workaround for using custom properties with @page rules. For background on why this is an
  // issue, see: https://stackoverflow.com/a/44738574
  const referencePage = document.createElement("div");
  referencePage.style.height = "var(--page-height)";
  referencePage.style.width = "var(--page-width)";
  referencePage.style.margin = "var(--page-margin)";
  referencePage.style.position = "absolute";
  referencePage.style.top = "-9999px";
  document.body.appendChild(referencePage);
  const referencePageStyles = window.getComputedStyle(referencePage);
  const style = document.createElement("style");
  style.innerHTML = `@page {
    ${Object.entries({
      size: `${referencePageStyles.width} ${referencePageStyles.height}`,
      margin: referencePageStyles.margin,
    }).reduce((acc, [key, value]) => `${acc}${key}: ${value};\n`, "")}
  }`;
  document.head.appendChild(style);
  document.body.removeChild(referencePage);

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
