{ pkgs, pkgs-stable, ... }:
{
  imports = [ ../../. ];

  networking.hostName = "falkor";

  users.users.backup = {
    isNormalUser = true;
    shell = pkgs.bashInteractive;
  };

  boot.kernelParams = [ "i915.force_probe=7d55" "acpi_backlight=native" ];

  programs.adb.enable = true;
  
  services.throttled.enable = false;

  services.openssh.settings.AllowUsers = [ "backup" ];

  fileSystems."/mnt/pi_storage/dump" = {
    device = "100.71.109.115:/mnt/pi_storage/dump";
    fsType = "nfs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},nodev,noatime"];
  };

  boot.kernelPackages = pkgs.linuxPackages;

  system.stateVersion = "24.11";
}
