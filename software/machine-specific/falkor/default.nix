{ ... }:
{
  imports = [ ../../. ];

  networking.hostName = "falkor";

  boot.kernelParams = [ "i915.force_probe=7d55" ];
  
  services.throttled.enable = false;

  system.stateVersion = "24.11";
}
