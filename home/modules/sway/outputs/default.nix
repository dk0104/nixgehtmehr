{ config
, lib
, hostname
, ...
}:

with lib;

let
  cfg = config.module.sway.outputs;

  outputs = {
    default = {  };

    schuhbox = {
     DP-1 = {
      resolution = "5120x1440@120Hz";
      position = "0 0";
    };
   };
  };

  workspaces = {
    default = [  ];

    schuhbox = [
      { workspace = "1"; output = "DP-1"; }
      { workspace = "2"; output = "DP-1"; }
      { workspace = "3"; output = "DP-1"; }
      { workspace = "4"; output = "DP-1"; }
      { workspace = "5"; output = "DP-1"; }
      { workspace = "6"; output = "DP-1"; }
      { workspace = "7"; output = "DP-1"; }
      { workspace = "8"; output = "DP-1"; }
      { workspace = "9"; output = "DP-1"; }
      { workspace = "10"; output = "DP-1"; }
    ];

  };
in {
  options.module.sway.outputs = {
    enable = mkEnableOption "Enable sway outputs";
  };

  config = mkIf cfg.enable {
    wayland.windowManager.sway.config = {
      output = outputs.${hostname};

      workspaceOutputAssign = workspaces.${hostname};
    };
  };
}

