{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs;
in
{
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ];

  options.local.programs.shell = {
    default = lib.mkOption {
      type = lib.types.enum [ "bash" "zsh" "fish" ];
      default = "bash";
      description = "Default interactive shell";
    };
  };

  config = {
    local.programs.bash.enable = lib.mkDefault (cfg.shell.default == "bash");
    local.programs.zsh.enable  = lib.mkDefault (cfg.shell.default == "zsh");
    local.programs.fish.enable = lib.mkDefault (cfg.shell.default == "fish");
  };
}
