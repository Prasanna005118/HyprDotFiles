#!/usr/bin/env bash
set -e

echo "==> Uninstalling dotfiles setup"

# -----------------------------
# 1. Remove configs
# -----------------------------
echo "==> Removing configs"

rm -rf ~/.config/hypr
rm -rf ~/.config/rofi
rm -rf ~/.config/kitty
rm -rf ~/.config/waybar
rm -rf ~/.config/swaync

# -----------------------------
# 2. Remove wallpapers
# -----------------------------
echo "==> Removing wallpapers"

rm -rf ~/Pictures/Wallpapers

# -----------------------------
# 3. Remove pywal cache
# -----------------------------
rm -rf ~/.cache/wal

# -----------------------------
# 4. Optional: remove packages
# -----------------------------
read -rp "Remove installed packages (rofi, waybar, pywal, etc)? [y/N]: " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  sudo pacman -Rns --noconfirm \
    rofi \
    kitty \
    waybar \
    swaync \
    thunar \
    python-pywal \
    grim \
    slurp \
    swww \
    wl-clipboard \
    imagemagick \
    jq \
    flatpak || true

  if command -v yay &>/dev/null; then
    yay -Rns --noconfirm rofi-emoji || true
  fi
fi

echo "==> Uninstall complete. You may want to log out."


