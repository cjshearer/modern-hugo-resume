{
  description = "modern-hugo-resume";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs = { self, nixpkgs, flake-utils, pre-commit-hooks }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        biome = pkgs.biome;
        commitlint = pkgs.commitlint;
        git = pkgs.git;
        go = pkgs.go;
        hugo = pkgs.hugo.override {
          # awaiting hugo: 0.127.0 -> 0.128.0: https://github.com/NixOS/nixpkgs/pull/322536
          buildGoModule = args: pkgs.buildGoModule (args // {
            version = "0.128.0";
            src = pkgs.fetchFromGitHub {
              owner = "gohugoio";
              repo = "hugo";
              rev = "refs/tags/v0.128.0";
              hash = "sha256-dyiCEWOiUtRppKgpqI68kC7Hv1AMK76kvCEaS8nIIJM=";
            };
            vendorHash = "sha256-iNI/5uAYMG+bfndpD17dp1v3rGbFdHnG9oQv/grb/XY=";
          });
        };
        tailwindcss = pkgs.tailwindcss;
        nativeBuildInputs = [ go hugo tailwindcss ];
      in
      {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              biome.enable = true;
              commitizen.enable = true;
              nixpkgs-fmt.enable = true;
            };
          };
        };

        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          inherit nativeBuildInputs;

          pname = "modern-hugo-resume-exampleSite";
          # TODO: remove `name` once I get around to versioning this
          name = finalAttrs.pname;

          src = with pkgs.lib.fileset; (toSource {
            root = ./.;
            fileset = difference
              (gitTracked ./.)
              (unions [
                ./.github
                ./.vscode
                ./.envrc
                ./.gitignore
                ./biome.json
                ./LICENSE
                ./README.md
              ])
            ;
          });

          sourceRoot = "${finalAttrs.src.name}/exampleSite";

          buildPhase =
            let
              hugoVendor = pkgs.stdenv.mkDerivation {
                name = "${finalAttrs.pname}-hugoVendor";
                inherit (finalAttrs) src sourceRoot;
                nativeBuildInputs = [ go hugo git ];

                buildPhase = ''
                  hugo mod vendor
                '';

                installPhase = ''
                  cp -r _vendor $out
                '';

                outputHashMode = "recursive";
                outputHashAlgo = "sha256";
                # To get a new hash:
                # 1. Invalidate the current hash (change any character between "sha256-" and "=")
                # 2. Run `nix build` or push to GitHub (it will fail and provide the new hash)
                # 3. Substitute the new hash (`nix build` should now work)
                outputHash = "sha256-SQjQAFcoUt+X+3KVMS1ji1Av4TbV6fYnKf2Gv2tGImo=";
              };
            in
            ''
              ln -s ${hugoVendor} _vendor
              hugo --minify -d $out
            '';

          dontInstall = true;
          dontFixup = true;
        });

        devShell = pkgs.mkShell {
          nativeBuildInputs = nativeBuildInputs ++ [
            biome
            self.checks.${system}.pre-commit-check.enabledPackages
          ];
        };
      });
}
