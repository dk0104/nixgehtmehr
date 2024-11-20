{ config, lib, ... }:
with lib;
let
  cfg = config.module.timedate;
in
{
  options = {
    module.timedate.enable = mkEnableOption "Enables timedate";
  };

  config = mkIf cfg.enble {
    time.timeZone = "Europe/Samara";
    service.chrony.enable = true;
  };
}
