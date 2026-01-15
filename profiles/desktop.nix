{ config, lib, pkgs, ... }:

{
  imports = [
    ../modules/desktop
    ../modules/services
    ../modules/shell
    ../modules/terminal
  ];

  local = {
    desktop.fonts.enable    = lib.mkDefault true;

    programs.shell.default  = lib.mkDefault "bash";
  };
}
