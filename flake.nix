{
  description = "My NixOS / nix-darwin / nixos-generators systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # Lix
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };   

    # Hardware Configuration
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # Comma
    comma = {
      url = "github:nix-community/comma";
      inputs.nixpkgs.follows = "unstable";
    };

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Impermanence
    impermanence.url = "github:nix-community/impermanence";

    # Disko
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    }

    # Hardware
    nixos-hardware.url = "github:nixos/nixos-hardware";

    # WSL
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
      inputs.nixpkgs.follows = "stablepkgs";
    }


    # System Deployment
    deploy-rs = {
        url = "github:serokell/deploy-rs";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixos generators
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    }

    #snowfall lib
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Snowfall Flake
    flake.url = "github:snowfallorg/flake?ref=v1.4.1";
    flake.inputs.nixpkgs.follows = "unstable";

    # Desktop
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.nixpkgs.follows = "hyprland";
    };

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
      snowfall = {
        meta = {
          name = "nixgehtmehr";
          title = "Nix, geht mehr";
        };
        namespace = "nixgehtmehr";
     };
    };
    in 
    lib.mkFlake 
     {
       inherit inputs;
       src = ./.;

       channels-config = {
          allowUnfree = true;
          permittedInsecurePackages = [
            "electron-25.9.0"
            "electron-27.3.11"
          ];
        };

	     systems.modules.nixos = with inputs; [
          stylix.nixosMoadules.stylix
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          nix-index-database.nixosModules.nix-index

        ];

        deploy = lib.mkDeploy { inherit (inputs) self; };

        checks = builtins.mapAttrs
          (
            system: deploy-lib: deploy-lib.deployChecks inputs.self.deploy
          )
          inputs.deploy-rs.lib;

        outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };
      } // { self = inputs.self; };  
}
