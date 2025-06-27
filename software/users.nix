{ ... }:
{
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "wireshark" "docker" "uucp" "dialout" "tty" "adbusers" "input" ];
  };
}
