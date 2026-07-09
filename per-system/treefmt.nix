_parts: {
  perSystem = _: {
    treefmt = {
      programs.alejandra.enable = true;
      settings.formatter.alejandra.excludes = ["*/hardware-configuration.nix"];
    };
  };
}
