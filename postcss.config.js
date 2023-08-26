/** @type {import('postcss').Postcss} */
module.exports = {
  plugins: {
    /** @type {import('tailwindcss').Config} */
    tailwindcss: {
      config: `${__dirname}/tailwind.config.js`,
    },
    /** @type {import('autoprefixer').Options} */
    autoprefixer: {},
  },
};

if (process.env.HUGO_ENVIRONMENT === "production") {
  Object.assign(module.exports.plugins, {
    /** @type {import('@fullhuman/postcss-purgecss').UserDefinedOptions} */
    "@fullhuman/postcss-purgecss": {
      content: ["./hugo_stats.json"],
      defaultExtractor: (content) => JSON.parse(content).htmlElements,
      variables: true,
    },
  });
}
