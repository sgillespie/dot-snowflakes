{
  description = "Dotfiles and system configs that are unapologetically unique";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    statix.url = "github:oppiliappan/statix";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    flake-utils,
    home-manager,
    treefmt-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = flake-utils.lib.defaultSystems;

      imports = [
        # Flake parts modules
        treefmt-nix.flakeModule
        home-manager.flakeModules.home-manager

        # System/host configs (snowflakes)
        ./hosts/sean-archlinux/default.nix
        ./hosts/sean-work/default.nix

        # Local development tools
        ./per-system/lint.nix
        ./per-system/treefmt.nix
        ./per-system/dev-shell.nix
      ];
    };
}
