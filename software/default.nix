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
    "nvidia-x11"
    "nvidia-settings"
    "cuda-merged"
    "cuda_cuobjdump"
    "cuda_gdb"
    "cuda_nvcc"
    "cuda_nvdisasm"
    "cuda_nvprune"
    "cuda_cccl"
    "cuda_cudart"
    "cuda_cupti"
    "cuda_cuxxfilt"
    "cuda_nvml_dev"
    "cuda_nvrtc"
    "cuda_nvtx"
    "cuda_profiler_api"
    "cuda_sanitizer_api"
    "libcublas"
    "libcufft"
    "libcurand"
    "libcusolver"
    "libnvjitlink"
    "libcusparse"
    "libnpp"
    "nvidia-persistenced"
    "vscode-extension-ms-vscode-cpptools"
    "vscode-with-extensions"
    "vscode"
  ];

  time.timeZone = "Europe/Sofia";

  i18n.defaultLocale = "en_US.UTF-8";
}
