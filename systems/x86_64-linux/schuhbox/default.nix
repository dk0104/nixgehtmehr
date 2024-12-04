{ config, lib , pkgs, namespace,  ... }:
with lib;
with lib.${namespace};
{
  imports = 
    [
      ./hardware.nix
    ];

  # Boot loader

  # Set your time zone.
  time.timeZone = "Europe/Samara";

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;


  nixgehtmehr = {
    archetypes = {
      workstation = enabled;
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
}
