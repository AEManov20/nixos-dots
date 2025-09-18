{ pkgs, ... }:
{
  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  services.protonmail-bridge.enable = true;
  services.tailscale.enable = true;

  services.flatpak.enable = true;

  security.polkit.enable = true;
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;

  services.pcscd.enable = true;
  services.pcscd.plugins = [
    pkgs.pcsc-safenet
    pkgs.ccid
  ];
}
