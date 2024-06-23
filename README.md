# modern-hugo-resume

A responsive, minimal, print-friendly resume builder. Powered by Hugo, Tailwind CSS, Nix, and GitHub Pages.

_Host your own resume on GitHub for free!_

## Quick Start

This guide helps you quickly test the theme and deploy it to github pages. If, when finished, you decide to keep using it, we suggest continuing with the [Extended Setup](#extended-setup) to convert your fork into something more maintainable.

### 1. Fork this repository

[Fork this repository](https://github.com/cjshearer/modern-hugo-resume/fork), naming it `<your_username>.github.io`.

### 2. Allow GitHub Actions to Deploy to GitHub Pages

Under `(your repo) > Settings > Pages > Build and Deployment > Source`, select "GitHub Actions" as the source.

### 3. Enable GitHub Actions Workflows

Go to `(your repo) > Actions` and click "Enable workflows". These are disabled by default on forks, to prevent unintended workflow runs.

### 4. Deploy your Customized Resume

Edit the resume at `(your repo) > exampleSite/content/_index.md` using the github editor. When you commit it, the resume site will automatically be built and deployed to `https://<your_username>.github.io`.

> [!TIP]
> You can skip editing the resume and trigger the build and deploy workflow manually by going to `Actions > ./github/workflows/deploy.yaml` and clicking "run workflow".

## Extended Setup

The fork you created in the [Quick Start](#quick-start) won't be easy to keep up-to-date. Follow this guide to convert your forked `exampleSite` into something more maintainable.

### 5. Extract the Example Site and Supporting Files

Clone your forked repository and modify it as follows:

1. Delete files and folders marked with a (-).
2. Moving the files from `exampleSite` up a level with `mv exampleSite/* .` (ignore the error).

```diff
 $ tree -av --dirsfirst -L 1 --gitignore
 .
 ├── .git
 ├── .github
 ├── .vscode
-├── assets
+├── exampleSite/* # move its files to the root dir
-├── layouts
 ├── .envrc
 ├── .gitignore
 ├── LICENSE
 ├── README.md
 ├── biome.json
 ├── flake.lock
 ├── flake.nix
-├── go.mod
-├── go.sum
-├── hugo.toml
-├── package.hugo.json
-├── postcss.config.js
-└── tailwind.config.js
```

### 6. Modify your Hugo Module

Rename your module and remove the replacement directive to change `modern-hugo-resume` from a local to a remote dependency:

```diff
// go.mod (originally from `exampleSite/go.mod`)
- module github.com/cjshearer/modern-hugo-resume/exampleSite
+ module github.com/<your username>/<your repo>

...
- // We use this for local development. Remove it if you're
- // extracting the exampleSite to your own repository.
- replace github.com/cjshearer/modern-hugo-resume => ../
```

### 7. Update Hash for Vendored Hugo Dependencies

Nix to builds the site in GitHub Actions, and it requires that the expected hash of downloaded dependencies be declared. Now that you have added `modern-hugo-resume` as an additional remote dependency, you will need to update this hash. See the instructions above `outputHash` in [`flake.nix`](./flake.nix).

### 8. Commit and Push

Commit and push your changes to your main branch.

```sh
git add .
git commit -m "build: use hugo module"
git push
```

## Local Development

### Requirements 
Can be installed manually, or automatically with [nix](https://github.com/DeterminateSystems/nix-installer?tab=readme-ov-file#the-determinate-nix-installer) by running `nix develop`:

1. Install [`hugo`](https://gohugo.io/installation/) 1.27.0+extended.
2. Install [`go`](https://go.dev/dl/) >= 1.22.3.
3. Install `node` >= 20.2.0 with [nvm](https://github.com/nvm-sh/nvm).
4. Install `pnpm` with `corepack enable`.
5. Run `pnpm install`.

### Common Nix Commands
```sh
nix build       # build the production site, exactly the same way it's done in CI
nix flake check # run formatter/linter checks, exactly the same way it's done in CI
nix develop     # open a development environment with requirements satisfied
```

#### Common pnpm Commands

```sh
cd exampleSite # <- don't forget this

pnpm dev       # rebuild changes automatically 
pnpm build     # create a production build
```
