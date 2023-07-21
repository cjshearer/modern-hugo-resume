const themeDir = __dirname + "/../../";

/** @type {import('postcss').Postcss} */
module.exports = {
  plugins: [
    require("postcss-import")({
      path: [themeDir],
    }),
    require("tailwindcss")(themeDir + "assets/css/tailwind.config.js"),
    require("autoprefixer")({
      path: [themeDir],
    }),
  ],
};

if (process.env.HUGO_ENVIRONMENT === "production") {
  module.exports.plugins.push(
    require("@fullhuman/postcss-purgecss")({
      content: ["./hugo_stats.json"],
      defaultExtractor: (content) => JSON.parse(content).htmlElements,
      variables: true,
    })
  );
}
