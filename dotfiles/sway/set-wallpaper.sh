#!/usr/bin/env bash

source /etc/os-release

exec swaymsg output '*' bg "$HOME/.config/sway/background-${ID}.png" fill
