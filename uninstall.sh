#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==> Removing dotfiles symlinks"

remove_link() {
  local target="$1"
  if [ -L "$CONFIG_DIR/$target" ]; then
    rm "$CONFIG_DIR/$target"
    echo "Removed symlink: $target"
  fi
done

for dir in hypr waybar rofi kitty swaync scripts; do
  remove_link "$dir"
done

echo
echo "==> Dotfiles uninstalled."
echo "==> Backups (.bak) were NOT deleted."

