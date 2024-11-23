{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.hyprland.monitors;

  monitorsSettings = 
    if hostname == "schuhbox" then ["DP-1,5120x1440@120,0x0,1"]
    else [];

  workspacesSettings = 
    if hostname == "schuhbox" then
      [
        "1, monitor:DP-2, default:true"
        "2, monitor:DP-2, default:true"
        "3, monitor:DP-2, default:true"
        "4, monitor:DP-2, default:true"
        "5, monitor:DP-2, default:true"
        "6, monitor:DP-2, default:true"
        "7, monitor:DP-1, default:true"
        "8, monitor:DP-1, default:true"
        "9, monitor:DP-1, default:true"
        "10, monitor:DP-1, default:true"
      ]
    else [];
in {
  options = {
    module.hyprland.monitors.enable = mkEnableOption "Enables monitors in Hyprland";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.settings = {
      monitor = monitorsSettings;
      workspace = workspacesSettings;
    };
  };
}

