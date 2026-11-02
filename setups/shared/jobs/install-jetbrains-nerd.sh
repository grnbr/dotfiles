#!/bin/bash
set -e

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNerd"

if [ -d "$FONT_DIR" ]; then
  echo "JetBrainsMono Nerd Font already installed, skipping"
else
  mkdir -p "$HOME/.local/share/fonts"
  cd "$HOME/.local/share/fonts"
  curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsMonoNerd
  rm JetBrainsMono.zip
  fc-cache -fv
fi
