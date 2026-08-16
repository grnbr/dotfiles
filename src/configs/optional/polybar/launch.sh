#!/usr/bin/env bash
[ -f "$HOME/.config/.bspwm_displays" ] && . "$HOME/.config/.bspwm_displays"

killall -q polybar

while pgrep -x polybar >/dev/null; do
  sleep 0.1
done

is_connected() {
  xrandr -q | grep -q "^$1 connected"
}

echo "---" | tee -a /tmp/left.log /tmp/center.log /tmp/right.log >/dev/null

[ -n "$DISPLAY_LEFT" ] && is_connected "$DISPLAY_LEFT" && polybar left 2>&1 | tee -a /tmp/left.log &
[ -n "$DISPLAY_CENTER" ] && is_connected "$DISPLAY_CENTER" && polybar center 2>&1 | tee -a /tmp/center.log &
[ -n "$DISPLAY_RIGHT" ] && is_connected "$DISPLAY_RIGHT" && polybar right 2>&1 | tee -a /tmp/right.log &

disown
echo "Bars launched..."
