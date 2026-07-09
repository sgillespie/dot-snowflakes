{
  inputs,
  withSystem,
  ...
}: let
  system = "x86_64-linux";
in {
  flake = {
    homeModules.overrides = {
      targets.genericLinux.enable = true;
    };

    homeConfigurations.sgillespie = withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass inputs to home-manager config
        extraSpecialArgs = {
          inherit inputs; 
        };

        modules = [
          ../../home-configurations/default.nix
          inputs.self.homeModules.overrides
        ];
      });
  };
}
