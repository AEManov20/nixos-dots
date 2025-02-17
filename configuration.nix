# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, pkgs-stable, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "rider"
    "idea-ultimate"
    "clion"
  ];

  hardware.bluetooth.enable = true;
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # ...
      # your Open GL, Vulkan and VAAPI drivers
      vpl-gpu-rt          # for newer GPUs on NixOS >24.05 or unstable
      # onevpl-intel-gpu  # for newer GPUs on NixOS <= 24.05
      # intel-media-sdk   # for older GPUs
    ];
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs-stable.linuxPackages;
  boot.kernelParams = [ "i915.force_probe=7d55" ];

  networking.hostName = "falkor";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Sofia";

  i18n.defaultLocale = "en_US.UTF-8";

  services.throttled.enable = false;

  services.xserver.enable = true;
  
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.displayManager.defaultSession = "plasma";

  services.desktopManager.plasma6.enable = true;

  services.hypridle.enable = true;

  services.xserver.xkb.layout = "us";

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" ];
    packages = with pkgs; [
      bitwarden-desktop
      wireshark
      keepassxc
      bottles
      libreoffice
      zed-editor
      jetbrains.rider
      # jetbrains.idea-ultimate
      jetbrains.clion
      vesktop
      kitty
    ];
  };

  programs.starship = {
    enable = true;
    settings = {
      character = {
        format = "$symbol ";
        success_symbol = "[->](bold green)";
        error_symbol = "[->](bold red)";
        vimcmd_symbol = "[->](bold green)";
        vimcmd_replace_one_symbol = "[->](bold purple)";
        vimcmd_replace_symbol = "[->](bold purple)";
        vimcmd_visual_symbol = "[->](bold purple)";
      };
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  programs.thunderbird.enable = true;
  programs.wireshark.enable = true;
  programs.virt-manager.enable = true;
  programs.direnv.enable = true;
  programs.firefox.enable = true;
  programs.kdeconnect.enable = true;
  programs.hyprland.enable = true;
  programs.hyprlock.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
  environment.systemPackages = with pkgs; [
    vlc
    mpv
    cifs-utils
    rclone
    git
  ];

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa
  ];

  environment.etc."rclone-gdrive.conf".source = "/etc/nixos/rclone/gdrive.conf";

  fileSystems."/mnt/gdrive" = {
    device = "gdrive:/";
    fsType = "rclone";
    options = [
      "nodev"
      "nofail"
      "allow_other"
      "args2env"
      "config=/etc/rclone-gdrive.conf"
      "uid=1000,gid=100"
    ];
  };

  fileSystems."/mnt/pistorage" = {
    device = "//192.168.1.14/pi_storage";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,nofail,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";

    in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
  };

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      fira-code
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "Fira Code" ];
      };
    };
  };

  systemd.timers."backup-gdrive-keepass" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "5m";
      Unit = "backup-gdrive-keepass.service";
    };
  };

  systemd.services."backup-gdrive-keepass" = {
    requisite = [ "mnt-gdrive.mount" ];
    script = ''
      set -eu
      [ -d /home/alex/KeePassBackup ] || mkdir /home/alex/KeePassBackup
      ${pkgs.coreutils}/bin/cp /mnt/gdrive/keepass/Master.kdbx /home/alex/KeePassBackup/Master-$(${pkgs.coreutils}/bin/date +'%Yy%mm%dd%Hh%Mm%Ss').kdbx
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "alex";
    };
  };

  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf = {
        enable = true;
        packages = [(pkgs.OVMF.override {
          secureBoot = true;
          tpmSupport = true;
        }).fd];
      };
    };
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?

}

