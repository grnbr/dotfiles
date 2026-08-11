#!/bin/bash

pkill -x sxhkd
pkill -x picom
pkill -x xfce-polkit
pkill -x xautolock
pkill -x xss-lock

picom --backend glx &
sxhkd &
~/dotfiles/src/configs/optional/polybar/launch.sh &
/usr/libexec/xfce-polkit &
xset r rate 200 35 &
setxkbmap -layout us,ru -option grp:win_space_toggle &
xss-lock --transfer-sleep-lock -- i3lock -c 1e1e1e -n &
xautolock -time 10 -locker "i3lock -c 1e1e1e" &

touch /tmp/bspwm_startup_marker

expected_classes=(kitty discord TelegramDesktop)

pgrep -x kitty >/dev/null || kitty &
pgrep -f "com.discordapp.Discord" >/dev/null || flatpak run com.discordapp.Discord --start-minimized &
pgrep -f "org.telegram.desktop" >/dev/null || flatpak run org.telegram.desktop --start-minimized &
