{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: let
  inherit (pkgs.hostPlatform) system;
in {
  imports = [
    ./base.nix
  ];
};
