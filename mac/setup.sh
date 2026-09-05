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
mkdir -p "$HOME/.config/ghostty" "$HOME/.local/bin"
ln -sf "$DIR/.config/ghostty/config" "$HOME/.config/ghostty/config"
ln -sf "$DIR/.local/bin/switch-space" "$HOME/.local/bin/switch-space"
chmod +x "$DIR/setup.sh" "$HOME/.local/bin/switch-space" "$HOME/.yabairc"

echo "==> macOS dotfiles linked successfully!"
