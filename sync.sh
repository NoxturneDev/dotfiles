#!/bin/bash

# Define where your dotfiles live
DOTS="arch"

# List the folders you want to backup
TARGETS=("hypr" "waybar" "kitty" "wal" "wofi" "btop" "wallpapers" "gtk-3.0")

for item in "${TARGETS[@]}"; do
  if [ -d "~/.config/$item" ]; then
    mv ~/.config/$item ~/dotfiles/arch/
    ln -s ~/dotfiles/arch/$item ~/.config/$item
    echo "Linked $item"
  fi
done

echo "Done! All configs backed up to $DOTS."
