{
  lib,
  pkgs,
  ...
}: {
  # Settings for all NixOS hosts
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.sgillespie = {
    extraGroups = ["wheel" "networkmanager" "video"];
    initialHashedPassword = "";
    isNormalUser = true;
    shell = pkgs.zsh;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBWAhzvN9VsD3TV8+aoNqUkaLLhuM5uFg6eUkic+FyHm (none)"
    ];
  };

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
      pinentryPackage = lib.mkDefault pkgs.pinentry-rofi;
    };

    ssh.startAgent = false;
  };

  services.pcscd.enable = true;
}
