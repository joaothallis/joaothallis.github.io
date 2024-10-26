{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-23.11";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = { self', pkgs, ... }:
        let inherit (pkgs) hugo go;
        in {
          devShells.default = pkgs.mkShell { buildInputs = [ hugo go ]; };
        };
    };
}
