{ lib
, inputs
, self
, commonModules
, systemModules
, machineConfigurationPath
, machineConfigurationPathExist
, machineModulesPath
, machineModulesPathExist
, platform ? null
, stateVersion ? null
, ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.stylix.nixosModules.stylix
    inputs.impermanence.nixosModules.impermanence
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.chaotic.nixosModules.default
    inputs.nur.nixosModules.nur

    "${commonModules}"
    "${systemModules}"
  ]
  ++ lib.optional machineConfigurationPathExist machineConfigurationPath
  ++ lib.optional machineModulesPathExist machineModulesPath;

  module.nix-config.enable = true;

  # System version
  system = { inherit stateVersion; };
  # HostPlatform
  nixpkgs = {
    overlays = [
      inputs.nix-topology.overlays.default
    ];

    hostPlatform = platform;
  };
}
