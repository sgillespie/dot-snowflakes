_default:
  @just --list --unsorted

# builds a NixOS host configuration
[group('nixos')]
nixos-build host *ARGS:
  nix build .#nixosConfigurations.{{host}}.config.system.build.toplevel

# builds a VM from a NixOS configuration host configuration
[group('nixos')]
nixos-vm host *ARGS:
  nix build .#nixosConfigurations.{{host}}.config.system.build.vm

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
  pacman -Qqen > hosts/sean-archlinux/pkglist.txt
  pacman -Qqem > hosts/sean-archlinux/pkglist-foreign.txt

# installs/syncs packages in the ArchLinux pacman package list
[group('pacman')]
pacman-pkglist-apply:
  sudo pacman -Sq --needed - < hosts/sean-archlinux/pkglist.txt

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
    | sort \
    | uniq

  @echo "Packages:"
  @sudo pacman -Qkk 2>/dev/null \
    | awk 'BEGIN { FS="[:,]" }; !/^backup file/ && !/0 altered files$/{ printf "  %s:%s\n", $1, $3}'

  @echo "Unexpected:"
  @sudo pacman -Qkk 2>&1 \
    | awk '!/^backup file/ && !/altered file[s]?$/ { printf "  %s\n", $0 }'
