{ config, lib, pkgs, modulesPath, ... }:
{
  hardware.graphics.enable = true;
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  hardware.opentabletdriver.enable = true;

  services.xserver.videoDrivers = ["amdgpu"];

  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a390ca03-4351-49f1-9d5d-07aca0b110b5";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/a390ca03-4351-49f1-9d5d-07aca0b110b5";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/a390ca03-4351-49f1-9d5d-07aca0b110b5";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/3319-5533";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/1c9876c3-333c-48cf-84f6-41d5acef0f1b"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp7s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.x86.msr.enable = lib.mkDefault true;
}
