{
  description = "Dotfiles and system configs that are unapologetically unique";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{
    flake-parts,
    flake-utils,
    home-manager,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = flake-utils.lib.defaultSystems;

      imports = [
        home-manager.flakeModules.home-manager

        ./home-configurations/flake-module.nix
        ./per-system/dev-shell.nix
      ];

      flake = {
      };

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ... 
      }: {
      };
    };
}
