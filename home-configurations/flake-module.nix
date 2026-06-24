{
  inputs,
  withSystem,
  ...
}: {
  flake = let
    system = "x86_64-linux";
  in {
    homeConfigurations.sgillespie = withSystem system ({pkgs, ...}:
      let
        nixgl = import inputs.nixgl { inherit pkgs; };
      in
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            # Pass nixgl packages to modules
            { _module.args.nixgl = nixgl; }

            # Home config
            ./default.nix
          ];
        });
  };
}
