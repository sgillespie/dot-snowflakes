{inputs, ...}: {
  flake.nixosConfigurations.sean-work = inputs.nixpkgs.lib.nixosSystem {
    #
    specialArgs = {
      inherit inputs;
    };

    modules = [
      # Built-in modules
      inputs.home-manager.nixosModules.home-manager

      # User-defined modules
      ../../nixos-modules/default.nix

      # System configuration
      ./configuration.nix
    ];
  };
}
