{ pkgs, ... }:
{
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" "adbusers" ];
    packages = with pkgs; [
      bitwarden-desktop
      chromium
      dbeaver-bin
      wireshark
      bottles
      zed-editor
      vesktop
      r2modman
    ];
  };
}
