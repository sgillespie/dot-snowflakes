{...}: {
  nix.settings = {
    trusted-users = ["root" "@wheel"];

    extra-trusted-public-keys = [
      "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
    ];

    extra-substituters = [
      "https://cache.iog.io"
    ];

    extra-experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
