{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.display-server;
in
  with lib; {
    options.services.display-server.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable a graphical desktop environment";
    };

    config = mkIf cfg.enable {
      xdg.portal = {
        enable = true;

        extraPortals = with pkgs; [
          xdg-desktop-portal-gtk
          xdg-desktop-portal-wlr
        ];

        config.sway.default = lib.mkForce ["wlr" "gtk"];
        wlr = {
          enable = true;
          settings.screencast = {
            chooser_type = "dmenu";
            chooser_cmd = "rofi -dmenu";
          };
        };
      };

      systemd.user.services.xdg-desktop-portal-wlr.path = with pkgs; [rofi];

      # Hardware video acceleration
      hardware.graphics.extraPackages = with pkgs; [
        intel-media-driver
        vpl-gpu-rt
      ];
      environment.sessionVariables.LIBVA_DRIVER_NAME = "iHD";

      # WMs
      programs = {
        hyprland = {
          enable = true;
          withUWSM = true;
          xwayland.enable = true;
        };

        sway = {
          enable = true;
          wrapperFeatures.gtk = true;
          extraSessionCommands = ''
            # General wayland environment variables
            export QT_QPA_PLATFORM="wayland;xcb"
            export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
          '';
        };

        waybar.enable = true;
      };

      #
      services.greetd = {
        enable = true;
        useTextGreeter = true;
        settings = {
          default_session = {
            command = lib.concatStringsSep " " [
              "${pkgs.tuigreet}/bin/tuigreet"
              "--time"
              "--sessions /run/current-system/sw/share/wayland-sessions"
              "--cmd sway"
            ];
            user = "greeter";
          };
        };
      };

      fonts = {
        fontconfig.enable = true;
        fontDir.enable = true; # This is required for extra fonts

        packages = with pkgs; [
          atkinson-hyperlegible
          atkinson-hyperlegible-mono
          corefonts
          font-awesome
          inter
          lora
          merriweather
          merriweather-sans
          nerd-fonts._0xproto
          nerd-fonts.atkynson-mono
          nerd-fonts.caskaydia-cove
          nerd-fonts.jetbrains-mono
          nerd-fonts.sauce-code-pro
          source-code-pro
          hyprlauncher
        ];
      };
    };
  }
