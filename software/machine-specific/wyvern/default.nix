{ pkgs, config, ... }:
{
  imports = [
    ../../.
  ];

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

  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 22 8096 ];
    allowedUDPPorts = [ 2456 ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
    package = pkgs.sunshine.override { cudaSupport = true; };
  };

  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  # };

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "wyvern";

  system.stateVersion = "24.11";
}
