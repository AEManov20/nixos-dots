{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixos-hardware, ... }: {
    nixosConfigurations.falkor = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";

      # specialArgs = {
      #   pkgs-stable = import nixpkgs-stable {
      #     inherit system;
      #   };
      # };

      modules = [
        nixos-hardware.nixosModules.lenovo-thinkpad-e14-intel
        ./hardware/falkor
        ./software/falkor
      ];
    };
  };
}
