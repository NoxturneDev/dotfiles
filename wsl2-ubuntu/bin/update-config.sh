#!/bin/bash

cp ~/.zshrc ~/.config/zsh/
cp ~/.tmux.conf ~/.config/tmux/

cd ~/.config
git add .
git commit -m "$1"
git push
