{ self
, config
, lib
, pkgs
, ...
}:

with lib;

let
  cfg = config.module.hyprlock;
in {
  options = {
    module.hyprlock.enable = mkEnableOption "Enables Hyprlock";
  };

  config = mkIf cfg.enable {
    # https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock/
    programs.hyprlock = {
      enable = true;
      package = pkgs.hyprlock;

      settings = {
        general = {
          disable_loading_bar = false;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
          no_fade_out = false;
          ignore_empty_input = false;
        };



        label = [
          {
            monitor = "";
            text = "$TIME";
            color = "rgba(200, 200, 200, 1.0)";
            font_size = 120;
            # font_family = "Noto Sans";
            font_famyly = config.stylix.fonts.serif.name;
            rotate = 0.000000;
            shadow_passes = 0;
            shadow_size = 3;
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_boost = 1.200000;

            position = "0, 80";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "$LAYOUT";
            color = "rgba(200, 200, 200, 1.0)";
            font_size = 20;
            # font_family = "Iosevka Nerd Font Mono";
            font_famyly = config.stylix.fonts.serif.name;
            rotate = 0.000000;
            shadow_passes = 0;
            shadow_size = 3;
            shadow_color = "rgba(0, 0, 0, 1.0)";
            shadow_boost = 1.200000;

            position = "0, -80";
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}

