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

  };

  outputs = inputs: 
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
    };

}
