{ pkgs, ... }:
{
  services.libinput.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # Enable the COSMIC login manager
  # services.displayManager.cosmic-greeter.enable = true;

  # Enable the COSMIC desktop environment
  # services.desktopManager.cosmic.enable = true;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.steam.gamescopeSession.enable = true;
}
