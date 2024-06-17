# modern-hugo-resume

_A minimal static resume builder; inspired by [sproogen's modern-resume-theme](https://github.com/sproogen/modern-resume-theme) and [mnjul's html-resume](https://github.com/mnjul/html-resume). Powered by Hugo, Tailwind CSS, and GitHub Pages._

_Host your own resume on GitHub for free!_

## Setup

### Remote Repository

1. [Fork](https://github.com/cjshearer/modern-hugo-resume/fork) this repository, naming it `<your_username>.github.io`.
2. In your new repository, go to `Settings > Pages` and under "Build and deployment" select "GitHub Actions" as the source.
3. Go to `Actions` and click "Enable workflows". When you next push to the `main` branch of your repository, the resume site will automatically be built and deployed to `https://<your_username>.github.io`.

> [!TIP]
> You can also trigger the workflow to build and deploy the website by going to `Actions > ./github/workflows/deploy.yaml` and clicking "run workflow".

### Local Repository

#### With [Nix](https://nixos.org/download/)

Run `nix develop` (or install [nix-direnv](https://github.com/nix-community/nix-direnv)).

#### Without Nix

1. Install [`hugo`](https://gohugo.io/installation/) 1.27.0+extended.
2. Install `node` >= 20.2.0 with [nvm](https://github.com/nvm-sh/nvm).
3. Install `pnpm` with `corepack enable`.
4. Run `pnpm install`.

## Development

### Rebuild on file change

To rebuild changes automatically, run `pnpm dev`.

### Build

To create a production build, run `pnpm build`.
