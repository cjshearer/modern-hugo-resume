/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./hugo_stats.json"],
  plugins: [require("@tailwindcss/typography")],
  theme: {
    extend: {
      typography: () => ({
        DEFAULT:
          /** @type {import('tailwindcss').Config['theme']} */
          {
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
    },
  },
};
