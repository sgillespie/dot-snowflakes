{pkgs, ...}: {
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
    };

    # Brave isn't in pacman official repositories, so install it from nixpkgs
    packages = with pkgs; [
      brave
      iamb
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
    "tmux".source = ../dotfiles/tmux;
    "rofi".source = ../dotfiles/rofi;
    "rofi-pass".source = ../dotfiles/rofi-pass;
    "waybar".source = ../dotfiles/waybar;
  };
}
