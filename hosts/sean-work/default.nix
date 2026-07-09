{ 
  inputs, 
  withSystem,
  ...
}: let
  system = "x86_64-linux";
in {
  flake.nixosConfigurations.sean-work = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      inputs.home-manager.nixosModules.home-manager
      ./configuration.nix
    ];
  };
}
