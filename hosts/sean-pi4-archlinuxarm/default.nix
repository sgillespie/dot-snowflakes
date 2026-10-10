{
  inputs,
  withSystem,
  ...
}: let
  system = "aarch64-linux";
in {
  flake = {
    homeModules.overrides = {
      targets.genericLinux = {
        enable = true;
        gpu.enable = false;
      };
    };

    homeConfigurations."sgillespie@sean-pi4-archlinuxarm" = withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass inputs to home-manager config
        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ../../home-configurations/headless.nix
          inputs.self.homeModules.overrides
        ];
      });
  };
}

