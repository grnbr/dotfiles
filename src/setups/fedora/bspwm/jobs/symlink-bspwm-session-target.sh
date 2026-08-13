#!/bin/bash
set -e

mkdir -p ~/.config/systemd/user

ln -sfn \
  ~/dotfiles/src/configs/systemd/optional/user/bspwm-session.target \
  ~/.config/systemd/user/bspwm-session.target

systemctl --user daemon-reload
