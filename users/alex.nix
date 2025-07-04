{ pkgs, ... }: {
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    dotIcons.enable = true;
    hyprcursor.enable = true;
    enable = true;

    package = pkgs.bibata-cursors;
    name = "Bibata-Original-Classic";
    size = 16;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;

    font = {
      name = "Noto Sans";
      package = pkgs.noto-fonts;
      size = 10;
    };

    # theme = {
    #   package = pkgs.kdePackages.breeze-gtk;
    #   name = "Breeze-Dark";
    # };

    # iconTheme = {
    #   package = pkgs.kdePackages.breeze-icons;
    #   name = "breeze-dark";
    # };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # qt = {
  #   enable = true;

  #   platformTheme.name = "kde";

  #   style = {
  #     package = pkgs.kdePackages.breeze;
  #     name = "Breeze";
  #   };
  # };

  home.stateVersion = "24.11";
}
