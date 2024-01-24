# modern-hugo-resume

_A minimal static resume builder; inspired by [sproogen's modern-resume-theme](https://github.com/sproogen/modern-resume-theme) and [mnjul's html-resume](https://github.com/mnjul/html-resume). Powered by Hugo, Tailwind CSS, and GitHub Pages._

_Host your own resume on GitHub for free!_

## Repository Setup

1. [Fork](https://github.com/cjshearer/modern-hugo-resume/fork) this repository, naming it `<your_username>.github.io`.
2. In your new repository, go to `Settings > Pages` and under "Build and deployment" select "GitHub Actions" as the source.
3. Go to `Actions` and click "Enable workflows".

When you update the `main` branch of your repository with your information, the resume will automatically be built and deployed to `https://<your_username>.github.io`.

4. [optional] If you just want to see the page deployed now, without updating the resume content, you can manually trigger the build and deploy workflow by going to `Actions > ./github/workflows/deploy.yaml` and clicking "run workflow".

## Local Usage

### Prerequisites

#### Node

We recommend installing the latest version (or at least 16) of Node with [nvm](https://github.com/nvm-sh/nvm).

[Windows]: You'll need to use [nvm-windows](https://github.com/coreybutler/nvm-windows) if you want to use nvm.

#### Git

You probably already have this.

[Windows]: Install with `winget install -e --id Git.Git`

### Setup

Clone the repository:

```sh
git clone git@github.com:<your_username>/<your_username>.github.io.git
```

We use [corepack](https://nodejs.org/api/corepack.html) (comes with Node >= 16)
to manage `pnpm`. To install, run the following from the project's root
directory.

[Windows]: You may need to run the following with elevated privileges. For a convenient way to do this, install gsudo with `winget install -e --id gerardog.gsudo` and prepend `gsudo` to the following command:

```sh
corepack enable
```

To install the project dependencies, run the following command from the project's root directory:

```sh
pnpm install
```

## Local Development

To make changes and instantly see them at http://localhost:1313, run:

```sh
pnpm dev
```

To make the server accessible over tailscale, run

```sh
pnpm dev:tailscale
```

To create a production build, run:

```sh
pnpm build
```
