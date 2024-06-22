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
        go = pkgs.go;
        hugo = pkgs.hugo;
        nodejs = pkgs.nodejs_22;
        pnpm = pkgs.pnpm;
        nativeBuildInputs = [ go hugo nodejs pnpm ];
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
          pname = "modern-hugo-resume-exampleSite";
          name = finalAttrs.pname;

          src = ./.;
          setSourceRoot = "sourceRoot=$(echo */exampleSite)";

          nativeBuildInputs = nativeBuildInputs ++ [ pnpm.configHook ];

          pnpmDeps = pnpm.fetchDeps {
            inherit (finalAttrs) pname src setSourceRoot;
            hash = "sha256-RvE4R277Kam3s32XbGUIQTToG0cpbhpTaLEU5HsNZZ4=";
          };

          fontAwesome = pkgs.fetchFromGitHub {
            owner = "FortAwesome";
            repo = "Font-Awesome";
            rev = "6.5.2";
            sha256 = "sha256-kUa/L/Krxb5v8SmtACCSC6CI3qTTOTr4Ss/FMRBlKuw=";
          };

          postBuild = ''
            go mod vendor
            mv vendor _vendor
            sed -i '$d' _vendor/modules.txt
            mkdir -p _vendor/github.com/FortAwesome/
            ln -s $fontAwesome _vendor/github.com/FortAwesome/Font-Awesome

            pnpm build -d $out
          '';

          dontInstall = true;
          dontFixup = true;
        });

        devShell = pkgs.mkShell {
          nativeBuildInputs = nativeBuildInputs ++ [
            biome
            self.checks.${system}.pre-commit-check.enabledPackages
          ];

          shellHook = self.checks.${system}.pre-commit-check.shellHook + ''
            pushd exampleSite 
            
            pnpm install

            popd
          '';
        };
      });
}
