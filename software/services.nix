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

    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  security.polkit.enable = true;

  services.tailscale.enable = true;
  services.flatpak.enable = true;
  services.power-profiles-daemon.enable = true;
  services.fwupd.enable = true;
  services.system76-scheduler.enable = true;

  services.pcscd.enable = true;
  services.pcscd.plugins = [
    pkgs.pcsc-safenet
    pkgs.ccid
  ];

  services.rpcbind.enable = true;
}
