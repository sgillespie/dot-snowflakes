_default:
  @just --list

# applies home-manager configurations
hm-apply:
  home-manager --flake . switch

# builds home-manager configurations
hm-build:
  home-manager --flake . build

# generates ArchLinux pacman package list
alpm-pkglist:
  pacman -Qqen > hosts/sean-archlinux/pkglist.txt
  pacman -Qqem > hosts/sean-archlinux/pkglist-foreign.txt

# installs/syncs packages in the ArchLinux pacman package list
alpm-pkglist-apply:
  sudo pacman -Sq --needed - < hosts/sean-archlinux/pkglist.txt
