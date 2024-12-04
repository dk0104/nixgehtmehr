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
      WSL = enabled;
      networking = enabled;
    };


  };

  system.stateVersion = "24.05";
}