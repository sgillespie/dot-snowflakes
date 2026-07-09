{inputs, ...}: {
  flake.nixosConfigurations.sean-work = inputs.nixpkgs.lib.nixosSystem {
    # 
    specialArgs = { 
      inherit inputs;
    };

    modules = [
      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
