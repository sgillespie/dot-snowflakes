{
  inputs,
  withSystem,
  ...
}: let
  system = "x86_64-linux";
in {
  flake = {
    nixosConfigurations.sean-work = inputs.nixpkgs.lib.nixosSystem {
      #
      specialArgs = {
        inherit inputs;
      };

      modules = [
        # Built-in modules
        inputs.home-manager.nixosModules.home-manager
        inputs.nix-index-database.nixosModules.default

        # User-defined modules
        ../../nixos-modules/default.nix

        # System configuration
        ./configuration.nix
      ];
    };

    homeConfigurations."sgillespie@sean-work" = withSystem system ({pkgs, ...}:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Pass inputs to home-manager config
        extraSpecialArgs = {
          inherit inputs;
        };

        modules = [
          ../../home-configurations/desktop.nix
          inputs.self.homeModules.overrides
        ];
      });
  };
}
