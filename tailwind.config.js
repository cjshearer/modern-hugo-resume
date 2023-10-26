/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./hugo_stats.json"],
  plugins: [require("@tailwindcss/typography")],
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
      // TODO(cjshearer): remove once
      // https://github.com/tailwindlabs/tailwindcss/pull/12298/files is
      // released
      gridTemplateColumns: {
        subgrid: "subgrid",
      },
      gridTemplateRows: {
        subgrid: "subgrid",
      },
    },
  },
};
