{ pkgs, pkgs-stable, ... }:
{
  imports = [ ../../. ];

  networking.hostName = "falkor";

  boot.kernelParams = [ "i915.force_probe=7d55" "acpi_backlight=native" ];

  programs.adb.enable = true;
  
  services.throttled.enable = false;
  services.udev.packages = [
    pkgs.android-udev-rules
  ];

  boot.kernelPackages = pkgs.linuxPackages;

  system.stateVersion = "24.11";
}
