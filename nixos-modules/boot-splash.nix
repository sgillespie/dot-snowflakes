{
  config,
  lib,
  pkgs,
  ...
}: 

let
  cfg = config.boot.splash;
in

with lib;

{
  options.boot.splash.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable a graphical boot screen";
  };

  config = mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
        theme = "solar";
      };

      # Enable "Silent boot"
      consoleLogLevel = 3;
      initrd.verbose = false;

      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
}

