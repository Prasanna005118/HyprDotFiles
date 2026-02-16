#!/usr/bin/env bash

# Take screenshot, save to file, and copy to clipboard with cliphist support
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOT_DIR"

FILENAME="$SCREENSHOT_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

# Region selection + save + clipboard
grim -g "$(slurp)" - | tee "$FILENAME" | wl-copy --type image/png

# CRITICAL: Also store in cliphist
wl-paste --type image/png | cliphist store

notify-send "Screenshot saved" "$FILENAME"
