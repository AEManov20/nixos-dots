{ pkgs, ... }:
{
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" "adbusers" ];
    packages = with pkgs; [
      bitwarden-desktop
      (chromium.override { enableWideVine = true; })
      dbeaver-bin
      wireshark
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
