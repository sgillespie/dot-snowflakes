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

  nixpkgs.config = {
    allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) (with pkgs; [
        claude-code.pname
        slack.pname
        ventoy.pname
      ]);

    permittedInsecurePackages = with pkgs; [
      ventoy.name
    ];
  };

  home = {
    file = {
      "${config.xdg.binHome}/pinentry".source = "${pkgs.pinentry-rofi}/bin/pinentry-rofi";
    };

    # Brave isn't in pacman official repositories, so install it from nixpkgs
    packages = with pkgs; [
      # These packages aren't in official repositories, so we install it from nixpkgs
      brave
      claude-code
      (iamb.overrideAttrs (_ : { dontCargoUseSystemLibs = true; }))
      neovim-remote
      nil
      pinentry-rofi
      # No longer in nixpkgs
      # rofi-pass
      ssh-to-age
      slack
      ventoy-full

      inputs.tomato-slicer.packages.${system}."tomato-slicer:exe:tomato-slicer"
    ];
  };

  programs = {
    nix-index-database.comma.enable = true;
  };
}

