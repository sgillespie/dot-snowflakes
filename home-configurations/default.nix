{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
    inputs.nix-index-database.homeModules.default

    ../home-modules/default.nix
  ];

  sops = {
    defaultSopsFile = ../secrets/default.yaml;
    gnupg.home = "${config.home.homeDirectory}/.gnupg";
    secrets."irssi.env" = {};
  };

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) (with pkgs; [
      claude-code.pname
      slack.pname
    ]);

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
    };

    # Brave isn't in pacman official repositories, so install it from nixpkgs
    packages = with pkgs; [
      # These packages aren't in official repositories, so we install it from nixpkgs
      brave
      claude-code
      comma
      iamb
      neovim-remote
      pinentry-rofi
      rofi-pass
      slack
    ];
  };

  xdg.configFile = {
    "git".source = ../dotfiles/git;
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
