{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    snowfall-lib = {
     url = "github:snowfallorg/lib";
     inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs: {}

}
