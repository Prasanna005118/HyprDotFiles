#!/usr/bin/env bash

# Get clipboard history, handling both text and images
SELECTION=$(cliphist list | rofi -dmenu -theme master-theme -p "Clipboard" -no-show-icons)

if [ -n "$SELECTION" ]; then
    # Decode and copy selection back to clipboard
    cliphist decode <<<"$SELECTION" | wl-copy
fi
