{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/release-25.11";
  inputs.nixpkgs-hugo.url = "github:savtrip/nixpkgs/0790c02eaffe4ddfbbfb5bb25d5cc1033a74b3ff";

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      perSystem = { self', pkgs, system, ... }:
        let
          pkgsHugo = import inputs.nixpkgs-hugo { inherit system; };
          inherit (pkgs) go;
          hugo = pkgsHugo.hugo;
        in {
          devShells.default = pkgs.mkShell { buildInputs = [ hugo go ]; };
        };
    };
}
