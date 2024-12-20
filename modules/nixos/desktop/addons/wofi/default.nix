{
  options,
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
with lib;
with lib.${namespace};
let
  cfg = config.${namespace}.desktop.addons.wofi;
in
{
  options.${namespace}.desktop.addons.wofi = with types; {
    enable = mkBoolOpt false "Whether to enable the Wofi in the desktop environment.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      wofi
      wofi-emoji
    ];

    # config -> .config/wofi/config
    # css -> .config/wofi/style.css
    # colors -> $XDG_CACHE_HOME/wal/colors
    # nixgehtmehr.home.configFile."foot/foot.ini".source = ./foot.ini;
    nixgehtmehr.user.home.configFile."wofi/config".source = ./config;
    nixgehtmehr.user.home.configFile."wofi/style.css".source = ./style.css;
  };
}
