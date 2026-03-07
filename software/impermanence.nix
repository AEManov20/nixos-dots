{ config, ... }:
{
  environment.persistence."/state" = {
    enable = true;
    hideMounts = true;

    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
      "/var/lib/tailscale"
      "/var/lib/flatpak"
    ];

    files = [
      "/etc/machine-id"
    ]
    ++ (map (x: x.path) config.services.openssh.hostKeys); # persist all SSH host keys
  };
}
