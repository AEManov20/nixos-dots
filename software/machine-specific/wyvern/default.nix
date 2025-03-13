{ ... }:
{
  imports = [ ../../. ];

  networking.firewall.allowedTCPPorts = [ 22 ];

  services.openssh = {
    enable = true;
    ports = [ 22 ];
    settings = {
      PasswordAuthentication = false;
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  networking.hostName = "wyvern";

  system.stateVersion = "24.11";
}
