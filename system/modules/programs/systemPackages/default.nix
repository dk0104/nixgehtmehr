{ pkgs
, lib
, config
, isWorkstation
, ...
}:

with lib;

let
  cfg = config.module.programs.systemPackages;
in {
  options = {
    module.programs.systemPackages.enable = mkEnableOption "Enable System Software";
  };

  config = mkIf cfg.enable {
    fonts.packages = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" "UbuntuMono" "NerdFontsSymbolsOnly" "Hack"]; })
      corefonts
      swaycons
      noto-fonts
      noto-fonts-emoji
      powerline-fonts
      powerline-symbols
      swaycons
      twemoji-color-font
    ];

    environment.systemPackages = with pkgs; [
      # Utils
      git
      nvd
      nix-output-monitor
      curl
      wget
      tree
      file
      zip
      unzip
      killall
      jq

      # Hardware utils
      glxinfo
      pciutils
      usbutils
      powertop
      lm_sensors
      strace
      ltrace
      lsof
      sysstat
      cpufetch
      sbctl

      # Network
      inetutils
      wireguard-tools
      dig
      nmap
      dnsutils
      iperf3
      mtr
      ipcalc
      cacert
    ] ++ optionals isWorkstation [
      # Themes
      tela-circle-icon-theme

      # Hardware
      microcodeIntel
      libGL

      # Hardware utils
      libva-utils
      intel-gpu-tools
      fwupd
      fwupd-efi

      # Utils
      dconf-editor
    ];
  };
}