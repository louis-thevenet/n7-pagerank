{
  description = "A Nix flake dev environment for Ada, Typst and Nix.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            # Nix
            nil
            alejandra

            # Ada
            gnat
            gprbuild
            valgrind
            gdb
            hyperfine

            # Typst
            typst
            typst-lsp
            typst-fmt
          ];
        };
      };
    });
}
