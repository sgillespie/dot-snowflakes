_default:
  @just --list

# applies home-manager configurations
hm-apply:
  home-manager --flake . switch

# builds home-manager configurations
hm-build:
  home-manager --flake . build
