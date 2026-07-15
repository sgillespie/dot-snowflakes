{
  config,
  lib,
  pkgs,
  ...
}: {

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) (with pkgs; [
      corefonts.pname 
      discord.pname
      spotify.pname
    ]);

  environment.systemPackages = with pkgs; [
    # Core utilities
    age
    autoconf
    automake
    bashInteractive
    bat
    binutils
    cryptsetup
    curl
    dig
    dnsutils
    envsubst
    file
    gcc
    gdu
    git
    gnumake
    gnupg
    jq
    lsof
    magic-wormhole
    openssh
    openssl
    neovim
    patchelf
    parted
    pass
    pciutils
    ripgrep
    rsync
    time
    tmux
    unzip
    usbutils
    wget
    whois
    xdg-utils
    zip

    # Useful tools
    direnv
    gh
    just
    opencode
    pgcli
    ssh-audit

    # Extras
    fastfetch
    nvchecker
    starship
  ] ++ lib.optionals config.services.display-server.enable [
    # GUI apps
    cliphist
    dex
    discord
    evince
    grim
    kanshi
    kitty
    lxappearance
    mako
    neovide
    rofi
    spotify
    thunderbird
    tuigreet
    wdisplays
    wl-clipboard

    # Themes
    glib # Provides gsettings
    kanagawa-gtk-theme
    kanagawa-icon-theme

    # Virtualization
    debootstrap
  ] ++ lib.optionals config.hardware.audio.enable [
    bluetuith
    pulsemixer
  ];

  programs = {
    browserpass.enable = true;
    nix-index-database.comma.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      interactiveShellInit = ''
        source "${pkgs.zsh-history-substring-search}/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
      '';
    };
  };
}
