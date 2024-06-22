# modern-hugo-resume

A responsive, minimal, print-friendly resume builder. Fork it as a standalone website, or use as a theme in a new or existing Hugo site. Powered by Hugo, Tailwind CSS, Nix, and GitHub Pages.

_Host your own resume on GitHub for free!_

## Requirements

Can be installed manually, or with `nix develop`:

1. Install [`hugo`](https://gohugo.io/installation/) 1.27.0+extended.
2. Install [`go`](https://go.dev/dl/) >= 1.22.3.
3. Install `node` >= 20.2.0 with [nvm](https://github.com/nvm-sh/nvm).
4. Install `pnpm` with `corepack enable`.
5. Run `pnpm install`.

## Quick Start

Follow this guide to quickly deploy your resume to github pages.

### 1. Fork this repository

[Fork this repository](https://github.com/cjshearer/modern-hugo-resume/fork), naming it `<your_username>.github.io`.

### 2. Allow GitHub Actions to Deploy to GitHub Pages

Under `(your repo) > Settings > Pages > Build and Deployment > Source`, select "GitHub Actions" as the source.

### 3. Enable GitHub Actions Workflows

Go to `(your repo) > Actions` and click "Enable workflows". These are disabled by default on forks, to prevent unintended workflow runs.

### 4. Edit the Resume to Deploy the Site

Edit the resume at `(your repo) > exampleSite/content/_index.md` using the github editor. When you commit it, the resume site will automatically be built and deployed to `https://<your_username>.github.io`.

> [!TIP]
> You can skip editing the resume and trigger the build and deploy workflow manually by going to `Actions > ./github/workflows/deploy.yaml` and clicking "run workflow".

## Minimal Setup

Follow this guide if you want to handle deployment yourself. 

> [!TIP] 
> Feel free to adapt our nix-based `.github` workflows to your website. An example of this will be available on my [my website's repo](https://github.com/cjshearer/cjshearer.dev).   

### 1. Create and Clone Your New Repository 

[Create a new repository](https://github.com/new), naming it `<your_username>.github.io` and cloning it locally.

### 2. Initialize a Hugo Module

Inside your local git repository, create a `go.mod` file with:

```sh
hugo mod init github.com/<your username>/<your repo name>
```

### 3. Import this Theme

Copy our `exampleSite/hugo.toml` to your repo's root directory, deleting the `replacements` line and editing the `baseURL`.

```diff
- baseURL = "https://cjshearer.github.io/modern-hugo-resume"
+ baseURL = "https://<your_username>.github.io/<your_repo_name>"
...
[module]
- replacements = "github.com/cjshearer/modern-hugo-resume -> ../.."

  [[module.imports]]
  path = "github.com/cjshearer/modern-hugo-resume"
...
```

### 4. Install Node Dependencies

Some of our dependencies (e.g. `tailwindcss`) are sourced from `npm`. Generate a `package.json` for these dependencies and install them with your preferred node package manager:

```sh
hugo mod npm pack
pnpm install
```

### 5. Write your Resume

Add your resume as a markdown file located in `content/_index.md`. See `exampleSite/content/_index.md` for an example. Be sure to include the frontmatter:
```yaml
---
title: Software Developer
description: Full Stack Software Developer Resume
faviconText: 💼
layout: modern-hugo-resume
---
```

### 6. Run your Site

```sh
hugo server
```

## Local Development

Development of this repository uses the following commands frequently.

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