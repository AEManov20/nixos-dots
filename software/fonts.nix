{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      nerd-fonts.fira-code
      texlivePackages.fontawesome
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode Nerd Font" ];
        serif = [ "Noto Serif" ];
        sansSerif = [ "Noto Sans" ];
      };
    };
  };
}
