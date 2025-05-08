{ pkgs, ... }:
{
  programs.mtr.enable = true;
  programs.thunderbird.enable = true;
  programs.wireshark.enable = true;
  programs.virt-manager.enable = true;
  programs.direnv.enable = true;
  programs.kdeconnect.enable = true;
  programs.waybar.enable = true;

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
    vlc
    mpv
    cifs-utils
    rclone
    gitFull
    libreoffice
    kitty
    rar
    unrar
    ranger
    wireshark
    zed-editor
    btop
    fastfetch
    ncdu
    librewolf
    ungoogled-chromium
    wofi
    mako

    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze

    hyprpolkitagent
  ];
}
