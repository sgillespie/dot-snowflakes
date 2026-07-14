#!/bin/sh

. /etc/os-release

case "${ID:-}" in
  nixos)
    logo=''
    ;;
  *)
    logo=''
    ;;
esac

printf '%s\n' "$logo"
