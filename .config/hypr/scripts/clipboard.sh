#!/usr/bin/env bash

# Exit if empty clipboard
[ -z "$(cliphist list)" ] && exit 0

SELECTION=$(cliphist list | rofi -dmenu -i \
  -p "Clipboard" \
  -no-fixed-num-lines \
  -theme "$HOME/.config/rofi/clipboard-dark.rasi" \
  -layer-shell \
  -normal-window \
  -kb-cancel Escape)

# Exit cleanly if cancelled
[ -z "$SELECTION" ] && exit 0

# Decode + copy selection
echo "$SELECTION" | cliphist decode | wl-copy

