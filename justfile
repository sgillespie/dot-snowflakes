_default:
  @just --list --unsorted

# applies home-manager configurations
[group('home-manager')]
hm-apply:
  home-manager --flake . switch

# builds home-manager configurations
[group('home-manager')]
hm-build:
  home-manager --flake . build

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
