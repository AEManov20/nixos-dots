{ pkgs, ... }:
{
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
}