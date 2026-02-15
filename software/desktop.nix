{ pkgs, ... }:
{
  services.libinput.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;

    extraLv2Packages = [ pkgs.rnnoise-plugin ];
    configPackages = [
      (pkgs.writeTextDir "share/pipewire/pipewire.conf.d/99-input-denoising.conf" ''
        context.modules = [
        {   name = libpipewire-module-filter-chain
            args = {
                node.description =  "Noise Canceling source"
                media.name =  "Noise Canceling source"
                filter.graph = {
                    nodes = [
                        {
                            type = ladspa
                            name = rnnoise
                            plugin = /nix/store/7n1fbs83hiykr17yms5dsjhbvrvam7kp-rnnoise-plugin-1.10/lib/ladspa/librnnoise_ladspa.so
                            label = noise_suppressor_mono
                            control = {
                                "VAD Threshold (%)" = 50.0
                                "VAD Grace Period (ms)" = 200
                                "Retroactive VAD Grace (ms)" = 0
                            }
                        }
                    ]
                }
                capture.props = {
                    node.name =  "capture.rnnoise_source"
                    node.passive = true
                    audio.rate = 48000
                }
                playback.props = {
                    node.name =  "rnnoise_source"
                    media.class = Audio/Source
                    audio.rate = 48000
                }
            }
        }
        ]
      '')
    ];
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
