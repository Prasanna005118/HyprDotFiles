#!/usr/bin/env bash
set -e

echo "==> Installing dotfiles setup"

# -----------------------------
# 1. Ensure base tools
# -----------------------------
sudo pacman -S --needed --noconfirm \
  git \
  base-devel \
  curl \
  wget \
  wl-clipboard \
  grim \
  slurp \
  swww \
  rofi \
  kitty \
  waybar \
  swaync \
  thunar \
  python-pywal \
  imagemagick \
  jq

# -----------------------------
# 2. Install yay (AUR helper)
# -----------------------------
if ! command -v yay &>/dev/null; then
  echo "==> Installing yay"
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
fi

# -----------------------------
# 3. Install AUR packages
# -----------------------------
yay -S --needed --noconfirm \
  rofi-emoji

# -----------------------------
# 4. Install Flatpak
# -----------------------------
sudo pacman -S --needed --noconfirm flatpak

if ! flatpak remote-list | grep -q flathub; then
  echo "==> Adding Flathub"
  sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# -----------------------------
# 5. Copy dotfiles
# -----------------------------
echo "==> Copying configs"

mkdir -p ~/.config
cp -r .config/* ~/.config/

# -----------------------------
# 6. Install wallpapers (test set)
# -----------------------------
echo "==> Installing wallpapers"

mkdir -p ~/Pictures/Wallpapers
cp -r Wallpapers/* ~/Pictures/Wallpapers/

# -----------------------------
# 7. Set executable permissions
# -----------------------------
chmod +x ~/.config/hypr/scripts/*.sh 2>/dev/null || true

# -----------------------------
# 8. Initialize wallpaper + pywal
# -----------------------------
FIRST_WALLPAPER=$(ls ~/Pictures/Wallpapers | head -n 1)

if [ -n "$FIRST_WALLPAPER" ]; then
  swww img "$HOME/Pictures/Wallpapers/$FIRST_WALLPAPER" \
    --transition-type grow \
    --transition-duration 0.6
  wal -i "$HOME/Pictures/Wallpapers/$FIRST_WALLPAPER" -n
fi

# -----------------------------
# 9. Reload services
# -----------------------------
pkill waybar || true
waybar &

echo "==> Install complete. Reload Hyprland if needed."


