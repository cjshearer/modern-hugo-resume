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
          pname = "modern-hugo-resume-exampleSite"; # remove once I get around to versioning this
          name = finalAttrs.pname; # remove once I get around to versioning this

          src = ./.;
          setSourceRoot = "sourceRoot=$(echo */exampleSite)";

          nativeBuildInputs = nativeBuildInputs ++ [ pnpm.configHook ];

          pnpmDeps = pnpm.fetchDeps {
            inherit (finalAttrs) pname src setSourceRoot;
            hash = "sha256-RvE4R277Kam3s32XbGUIQTToG0cpbhpTaLEU5HsNZZ4=";
          };

          buildPhase =
            let
              hugoVendor = pkgs.stdenv.mkDerivation {
                name = "${finalAttrs.pname}-hugoVendor";
                inherit (finalAttrs) src setSourceRoot;
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
                # 2. Run`nix build` (it will fail with a hash-mismatch and provide the actual hash)
                # 3. Substitute the correct hash (`nix build` should now work)
                outputHash = "sha256-szsB5HwBznoZ1+qtj/yGgDQeUJxVdgtJ/4O1I25s4UE=";
              };
            in
            ''
              ln -s ${hugoVendor} _vendor
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
