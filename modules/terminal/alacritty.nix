{ config, lib, pkgs, ... }:
let
  cfg = config.local.programs.alacritty;
  shared = config.local.programs.terminal;
in
{
  options.local.programs.alacritty = {
    enable = lib.mkEnableOption "Enable Alacritty, a fast, cross-platform, OpenGL terminal emulator";
    theme = lib.mkOption {
      type = lib.types.str;
      default = shared.theme;
      description = "Color scheme to use in Alacritty";
    };
    opacity = lib.mkOption {
      type = lib.types.float;
      default = shared.opacity;
      description = "Window opacity to use in Alacritty";
    };
    font = {
      name = lib.mkOption {
        type = lib.types.str;
        default = shared.font.name;
        description = "Font family to use in Alacritty";
      };
      size = lib.mkOption {
        type = lib.types.int;
        default = shared.font.size;
        description = "Font size (in px) to use in Alacritty";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      package = config.lib.nixGL.wrap pkgs.alacritty;

      theme = "${cfg.theme}";
      
      settings = {
        general.import = [
          "options.toml"
        ];
        window = {
          dimensions = {
            columns = 120;
            lines = 40;
          };
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
          thickness = 0.15;
        };
      };
    };

    home.file = {
      ".config/alacritty/options.toml".text = ''
        [terminal]
        shell = "${config.home.homeDirectory}/.nix-profile/bin/${config.local.programs.shell.default}"

        [window]
        opacity = ${builtins.toString cfg.opacity}

        [font]
        normal = { family = "${cfg.font.name}" }
        size = ${builtins.toString cfg.font.size}
      '';
    };
  };
}
