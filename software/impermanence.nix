{ config, ... }:
{
  environment.persistence."/state" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/var/log"
      "/etc/NetworkManager/system-connections"
      "/var/lib/nixos"
      "/var/lib/tailscale"
      "/var/lib/flatpak"
      "/var/lib/systemd"
      "/var/lib/libvirt"
    ];

    files = [
      "/etc/machine-id"
    ]
    ++ (map (x: x.path) config.services.openssh.hostKeys); # persist all SSH host keys
  };
}
