const defaultTheme = require("tailwindcss/defaultTheme");

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./hugo_stats.json"],
  plugins: [require("@tailwindcss/typography")],
  theme: {
    extend: {
      typography: {
        DEFAULT: {
          css: {
            a: {
              color: false,
              fontWeight: false,
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
        resume: {
          css: {
            h1: {
              fontSize: defaultTheme.fontSize["2xl"][0],
              fontWeight: defaultTheme.fontWeight.medium,
              lineHeight: defaultTheme.fontSize["2xl"][1].lineHeight,
              marginBottom: 0,
            },
            h2: {
              fontWeight: defaultTheme.fontWeight.medium,
              marginBottom: "0.5em",
              marginTop: 0,
            },
            h3: {
              fontWeight: defaultTheme.fontWeight.medium,
              marginBottom: 0,
              marginTop: 0,
            },
            h4: {
              fontSize: defaultTheme.fontSize["base"][0],
              fontWeight: defaultTheme.fontWeight.light,
              lineHeight: defaultTheme.fontSize["base"][1].lineHeight,
            },
            p: {
              marginBottom: 0,
              marginTop: 0,
            },
          },
        },
      },
    },
  },
};
