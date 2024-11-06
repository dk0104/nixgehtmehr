{
  description = "Nix geht mehr";

  inputs = {

    # NixPkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # NixPkgs Unstable
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    #Snowfall Lib
    snowfall-lib = {
     url = "github:snowfallorg/lib";
     inputs.nixpkgs.follows = "nixpkgs";
    };

    # Home Manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # System Deployment
    deploy-rs.url = "github:serokell/deploy-rs";
    deploy-rs.inputs.nixpkgs.follows = "nixpkgs";


  };

  outputs = inputs: 
  let 
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;

      snowfall = {
          meta = {
              name = "nixgehtmehr";
              title = "Nix giht mehr";
            };
          namespace = "ns-nixgehtmehr";
      };
    };
  in 
  lib.mkFlake 
    {
      channels-config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
            "electron-27.3.11"
          ];
      };

       deploy = lib.mkDeploy { inherit (inputs) self; };
       
       checks = builtins.mapAttrs
          (
            system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy
          )
          inputs.deploy-rs.lib;

        outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };

      };

}
