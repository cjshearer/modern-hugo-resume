/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./hugo_stats.json"],
  plugins: [
    require("@tailwindcss/typography"),
    require("@savvywombat/tailwindcss-grid-areas"),
  ],
  theme: {
    extend: {
      typography: () => ({
        DEFAULT: {
          css: {
            a: {
              color: false,
              fontWeight: false,
              textDecoration: false,
            },
            "blockquote p:first-of-type::before": false,
            "blockquote p:last-of-type::after": false,
            code: {
              color: false,
              fontWeight: false,
            },
            "code::after": false,
            "code::before": false,
            maxWidth: false,
          },
        },
      }),
      // TODO(cjshearer): remove subgrid once
      // https://github.com/tailwindlabs/tailwindcss/pull/12298/files is
      // released
      gridTemplateColumns: {
        "resume-md": "1fr min-content min-content",
        resume: "1fr min-content",
        subgrid: "subgrid",
      },
      gridTemplateRows: {
        resume: `
          min-content
          1fr
          min-content
        `,
        subgrid: "subgrid",
      },
      // https://savvywombat.com.au/tailwind-css/grid-areas
      gridTemplateAreas: {
        "resume-md": [
          "header header drawer",
          "main date drawer",
          "footer footer footer",
        ],
        // prettier-ignore
        resume: [
          "header header",
          "main date",
          "footer footer",
        ],
      },
    },
  },
};
