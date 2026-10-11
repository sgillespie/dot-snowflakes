_default:
  @just --list --unsorted

# runs local static analysis checks
check:
  nix flake check -v

# reformats source files
fmt:
  nix fmt

gsettings-update:
  gsettings set org.gnome.desktop.interface gtk-theme catppuccin-mocha-lavender-standard+rimless
  gsettings set org.gnome.desktop.interface font-name "Inter 12"
  gsettings set org.gnome.desktop.interface icon-theme "Tela-black"
  gsettings set org.gnome.desktop.interface cursor-theme "volantes_light_cursors"

# pulls $HOME/dev/docs from host
docs host *ARGS:
  rsync \
    --archive \
    --update \
    --itemize-changes \
    --partial \
    --progress \
    --backup \
    {{ARGS}} {{host}}.home:"$HOME/dev/docs" $HOME/dev

# updates nix flake inputs
nix-update *ARGS:
  nix flake update {{ ARGS }}

# builds a NixOS host configuration
[group('nixos')]
nixos-build host *ARGS:
  nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel

# activates the NixOS current host configuration
[group('nixos')]
nixos-switch *ARGS:
  nixos-rebuild --sudo --flake . switch

# builds a VM from a NixOS configuration host configuration
[group('nixos')]
nixos-vm host *ARGS:
  nix build .#nixosConfigurations.{{host}}.config.system.build.vm

# builds a recover ISO image
[group('nixos')]
nixos-recovery *ARGS:
  nix build {{ARGS}} .#nixosConfigurations.nixos-recovery.config.system.build.isoImage

# applies home-manager configurations
[group('home-manager')]
hm-apply *ARGS:
  home-manager --flake . switch {{ARGS}}

# builds home-manager configurations
[group('home-manager')]
hm-build *ARGS:
  home-manager --flake . build {{ARGS}}

# generates ArchLinux pacman package list
[group('pacman')]
pacman-pkglist:
  pacman -Qqen | sort > hosts/$HOSTNAME/pkglist.txt
  pacman -Qqem | sort > hosts/$HOSTNAME/pkglist-foreign.txt

# run pacman-pkglist on a remote host
[group('pacman')]
pacman-remote-pkglist host name:
  ssh "{{ host }}" "pacman -Qqen" | sort > "hosts/{{ name }}/pkglist.txt"
  ssh "{{ host }}" "pacman -Qqem" | sort > "hosts/{{ name }}/pkglist-foreign.txt" || true

# factors out the common pkglist entries into a common list
[group('pacman')]
pacman-base-pkglist:
  #!/usr/bin/env bash
  set -exu -o pipefail
  # Create a temporary backup of the pkg lists
  WORK_DIR=$(mktemp -d pkglist.XXXX)
  cp hosts/sean-archlinux/pkglist.txt $WORK_DIR/pkglist-sean-archlinux.txt
  cp hosts/sean-pi4-archlinuxarm/pkglist.txt $WORK_DIR/pkglist-sean-pi4-archlinuxarm.txt

  comm -12 $WORK_DIR/pkglist-sean-archlinux.txt $WORK_DIR/pkglist-sean-pi4-archlinuxarm.txt \
    > hosts/pkglist-base.txt
  comm -13 hosts/pkglist-base.txt $WORK_DIR/pkglist-sean-archlinux.txt \
    > hosts/sean-archlinux/pkglist.txt
  comm -13 hosts/pkglist-base.txt $WORK_DIR/pkglist-sean-pi4-archlinuxarm.txt \
    > hosts/sean-pi4-archlinuxarm/pkglist.txt

  rm -r $WORK_DIR

# installs/syncs packages in the ArchLinux pacman package list
[group('pacman')]
pacman-pkglist-apply:
  cat hosts/pkglist-base.txt hosts/$HOSTNAME/pkglist.txt | sort | sudo pacman -Sq --needed -

# reloads the gpg-agent config
[group('gpg-agent')]
gpgagent-reload:
  gpg-connect-agent reloadagent /bye

# refresh the gpg-agent pinentry startuptty
[group('gpg-agent')]
gpgagent-updatetty:
  gpg-connect-agent updatestartuptty /bye

# syncs the `etc/` submodule
[group('etc')]
etc-update:
  git submodule update --init --remote --merge

# show etckeeper git status
[group('etc')]
etc-status:
  sudo etckeeper vcs status

# show etckeeper git diff
[group('etc')]
etc-diff:
  sudo etckeeper vcs diff

# commit etckeeper changes
[group('etc')]
etc-commit:
  sudo --preserve-env=EDITOR etckeeper vcs commit --allow-empty

# show customized files in `/etc`
[group('etc')]
etc-review:
  @echo "Backup:"
  @sudo pacman -Qkk 2>&1 \
    | awk 'BEGIN { FS=": " }; /^backup file/ { print $3 }' \
    | awk '{printf "  %s\n", $1}' \
    | git -C etc check-ignore --no-index --stdin \
    | sort \
    | uniq

  @echo "Packages:"
  @sudo pacman -Qkk 2>/dev/null \
    | awk 'BEGIN { FS="[:,]" }; !/^backup file/ && !/0 altered files$/{ printf "  %s:%s\n", $1, $3}'

  @echo "Unexpected:"
  @sudo pacman -Qkk 2>&1 \
    | awk '!/^backup file/ && !/altered file[s]?$/ { printf "  %s\n", $0 }'
