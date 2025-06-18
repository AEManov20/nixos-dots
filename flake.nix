{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, ... }:
    let
      homeManagerOpts = {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "backup";
        home-manager.users.alex = ./users/alex.nix;
      };
    in
    {
      nixosConfigurations.falkor = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";

        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
          };
        };

        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          nixos-hardware.nixosModules.common-pc-laptop
          ./hardware/falkor
          ./software/machine-specific/falkor
          home-manager.nixosModules.home-manager homeManagerOpts
        ];
      };

      nixosConfigurations.wyvern = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          ./hardware/wyvern
          ./software/machine-specific/wyvern
          home-manager.nixosModules.home-manager homeManagerOpts
        ];
      };
    };
}

