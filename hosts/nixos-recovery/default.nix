{inputs, ...}: {
  flake.nixosConfigurations.nixos-recovery = inputs.nixpkgs.lib.nixosSystem {
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
}
