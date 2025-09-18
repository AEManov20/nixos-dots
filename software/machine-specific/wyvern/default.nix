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

  networking.interfaces.enp7s0.wakeOnLan.enable = true;

  networking.firewall = {
    allowedTCPPorts = [ 22 8096 ];
    allowedUDPPorts = [ 2456 ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  fileSystems."/mnt/pistorage" = {
    device = "alex@pi.lan:/mnt/pi_storage";
    fsType = "sshfs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},nodev,noatime,allow_other,IdentityFile=/root/.ssh/id_ed25519_wyvern,gid=100"];
  };

  fileSystems."/".options = [ "compress=zstd" ];
  fileSystems."/home".options = [ "compress=zstd" ];
  fileSystems."/nix".options = [ "compress=zstd" "noatime" ];

  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "wyvern";

  system.stateVersion = "24.11";
}
