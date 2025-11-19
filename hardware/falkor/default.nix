{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
  [ (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/6c508182-62e8-4101-b5ea-3dbc89b58541";
      fsType = "btrfs";
      options = [ "subvol=root" ];
    };

  boot.initrd.luks.devices."root".device = "/dev/disk/by-uuid/785e62e3-c18b-4a79-94fb-7827b477b910";

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/6c508182-62e8-4101-b5ea-3dbc89b58541";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/6c508182-62e8-4101-b5ea-3dbc89b58541";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/6c508182-62e8-4101-b5ea-3dbc89b58541";
      fsType = "btrfs";
      options = [ "subvol=swap" ];
    };
  
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/12CE-A600";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # ...
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      # intel-media-sdk   # for older GPUs
    ];
  };

  hardware.trackpoint.enable = true;
  hardware.trackpoint.emulateWheel = config.hardware.trackpoint.enable;
  hardware.cpu.x86.msr.enable = true;
}
