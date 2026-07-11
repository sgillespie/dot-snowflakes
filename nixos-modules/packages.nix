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
    autoconf
    automake
    bashInteractive
    bat
    binutils
    comma
    cryptsetup
    curl
    dig
    direnv
    dnsutils
    fastfetch
    file
    gcc
    gdu
    git
    gh
    gnumake
    gnupg
    jq
    just
    lsof
    magic-wormhole
    nvchecker
    opencode
    openssh
    openssl
    neovim
    patchelf
    parted
    pass
    pciutils
    pgcli
    ripgrep
    rsync
    ssh-audit
    starship
    time
    tmux
    unzip
    usbutils
    wget
    whois
    xdg-utils
    zip
    zsh
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
    rofi
    spotify
    thunderbird
    tuigreet
    wdisplays
    wl-clipboard
  ];

  programs = {
    comma.enable = true;

    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
