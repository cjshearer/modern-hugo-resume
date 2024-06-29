// We use this environment variable provided by hugo as a workaround for `css.TailwindCSS`
// (https://gohugo.io/functions/css/tailwindcss/) not supporting the `--config` option. It's
// important that this file be named anything that will be automatically recognized by tailwindcss,
// other than `tailwind.config.js`. See https://github.com/cjshearer/modern-hugo-resume/pull/50 for
// more information.
//
// Consumers of this theme can use this to override/extend the theme's configuration without
// vendoring. Try running `hugo --logLevel=debug` and uncommenting the below `console.warn`. You may
// need to save the main.css to trigger

module.exports = require(process.env.HUGO_FILE_TAILWIND_CONFIG_JS);

// console.warn(JSON.stringify(module.exports, null, 2));
