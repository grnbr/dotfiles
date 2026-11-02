#!/bin/bash
MOUNT=/mnt/t7
IDLE_SECONDS=900 # 15 minutes

mountpoint -q "$MOUNT" || exit 0

inotifywait -r -t $IDLE_SECONDS --event access,modify,create,delete "$MOUNT" 2>/dev/null

# if we get here, timeout expired with no activity
mountpoint -q "$MOUNT" && sudo umount "$MOUNT" && notify-send "T7 Touch" "Auto-unmounted after 15 min idle"
