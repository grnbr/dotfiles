#!/bin/bash
set -e

# Deno is using for yt-dlp
setup_deno() {

  echo "Installing deno"

  if command -v deno >/dev/null 2>&1; then
    echo "deno already installed, skipping"
  else
    curl -fsSL https://deno.land/install.sh | sh
  fi

}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_deno
fi
