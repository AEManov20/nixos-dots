{ lib, pkgs, high-tide-ext, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  
    shellAliases = {
      ll = "ls -l";
    };
  };

  programs.mtr.enable = true;
  programs.thunderbird.enable = true;
  programs.wireshark = {
    usbmon.enable = true;
    enable = true;
    package = pkgs.wireshark;
  };
  programs.virt-manager.enable = true;
  programs.direnv.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
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

  programs.steam = {
    enable = true;
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  programs.firefox = {
    enable = true;
    nativeMessagingHosts.packages = [ pkgs.tridactyl-native ];
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
      ExtensionSettings = let
        moz = addon_id: "https://addons.mozilla.org/firefox/downloads/latest/${addon_id}/latest.xpi";
      in {
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = moz "tridactyl.vim@cmcaine.co.uk";
          installation_mode = "force_installed";
          updates_disabled = true;
          private_browsing = true;
        };
        "{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          install_url = moz "{73a6fe31-595d-460b-a920-fcc0f8843232}"; # noscript
          installation_mode = "force_installed";
          updates_disabled = true;
          private_browsing = true;
        };
        "addon@darkreader.org" = {
          install_url = moz "addon@darkreader.org";
          installation_mode = "force_installed";
          updates_disabled = true;
          private_browsing = false;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = moz "{446900e4-71c2-419f-a6a7-df9c091e268b}"; # bitwarden
          installation_mode = "force_installed";
          updates_disabled = true;
          private_browsing = true;
        };
      };
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.firejail = let
    ptPkg = pkgs.ciscoPacketTracer9;
  in
  {
    enable = true;
    wrappedBinaries = {
      packettracer9 = {
        executable = lib.getExe ptPkg;

        # Will still want a .desktop entry as the package is not directly added
        # desktop = "${ptPkg}/share/applications/cisco-pt9.desktop.desktop";

        extraArgs = [
          # This should make it run in isolated netns, preventing internet access
          "--net=none"

          # firejail is only needed for network isolation so no futher profile is needed
          "--noprofile"

          # Packet tracer doesn't play nice with dark QT themes so this
          # should unset the theme. Uncomment if you have this issue.
          ''--env=QT_STYLE_OVERRIDE=""''
        ];
      };
    };
  };

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
  environment.systemPackages = with pkgs; [
    vlc
    mpv
    strawberry
    high-tide-ext
    libreoffice-qt-fresh
    kitty
    mangohud
    vesktop
    signal-desktop
    bottles
    solaar
    qalculate-qt
    chromium
    tor-browser

    pkgsRocm.blender
    lact

    swayimg
    kdePackages.kleopatra

    wl-clipboard
    wayland-utils
    rclone
    gitFull
    rar
    unrar
    zip
    unzip
    htop
    nethogs
    nvtopPackages.amd
    ncdu
    borgbackup
    helix

    dive
    android-tools
    
    nil
    nixfmt
    nixd

    opensc
    libp11
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];

  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
    cosmic-player
    cosmic-term
  ];

  documentation.man.cache.enable = true;

  xdg.portal.enable = true;
}
