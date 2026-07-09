_parts: {
  perSystem = {pkgs, ...}: {
    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        alejandra
        deadnix
        home-manager
        just
        nixos-install-tools
        statix
      ];
    };
  };
}
