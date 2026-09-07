#!/usr/bin/env bash

DEST="io.github.focustimerhq.FocusTimer"
PATH_="/io/github/focustimerhq/FocusTimer"

is_running=$(gdbus call --session --dest "$DEST" --object-path "$PATH_" \
  --method io.github.focustimerhq.FocusTimer.Timer.IsRunning |
  grep -oE '(true|false)')

is_started=$(gdbus call --session --dest "$DEST" --object-path "$PATH_" \
  --method io.github.focustimerhq.FocusTimer.Timer.IsStarted |
  grep -oE '(true|false)')

if [ "$is_running" = "true" ]; then
  gdbus call --session --dest "$DEST" --object-path "$PATH_" \
    --method io.github.focustimerhq.FocusTimer.Timer.Pause
elif [ "$is_started" = "true" ]; then
  gdbus call --session --dest "$DEST" --object-path "$PATH_" \
    --method io.github.focustimerhq.FocusTimer.Timer.Resume
else
  gdbus call --session --dest "$DEST" --object-path "$PATH_" \
    --method io.github.focustimerhq.FocusTimer.Timer.Start
fi
