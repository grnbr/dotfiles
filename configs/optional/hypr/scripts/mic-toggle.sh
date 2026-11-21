#!/usr/bin/env bash

main() {
  toggle_mute
  notify_state
}

toggle_mute() {
  wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
}

notify_state() {
  if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED; then
    notify-send -u low -t 1500 -h string:x-dunst-stack-tag:mic "Microphone" "Muted"
  else
    notify-send -u low -t 1500 -h string:x-dunst-stack-tag:mic "Microphone" "Unmuted"
  fi
}

main
