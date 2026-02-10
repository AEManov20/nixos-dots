{ pkgs, ... }:
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.edk2-uefi-shell.enable = true;
  boot.loader.timeout = 0;

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "quiet"
    "udev.log_level=3"
    "systemd.show_status=auto"
  ];

  boot.supportedFilesystems = [ "nfs" ];

  boot.plymouth = {
    enable = true;
  };

  boot.initrd.systemd.enable = true;
}
