{ pkgs, ... }:
{
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" ];
    packages = with pkgs; [
      bitwarden-desktop
      (chromium.override { enableWideVine = true; })
      dbeaver-bin
      wireshark
      keepassxc
      bottles
      libreoffice
      zed-editor
      vesktop
      kitty
      rar
      unrar
      r2modman
    ];
  };
}
