{
  config,
  lib,
  pkgs,
  ...
}: 

let
  cfg = config.services.display-server;
in

with lib;

{
  options.services.display-server.enable = mkOption {
    type = types.bool;
    default = false;
    description = "Enable a graphical desktop environment";
  };

  config = mkIf cfg.enable {
    # 
    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      config.sway.default = lib.mkForce [ "wlr" "gtk" ];
    };

    # 
    programs = {
      sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraOptions = [ "--unsupported-gpu" ];
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
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";                                                  
        }; 
      };
    };

    fonts = {
      fontDir.enable = true;  # This is required for extra fonts

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
        nerd-fonts.caskaydia-cove
        nerd-fonts.jetbrains-mono
        nerd-fonts.sauce-code-pro
        source-code-pro
      ];
    };
  };
}
