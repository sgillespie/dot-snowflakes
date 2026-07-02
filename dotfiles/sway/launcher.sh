#!/usr/bin/env bash

export ROFI_PASS_CLIPBOARD_BACKEND=wl-clipboard

# Curated rofi launcher; contains frequently-used apps

declare -A cmd
cmd[Bluetuith]='kitty --app-id kitty_float bluetuith'
cmd[Brave]='brave --profile-directory=Default'
cmd["Brave (work)"]='brave --profile-directory IOG'
cmd[Discord]='discord'
cmd[nmtui]="kitty --app-id kitty_float nmtui"
cmd[Pass]='rofi-pass'
cmd[Pulsemixer]='kitty --app-id kitty_float pulsemixer'
cmd[Slack]='slack'
cmd[Spotify]='spotify-launcher'
cmd[Thunderbird]='thunderbird'
cmd[Neovide]='neovide'
cmd[Telegram]='Telegram'

declare -A icon
icon[Bluetuith]=bluetooth
icon[Brave]=brave-browser
icon["Brave (work)"]=brave-browser
icon[Discord]=discord
icon[nmtui]=network-wired
icon[Pass]=dialog-password
icon[Pulsemixer]=audio-volume-high
icon[Slack]=slack
icon[Spotify]=spotify
icon[Thunderbird]=thunderbird
icon[Telegram]=telegram
icon[Neovide]=nvim

order=(Neovide Brave "Brave (work)" Slack Thunderbird Pass Spotify Discord Signal Telegram Bluetuith Pulsemixer nmtui)

if [[ -n "$@" ]]; then
  coproc ( ${cmd[$@]} > /dev/null 2>&1 )
  exit 0
fi

for name in "${order[@]}"; do
  printf '%s\0icon\x1f%s\n' "$name" "${icon[$name]}"
done
