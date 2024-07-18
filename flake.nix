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
        hugo = pkgs.hugo;
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
                  # We remove our vendored hugo module to avoid updating the outputHash every time
                  # we change modern-hugo-resume. If only Go supported partial vendoring...
                  rm -rf _vendor/github.com/cjshearer/modern-hugo-resume
                  cp -r _vendor $out
                '';

                outputHashMode = "recursive";
                outputHashAlgo = "sha256";
                # To get a new hash:
                # 1. Invalidate the current hash (change any character between "sha256-" and "=")
                # 2. Run `nix build` or push to GitHub (it will fail and provide the new hash)
                # 3. Substitute the new hash (`nix build` should now work)
                outputHash = "sha256-KzscxZKLTIxydtTV+Qn7NSB2X4irpKF1i/4RcbA4j/k=";
              };
            in
            ''
              # We substitute our vendored hugo module we removed with a symlink to the root.
              cp -rs ${hugoVendor} _vendor
              chmod +w _vendor/github.com/cjshearer
              rm -rf _vendor/github.com/cjshearer/modern-hugo-resume
              ln -s $src _vendor/github.com/cjshearer/modern-hugo-resume

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
      });
}
