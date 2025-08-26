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
    fastfetch
    ncdu
    zen-browser
    mangohud
    renderdoc

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

    lact

    blender-hip

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
