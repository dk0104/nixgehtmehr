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
  cfg = config.${namespace}.desktop.addons.foot;
in
{
  options.${namespace}.desktop.addons.foot = with types; {
    enable = mkBoolOpt false "Whether to enable the gnome file manager.";
  };

  config = mkIf cfg.enable {
    nixgehtmehr.desktop.addons.term = {
      enable = true;
      pkg = pkgs.foot;
    };

    nixgehtmehr.user.home.configFile."foot/foot.ini".source = ./foot.ini;
  };
}
