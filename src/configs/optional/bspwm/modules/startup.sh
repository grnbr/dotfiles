#!/bin/bash

pkill -x sxhkd
pkill -x picom
pkill -x xfce-polkit

picom --backend glx &
sxhkd &
~/dotfiles/src/configs/optional/polybar/launch.sh &
/usr/libexec/xfce-polkit &
xset r rate 200 35 &
setxkbmap -layout us,ru -option grp:win_space_toggle &

touch /tmp/bspwm_startup_marker

expected_classes=(kitty discord TelegramDesktop)
j
pgrep -x kitty >/dev/null || kitty &
pgrep -f "com.discordapp.Discord" >/dev/null || flatpak run com.discordapp.Discord --start-minimized &
pgrep -f "org.telegram.desktop" >/dev/null || flatpak run org.telegram.desktop --start-minimized &
