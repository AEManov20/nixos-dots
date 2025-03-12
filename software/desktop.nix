{ pkgs, ... }:
{
  services.displayManager = {
    plasma6.enable = true;

    sddm = {
      enable = true;
      wayland.enable = true;
      defaultSession = "plasma";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa
  ];
}
