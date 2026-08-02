#!/bin/bash
set -e

setup_zsh() {
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  # Install Oh My Zsh (unattended so script continues)
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  # Install plugins
  if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  fi

  if [[ ! -d ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  fi

  # Install Starship
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
    arch)
      sudo pacman -S --noconfirm starship
      ;;
    fedora)
      sudo dnf copr enable -y atim/starship
      sudo dnf install -y starship
      ;;
    debian | ubuntu)
      sudo apt install -y starship
      ;;
    *)
      echo "Unsupported distro: $ID"
      exit 1
      ;;
    esac
  fi

  # Set Zsh as default shell
  chsh -s "$(which zsh)"

  rm -f ~/.zshrc
  ln -sf "$ROOT_DIR_LOCAL/src/shell/zshrc" ~/.zshrc
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  setup_zsh
fi
