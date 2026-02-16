#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_DIR="$HOME/.config"

echo "==> Installing dotfiles from $DOTFILES_DIR"

# -----------------------------
# 1. Packages (minimal, needed)
# -----------------------------
echo "==> Installing required packages"

sudo pacman -S --needed --noconfirm \
  hyprland waybar rofi kitty swaync \
  grim slurp wl-clipboard cliphist \
  swww libnotify \
  thunar \
  nwg-look adw-gtk-theme \
  ttf-jetbrains-mono-nerd

# -----------------------------
# 2. Create config dir
# -----------------------------
mkdir -p "$CONFIG_DIR"

# -----------------------------
# 3. Backup existing configs
# -----------------------------
backup() {
  local target="$1"
  if [ -e "$CONFIG_DIR/$target" ] && [ ! -L "$CONFIG_DIR/$target" ]; then
    echo "Backing up $target → $target.bak"
    mv "$CONFIG_DIR/$target" "$CONFIG_DIR/$target.bak"
  fi
}

for dir in hypr waybar rofi kitty swaync scripts; do
  backup "$dir"
done

# -----------------------------
# 4. Symlink configs
# -----------------------------
echo "==> Symlinking configs"

for dir in hypr waybar rofi kitty swaync scripts; do
  ln -snf "$DOTFILES_DIR/.config/$dir" "$CONFIG_DIR/$dir"
done

# -----------------------------
# 5. Clipboard daemon (Hyprland)
# -----------------------------
echo "==> Ensuring clipboard history autostart"

HYPR_CONF="$CONFIG_DIR/hypr/hyprland.conf"

grep -q cliphist "$HYPR_CONF" || cat >>"$HYPR_CONF" <<'EOF'

# Clipboard history
exec-once = wl-paste --type text --watch cliphist store
exec-once = wl-paste --type image --watch cliphist store
EOF

# -----------------------------
# 6. Permissions
# -----------------------------
chmod +x "$CONFIG_DIR/scripts"/*.sh 2>/dev/null || true

# -----------------------------
# 7. Final notes
# -----------------------------
echo
echo "==> Install complete."
echo "==> Log out and log back in for everything to apply."
