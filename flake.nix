{
  description = "SnapX";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem =
        { pkgs, system, ... }:
        {
          _module.args.pkgs = import inputs.nixpkgs {
            inherit system;
          };

          packages = {
            snapx = pkgs.callPackage ./package.nix { };
          };
        };

      flake = {
        homeModules = {
          default = inputs.self.homeModules.snapx;
          snapx = import ./hm-module.nix;
        };
      };
    };
}
