{inputs, ...}: {
  flake = {
    homeConfigurations.sgillespie = inputs.home-manager.lib.homeManagerConfiguration {
      modules = [];
    };
  };
}
