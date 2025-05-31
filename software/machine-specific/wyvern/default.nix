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

  fileSystems."/mnt/pistorage" = {
    device = "//192.168.1.14/pi_storage";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,nofail,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  # services.jellyfin = {
  #   enable = true;
  #   openFirewall = true;
  # };

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "wyvern";

  system.stateVersion = "24.11";
}
