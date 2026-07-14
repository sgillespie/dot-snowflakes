{
  config,
  lib,
  pkgs,
  ...
}: 

let
  cfg = config.hardware.powerManagement;
in {
  options.hardware.powerManagement.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable power management for laptops";
  };

  config = lib.mkIf cfg.enable {
    services.logind = {
      enable = true;
      settings.Login.HandleLidSwitchExternalPower = "ignore";
    };

    systemd.services.no-turbo = {
      wantedBy = ["multi-user.target"];
      description = "Disable Intel turbo boost";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo'";
      };
    };
  };
}
