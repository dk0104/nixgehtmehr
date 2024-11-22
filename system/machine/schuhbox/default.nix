{ config, ... }:

{
  module = {
    boot.enable             = true;
    bluetooth.enable        = true;
    locales.enable          = true;
    network.enable          = true;
    timedate.enable         = true;
    users.enable            = true;
    variables.enable        = true;
    stylix.enable           = true;
    timedate.enable         = true;
    nixos-ng.enable         = true;
  }

  security = {
    enable                  = true;
    enableBootOptions       = true;
  };

  services = {
     greetd.enable          = true;
     qmk.enable             = true;
     users.enable           = true;
     variables.enable       = true;
    };

  programs = {
      dconf.enable          = true;
      gnupg.enable          = true;
      hm.enable             = true;
      nh.enable             = true;
      kdeconnect.enable     = true;
      xdg-portal.enable     = true;
      zsh.enable            = true;
      systemPackages.enable = true;
    }

}
