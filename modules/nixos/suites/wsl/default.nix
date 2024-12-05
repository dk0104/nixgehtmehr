{ config
, lib
, namespace
, ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) enabled mkBoolOpt;
  cfg = config.${namespace}.suites.wsl;
in
{
  options.${namespace}.suites.wsl = {
    enable = mkBoolOpt false "Whether or not to enable a common WSL configuration";
  };

  config = mkIf cfg.enable {
    nixgehtmehr = {
      nix = enabled;

      system = {
        fonts = enabled;
        xkb = enabled;
      };

      cli-apps = {
        tmux = enabled;
        flake = enabled;
      };

      tools = {
        misc = enabled;
        k8s = enabled;
      };
    };
  };
}