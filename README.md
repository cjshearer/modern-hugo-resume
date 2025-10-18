# modern-hugo-resume

A minimal hugo theme, built around a resume. Powered by Hugo, Nix, and GitHub Pages.

_Host your site on GitHub for free!_

## Quick Start

This guide helps you quickly test the theme and deploy your site to github pages. If you like it, we suggest continuing with the [Extended Setup](#extended-setup).

### 1. Fork this repository

[Fork this repository](https://github.com/cjshearer/modern-hugo-resume/fork), naming it `<your_username>.github.io`.

### 2. Allow GitHub Actions to deploy to GitHub Pages

Under `(your repo) > Settings > Pages > Build and Deployment > Source`, select "GitHub Actions" as the source.

### 3. Enable GitHub Actions workflows

Go to `(your repo) > Actions` and click "Enable workflows". These are disabled by default on forks, to prevent unintended workflow runs.

### 4. Update your site's baseURL

Edit `exampleSite/hugo.toml` and set `baseURL` to `https://<your_username>.github.io`.

```toml
baseURL = "https://<your_username>.github.io"
```

When you push this change, the site will automatically be built and deployed to `https://<your_username>.github.io`.


## Extended Setup

The fork you created in the [Quick Start](#quick-start) uses a local _copy_ of the theme, which won't be easy to update. Follow this guide to convert your forked hugo site into one which _imports_ the theme.

### 5. Remove theme source code

Clone your forked repository and modify it as follows:

1. Delete files and folders marked with a (-).
2. Moving the files from `exampleSite` up a level with `mv exampleSite/* .` (ignore the error).

```diff
 $ tree -av --dirsfirst -L 1 --gitignore
  .
  ├── .git
  ├── .github
  ├── .vscode
- ├── assets
+ ├── exampleSite/* # move its files to the root dir
- ├── layouts
  ├── .envrc
  ├── .gitignore
  ├── LICENSE
  ├── README.md
  ├── biome.json
  ├── flake.lock
  ├── flake.nix
- ├── go.mod
- ├── go.sum
- └── hugo.toml
```

### 6. Rename your Hugo module and import the theme

Rename your module, remove the `noVendor` and `replacements` configs, then import the theme from GitHub with `hugo mod get -u github.com/cjshearer/modern-hugo-resume`:

```diff
// go.mod (originally from `exampleSite/go.mod`)
- module github.com/cjshearer/modern-hugo-resume/exampleSite
+ module github.com/<your username>/<your repo>

# hugo.toml (originally from `exampleSite/hugo.toml`)
- [module]
- noVendor = "github.com/cjshearer/modern-hugo-resume"
- replacements = "github.com/cjshearer/modern-hugo-resume -> ../.."
```

### 7. Update the build path, name, and dependency hash

GitHub Actions is configured to build the site using Nix. Now that your site is built from the root directory (no longer under `exampleSite`), you should update its `pname` and remove `sourceRoot`.

Because Nix checks the hash of downloaded dependencies, which now include `modern-hugo-resume`, you will need to update this hash. To do this follow the instructions above `outputHash` in [`flake.nix`](./flake.nix).

```diff
# flake.nix
...

- pname = "modern-hugo-resume-exampleSite"
+ pname = "<your username>.github.io"

...

- sourceRoot = "${finalAttrs.src.name}/exampleSite";

...

  name = "${finalAttrs.pname}-hugoVendor";
- inherit (finalAttrs) src sourceRoot;
+ inherit (finalAttrs) src;

...

- outputHash = "sha256-someOldHash=
+ outputHash = "sha256-someNewHash=
```

### 8. Commit and push

Commit and push your changes to your main branch.

```sh
git add .
git commit -m "build: use hugo module"
git push
```

## Local Development

### Requirements

These can be installed manually, or automatically with [nix](https://nixos.org/download/) by running `nix develop`:

1. Install [`hugo`](https://gohugo.io/installation/) v0.135.0+extended.
2. Install [`go`](https://go.dev/dl/) v1.22.7.

### Common Commands
```sh
nix develop     # open a development environment, with all requirements satisfied
nix build       # build the production site, exactly the same way it's done in CI
nix flake check # run formatter/linter checks, exactly the same way it's done in CI

hugo server     # serve to localhost and rebuild changes automatically
hugo --minify   # build static site for production
```

## Parameters

Some features and data are configurable via Hugo's parameters.

**`params.head.partials`**:

Allows you to specify partial templates to be included in the `<head>` of your site.
Each entry can have a `path` (required), and some support additional keys (e.g., `favicon` for `head/favicon.html`, `css` for `head/css.html`).

Example:
```toml
[[params.head.partials]]
path = "head/font.html"
[[params.head.partials]]
path = "head/metadata.html"
[[params.head.partials]]
path = "head/favicon.html"
favicon = "💼"
[[params.head.partials]]
path = "head/css.html"
css = [ "imports.css", "main.css", "custom.css"]
```

**`params.page`**:

Controls the page size and margins.

Example:
```toml
[params.page]
width = "8.5in"
height = "11in"
margin = "0.4in"
```
