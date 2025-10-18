{
  description = "modern-hugo-resume";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      pre-commit-hooks,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        biome = pkgs.biome;
        git = pkgs.git;
        go = pkgs.go;
        hugo = pkgs.hugo;
        nativeBuildInputs = [
          go
          hugo
        ];
      in
      {
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              biome.enable = true;
              commitizen.enable = true;
              nixfmt-rfc-style.enable = true;
            };
          };
        };

        packages.default = pkgs.stdenv.mkDerivation (finalAttrs: {
          inherit nativeBuildInputs;

          pname = "modern-hugo-resume-exampleSite";
          # TODO: remove `name` once I get around to versioning this
          name = finalAttrs.pname;

          src =
            with pkgs.lib.fileset;
            (toSource {
              root = ./.;
              fileset = difference (gitTracked ./.) (unions [
                ./.github
                ./.vscode
                ./.envrc
                ./.gitignore
                ./biome.json
                ./LICENSE
                ./README.md
              ]);
            });

          sourceRoot = "${finalAttrs.src.name}/exampleSite";

          buildPhase =
            let
              hugoVendor = pkgs.stdenv.mkDerivation {
                name = "${finalAttrs.pname}-hugoVendor";
                inherit (finalAttrs) src sourceRoot;
                nativeBuildInputs = [
                  go
                  hugo
                  git
                ];

                buildPhase = ''
                  hugo mod vendor
                '';

                installPhase = ''
                  cp -r _vendor $out
                '';

                outputHashMode = "recursive";
                outputHashAlgo = "sha256";
                # To get a new hash:
                # 1. Replace the existing hash with `pkgs.lib.fakeHash`
                # 2. Run `nix build` or push to GitHub (it will fail and provide the new hash)
                # 3. Substitute the new hash (`nix build` should now work)
                outputHash = "sha256-mFnxMxPDojDfxKDZE8xGopHYFnUi1/L7rjGsealysao=";
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
          inherit (self.checks.${system}.pre-commit-check) shellHook;
          nativeBuildInputs = nativeBuildInputs ++ [
            biome
            self.checks.${system}.pre-commit-check.enabledPackages
          ];
        };
      }
    );
}
