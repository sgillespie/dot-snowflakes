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
  pacman -Qqe > hosts/sean-archlinux/pkglist.txt

# installs/syncs packages in the ArchLinux pacman package list
alpm-pkglist-apply:
  pacman -S --needed - < hosts/sean-archlinux/pkglist.txt
