{ pkgs, ... }:
{
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" "adbusers" "input" ];
    shell = pkgs.zsh;
    hashedPasswordFile = "/state/shadow/alex";
  };

  users.mutableUsers = false;
}
