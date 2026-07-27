#!/bin/bash

# Install Oh My Zsh (unattended so script continues)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

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
ln -sf "$ROOT_DIR/src/shell/zshrc" ~/.zshrc
