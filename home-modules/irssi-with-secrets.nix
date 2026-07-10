{
  config,
  pkgs,
  ...
}: let
  wrappedIrssi = pkgs.writeScriptBin "irssi" ''
    # Read secret environment variables
    set -a # Export all variables when running `source` below
    source "${config.sops.secrets."irssi.env".path}"
    set +a # Restore allexport option

    # Replace secret tokens from environment
    envsubst < "$HOME/.irssi/config" > "/run/user/$UID/irssi.conf"

    # Run irssi
    ${pkgs.irssi}/bin/irssi --config "/run/user/$UID/irssi.conf"
  '';
in {
  home.packages = [wrappedIrssi];
}
