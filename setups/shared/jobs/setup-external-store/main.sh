#!/bin/bash

read -p "External store name (e.g. t7): " NAME

if [ -z "$NAME" ]; then
  echo "Error: name cannot be empty"
  exit 1
fi

# Check inotify-tools
if ! command -v inotifywait &>/dev/null; then
  echo "Error: inotify-tools is not installed"
  exit 1
fi

MOUNT="/mnt/external/$NAME"
SUDOERS="/etc/sudoers.d/$NAME-umount"

# Check if already set up
if [ -f "$SUDOERS" ]; then
  echo "Store '$NAME' already configured, skipping."
  exit 0
fi

echo "%wheel ALL=(ALL) NOPASSWD: /usr/bin/umount $MOUNT" | sudo tee "$SUDOERS"
sudo chmod 440 "$SUDOERS"

echo "External store '$NAME' setup done."
