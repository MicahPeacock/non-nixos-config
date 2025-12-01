{ config, lib, pkgs, ... }:

{
  wayland.windowManager.hyprland  = {
    enable = true;
    xwayland.enable = true;
    package = config.lib.nixGL.wrap pkgs.hyprland;
  };

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
