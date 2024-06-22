// HACK(cjshearer): this enables us to get the node_modules installed by the consumer of a theme.
// This may only be necessary for npm/pnpm installed from nixpkgs, but it should work the same for a
// normal install.
const node_modules = `${process.env.PWD}/node_modules`;
module.exports = {
  plugins: {
    [`${node_modules}/tailwindcss`]: {
      config: process.env.HUGO_FILE_TAILWIND_CONFIG_JS,
    },
    [`${node_modules}/autoprefixer`]: {},
  },
};

if (process.env.HUGO_ENVIRONMENT === "production") {
  Object.assign(module.exports.plugins, {
    /** @type {import('@fullhuman/postcss-purgecss').UserDefinedOptions} */
    [`${node_modules}/@fullhuman/postcss-purgecss`]: {
      content: ["./hugo_stats.json"],
      defaultExtractor: (content) => {
        const els = JSON.parse(content).htmlElements;
        return Object.values(els).reduce((acc, val) => acc.concat(val), []);
      },
      variables: true,
    },
  });
}
