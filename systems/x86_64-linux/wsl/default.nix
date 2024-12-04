{ lib
, host
, config
, namespace
, ...
}:
let
  inherit (lib.${namespace}) enabled;
in
{
  imports = [ ./hardware.nix ];

  networking.hostName = host;

  nixgehtmehr = {
    suites = {
      wsl = enabled;
    };


  };

  system.stateVersion = "24.05";
}