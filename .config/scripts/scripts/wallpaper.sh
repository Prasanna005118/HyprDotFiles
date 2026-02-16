#!/usr/bin/env bash
WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
THUMB_DIR="$HOME/.cache/wallpaper-thumbs"
ROFI_THEME="$HOME/.config/rofi/pywal-wallpaper.rasi"

# Build rofi input with icons
ROFI_INPUT=""
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png,webp}; do
  [ -f "$img" ] || continue
  name=$(basename "$img")
  thumb="$THUMB_DIR/$name.png"
  # fallback if thumb missing
  [ ! -f "$thumb" ] && thumb="$img"
  ROFI_INPUT+="$name\x00icon\x1f$thumb\n"
done

# Launch rofi
FILE=$(printf "%b" "$ROFI_INPUT" | rofi -dmenu -i \
  -theme "$ROFI_THEME" \
  -p "Wallpaper")

[ -z "$FILE" ] && exit 0

FULL_PATH="$WALLPAPER_DIR/$FILE"

# Set wallpaper with transition
swww img "$FULL_PATH" \
  --transition-type grow \
  --transition-duration 0.6 \
  --transition-fps 60

# Apply pywal
wal -i "$FULL_PATH" -n

# Reload waybar
pkill waybar && waybar &