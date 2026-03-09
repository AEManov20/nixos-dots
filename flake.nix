{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixos-hardware.url = "github:nixos/nixos-hardware/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    high-tide-flake.url = "github:Nokse22/high-tide";
    high-tide-flake.inputs.nixpkgs.follows = "nixpkgs";

    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, home-manager, nixos-hardware, high-tide-flake, impermanence }:
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

          high-tide-ext = high-tide-flake.packages.${system}.high-tide;
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

      nixosConfigurations.wyvern = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
	
        specialArgs = {
          pkgs-stable = import nixpkgs-stable {
            inherit system;
          };

          high-tide-ext = high-tide-flake.packages.${system}.high-tide;
        };

        modules = [
          impermanence.nixosModules.impermanence
          nixos-hardware.nixosModules.gigabyte-b550
          nixos-hardware.nixosModules.common-gpu-amd
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-pc-ssd
          ./hardware/wyvern
          ./software/machine-specific/wyvern
          home-manager.nixosModules.home-manager homeManagerOpts
        ];
      };
    };
}

