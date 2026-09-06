#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Symlinking macOS dotfiles..."

# Shell & Multiplexer
ln -sf "$DIR/.zshrc" "$HOME/.zshrc"
ln -sf "$DIR/.tmux.conf" "$HOME/.tmux.conf"

# Window & Space Management
ln -sf "$DIR/.yabairc" "$HOME/.yabairc"
ln -sf "$DIR/.skhdrc" "$HOME/.skhdrc"
ln -sf "$DIR/.aerospace.toml" "$HOME/.aerospace.toml"

# App & Local Bin Configs
mkdir -p "$HOME/.config/ghostty" "$HOME/.config/herdr" "$HOME/.local/bin"
ln -sfn "$DIR/nvim" "$HOME/.config/nvim"
ln -sf "$DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DIR/.config/herdr/config.toml" "$HOME/.config/herdr/config.toml"
ln -sf "$DIR/.local/bin/switch-space" "$HOME/.local/bin/switch-space"
ln -sf "$DIR/.local/bin/toggle-maximize" "$HOME/.local/bin/toggle-maximize"
chmod +x "$DIR/setup.sh" "$HOME/.local/bin/switch-space" "$HOME/.local/bin/toggle-maximize" "$HOME/.yabairc"

echo "==> macOS dotfiles linked successfully!"
