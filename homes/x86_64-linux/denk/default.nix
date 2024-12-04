{
  lib,
  pkgs,
  config,
  osConfig ? { },
  format ? "unknown",
  namespace,
  ...
}:
with lib.${namespace};
{
    nixgehtmehr {
      cli-apps = {
        zsh = enabled;
        home-manager = enabled;
      };
      
      tools = {
        direnv = enabled;
    };
  };

}
