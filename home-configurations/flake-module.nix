{
  inputs,
  withSystem,
  ...
}: {
  flake = 
    let
      system = "x86_64-linux";
    in {
      homeConfigurations.sgillespie = withSystem system ({pkgs, ...}:
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./default.nix ];
        });
    };
}
