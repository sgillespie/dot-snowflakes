{inputs, ...}:{ 
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    users.sgillespie = {
      imports = [
        ../home-configurations/default.nix
      ];
    };
  };
}
