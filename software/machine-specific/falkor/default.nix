{ pkgs, pkgs-stable, ... }:
{
  imports = [ ../../. ];

  networking.hostName = "falkor";

  boot.kernelParams = [ "i915.force_probe=7d55" "acpi_backlight=native" ];

  programs.adb.enable = true;
  
  # services.blueman.enable = true;
  services.throttled.enable = false;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  fileSystems."/mnt/pistorage" = {
    device = "//pi/pi_storage";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,nofail,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  boot.kernelPackages = pkgs.linuxPackages;

  system.stateVersion = "24.11";
}
