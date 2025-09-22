{ pkgs, zen-browser, ... }:
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
    package = pkgs.wireshark-qt;
  };
  programs.virt-manager.enable = true;
  programs.direnv.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
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

  programs.steam = {
    enable = true;
    # remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    # dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
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
      ExtensionSettings = {
        "tridactyl.vim@cmcaine.co.uk" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4549492/tridactyl_vim-1.24.4.xpi";
          installation_mode = "force_installed";
	  updates_disabled = true;
	  private_browsing = true;
	};
	"{73a6fe31-595d-460b-a920-fcc0f8843232}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4551629/noscript-13.0.9.xpi";
	  installation_mode = "force_installed";
	  updates_disabled = true;
	  private_browsing = true;
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/4535824/darkreader-4.9.110.xpi";
	  installation_mode = "force_installed";
	  updates_disabled = true;
	  private_browsing = false;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
	  install_url = "https://addons.mozilla.org/firefox/downloads/file/4562769/bitwarden_password_manager-2025.8.1.xpi";
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

  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    vlc
    mpv
    cifs-utils
    rclone
    gitFull
    libreoffice
    kitty
    rar
    unrar
    zip
    unzip
    zed-editor
    btop
    nvtopPackages.amd
    fastfetch
    ncdu
    mangohud
    renderdoc
    vesktop
    bottles
    solaar
    chromium

    dive
    podman-tui
    podman-compose
    
    nil
    nixfmt-classic
    nixd

    kdePackages.okular
    kdePackages.discover
    kdePackages.ksystemlog
    kdePackages.sddm-kcm
    kdePackages.audiocd-kio
    kdePackages.kleopatra

    libcdio

    lact

    blender-hip

    opensc
    libp11

    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        vscodevim.vim
        ms-vscode.cmake-tools
        vadimcn.vscode-lldb
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        mkhl.direnv
	rust-lang.rust-analyzer
	llvm-vs-code-extensions.vscode-clangd
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "wgsl";
	  publisher = "PolyMeilex";
          version = "0.1.17";
          sha256 = "sha256-vGqvVrr3wNG6HOJxOnJEohdrzlBYspysTLQvWuP0QIw=";
	}
      ];
    })
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
  ];

  documentation.man.generateCaches = true;
}
