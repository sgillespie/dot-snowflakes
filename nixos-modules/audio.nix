{
  lib,
  config,
  pkgs,
  ...
}: 
let
  cfg = config.hardware.audio;
in {
  options.hardware.audio.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable audio services";
  };

  config = lib.mkIf cfg.enable {
    hardware.bluetooth.enable = true;

    # Allow pipewire to use RT scheduler
    security.rtkit.enable = true;

    services.pipewire = {
      enable = true;
      pulse.enable = true; # PulseAudio emulation

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}
