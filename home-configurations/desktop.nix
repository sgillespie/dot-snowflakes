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

  sops = {
    age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    defaultSopsFile = ../secrets/default.yaml;
    secrets."irssi.env" = {};
  };

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
      (iamb.overrideAttrs (oldAttrs: {
        # Temporarily fix iamb display in tmux. The lock icon corrupts the display (stray
        # characters, etc). This replaces the lock icon with a simple ascii character
        #
        # TODO[sgillespie]: The upstream fixes for this are unreleased. Try removing this
        # after the next released version (>0.1.11)
        postPatch =
          (oldAttrs.postPatch or "")
          + ''
            substituteInPlace src/windows/room/chat.rs \
              --replace-fail '\u{1F512}\u{FE0E} ' '> ' \
              --replace-fail '\u{1F513}\u{FE0E} ' '> '
          '';
      }))
      neovim-remote
      nil
      pinentry-rofi
      rofi-pass
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

