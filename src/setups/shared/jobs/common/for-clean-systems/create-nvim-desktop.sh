#!/bin/bash
set -euo pipefail

desktop_dir="$HOME/.local/share/applications"
desktop_file="$desktop_dir/nvim.desktop"

mkdir -p "$desktop_dir"

cp /usr/share/applications/nvim.desktop "$desktop_file"

sed -i \
  -e 's|^Exec=.*|Exec=kitty nvim %F|' \
  -e 's|^Terminal=.*|Terminal=false|' \
  "$desktop_file"

update-desktop-database "$desktop_dir" 2>/dev/null || true

echo "Created $desktop_file"
echo "Markdown files will open with Kitty + Neovim."
