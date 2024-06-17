{
  description = "modern-hugo-resume";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    # HACK: enable build argument with https://github.com/NixOS/nix/issues/5663#issuecomment-2010521981
    baseURL.url = "file+file:///dev/null";
    baseURL.flake = false;
  };

  outputs = { self, nixpkgs, flake-utils, baseURL }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hugo = pkgs.hugo;
        nodejs = pkgs.nodejs_22;
        pnpm = pkgs.pnpm;
        nativeBuildInputs = [ nodejs hugo pnpm ];
      in
      {
        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "modern-hugo-resume";
          name = finalAttrs.pname;

          src = ./.;

          nativeBuildInputs = nativeBuildInputs ++ [ pnpm.configHook ];

          pnpmDeps = pnpm.fetchDeps {
            inherit (finalAttrs) pname src;
            hash = "sha256-LopdAXf7EScCbyXQ0op6xohdv6vRPdNQrVzIRxOvAG0=";
          };

          postBuild = ''
            pnpm run build --baseURL=${builtins.readFile baseURL}
          '';

          installPhase = ''
            cp -r build $out
          '';

          # used by lint workflow so we can use cached pnpm deps
          shellHook = ''
            pnpmConfigHook
          '';
        });

        devShell = pkgs.mkShell { inherit nativeBuildInputs; };
      });
}
