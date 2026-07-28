#!/bin/bash
set -e

# Deno is using for yt-dlp

echo "Installing deno"

if command -v deno >/dev/null 2>&1; then
  echo "deno already installed, skipping"
else
  curl -fsSL https://deno.land/install.sh | sh
fi
