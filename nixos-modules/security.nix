{
  config,
  lib,
  ...
}: {
  security = {
    pam = lib.mkIf config.security.pam.u2f.enable {
      u2f.settings = {
        authfile = "/etc/u2f_keys";
        control = "sufficient";
      };

      services = {
        login.u2f.control = "required";
        greetd.u2f.control = "required";
        swaylock.u2f.control = "required";
      };
    };

    sudo = {
      enable = true;
      wheelNeedsPassword = false;
    };
  };
}
