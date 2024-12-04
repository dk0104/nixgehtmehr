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
  cfg = config.${namespace}.tools.misc;
in
{
  options.${namespace}.tools.misc = with types; {
    enable = mkBoolOpt false "Whether or not to enable common utilities.";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      fzf
      ripgrep
      killall
      unzip
      file
      jq
      clac
      wget
      glow
    ];
  };
}
