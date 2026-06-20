{self, ...}: {
  perSystem = {pkgs, ...}: let
    mkStaticCheck = name: nativeBuildInputs: cmd:
      pkgs.runCommand name {inherit nativeBuildInputs;} ''
        cd ${self}
        ${cmd}
        touch $out
      '';
  in {
    checks = {
      deadnix = mkStaticCheck "deadnix-check" [pkgs.deadnix] "deadnix -f";
      statix = mkStaticCheck "statix-check" [pkgs.statix] "statix check";
    };
  };
}
