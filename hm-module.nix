{
  config,
  lib,
  pkgs,
  ...
}:

let
  snapx = pkgs.callPackage ./package.nix { };
in
{
  options = {
    programs.snapx.enable = lib.mkEnableOption "Enable SnapX";
  };

  config = lib.mkIf config.programs.snapx.enable {
    home.packages = [ snapx ];
  };
}
