{ lib, ... }:
{
  imports = [
    ./bootloader.nix
    ./desktop.nix
    ./fonts.nix
    ./networking.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./virtualisation.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "chromium"
    "chromium-unwrapped"
    "widevine-cdm"
    "rar"
    "unrar"
    "vscode-extension-ms-vscode-cpptools"
    "vscode-with-extensions"
    "vscode"
    "blender"
    "pcsc-safenet"
  ];

  time.timeZone = "Europe/Vienna";

  i18n.defaultLocale = "en_US.UTF-8";
}
