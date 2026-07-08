{ inputs, ... }: {
  flake.nixosConfigurations.sean-work = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;

          users.sgillespie = ../../home-configurations/default.nix;
        };
      }
    ];
  };
}
