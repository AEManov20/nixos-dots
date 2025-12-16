{ pkgs, ... }:
{
  services.openssh = {
    enable = true;
    openFirewall = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      UseDns = true;
      X11Forwarding = false;
    };
  };

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

  services.rpcbind.enable = true;
}
