{ pkgs, config, ... }:
{
  imports = [
    ../../.
  ];

  networking.interfaces.enp7s0.wakeOnLan.enable = true;

  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  systemd.packages = with pkgs; [ lact ];
  systemd.services.lactd.wantedBy = ["multi-user.target"];

  fileSystems."/mnt/pistorage" = {
    device = "alex@192.168.1.14:/mnt/pi_storage";
    fsType = "sshfs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},nodev,noatime,allow_other,IdentityFile=/root/.ssh/id_ed25519_wyvern,gid=100"];
  };

  fileSystems."/".options = [ "compress=zstd" ];
  fileSystems."/home".options = [ "compress=zstd" ];
  fileSystems."/nix".options = [ "compress=zstd" "noatime" ];

  boot = {
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = with config.boot.kernelPackages; [ rtw88 ];
  };

  networking.hostName = "wyvern";

  programs.obs-studio = {
    enable = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };


  system.stateVersion = "24.11";
}
