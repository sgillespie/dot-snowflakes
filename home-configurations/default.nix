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
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-index-database.homeModules.default

    ../home-modules/default.nix
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
    username = "sgillespie";
    homeDirectory = "/home/sgillespie";
    stateVersion = "26.05";

    file = {
      # GPG
      ".gnupg/gpg.conf".source = ../dotfiles/gnupg/gpg.conf;
      ".gnupg/gpg-agent.conf".source = ../dotfiles/gnupg/gpg-agent.conf;
      ".gnupg/scdaemon.conf".source = ../dotfiles/gnupg/scdaemon.conf;

      # Shell
      ".zshrc".source = ../dotfiles/zsh/zshrc;
      ".zprofile".source = ../dotfiles/zsh/zprofile;
      ".profile".source = ../dotfiles/zsh/profile;

      # AI-assisted coding agents
      ".claude/CLAUDE.md".source = ../dotfiles/agents/AGENTS.md;
      ".config/opencode/AGENTS.md".source = ../dotfiles/agents/AGENTS.md;

      ".irssi/config".source = ../dotfiles/irssi/config;
      ".irssi/custom.theme".source = ../dotfiles/irssi/custom.theme;

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

  xdg.configFile = {
    "git".source = ../dotfiles/git;
    "ghostty".source = ../dotfiles/ghostty;
    "iamb".source = ../dotfiles/iamb;
    "kanshi".source = ../dotfiles/kanshi;
    "kitty".source = ../dotfiles/kitty;
    "mako".source = ../dotfiles/mako;
    "nix".source = ../dotfiles/nix;
    "nvim".source = ../dotfiles/nvim;
    "opencode/opencode.jsonc".source = ../dotfiles/opencode/opencode.jsonc;
    "sway".source = ../dotfiles/sway;
    "swaylock".source = ../dotfiles/swaylock;
    "tmux".source = ../dotfiles/tmux;
    "rofi".source = ../dotfiles/rofi;
    "rofi-pass".source = ../dotfiles/rofi-pass;
    "starship.toml".source = ../dotfiles/starship/starship.toml;
    "waybar".source = ../dotfiles/waybar;
  };
}
