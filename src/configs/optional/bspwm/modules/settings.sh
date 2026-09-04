#!/bin/bash

# Cursor
xrdb -merge <<<"Xcursor.theme: Adwaita
Xcursor.size: 24"
export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=24
xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 24

# Borders
bspc config window_gap 8
bspc config normal_border_color "#343f44"   # unfocused windows (matches client.unfocused)
bspc config active_border_color "#475258"   # focused monitor, but not the focused node (matches client.focused_inactive)
bspc config focused_border_color "#83c092"  # the actually focused window (matches client.focused)
bspc config urgent_border_color "#e67e80"   # urgent window (matches client.urgent)
bspc config presel_feedback_color "#a7c080" # preselection split preview (closest match: your focused indicator color)
bspc config border_width 5

bspc config split_ratio 0.52
# bspc config borderless_monocle true
bspc config gapless_monocle true
bspc config initial_polarity first_child

bspc config pointer_modifier super
bspc config pointer_action1 move
bspc config pointer_action2 resize_side
bspc config pointer_action3 resize_corner

# bspc config focus_follows_pointer true
bspc config pointer_follows_focus true
# bspc config pointer_follows_monitor true

bspc config remove_disabled_monitors true
bspc config remove_unplugged_monitors true

bspc desktop 'I' -l monocle
bspc desktop 'X' -l monocle
# bspc config external_rules_command ${HOME}/dotfiles/src/configs/optional/bspwm/modules/external_rules.sh

local_settings="$HOME/.config/.bspwm_settings"
[[ -f "$local_settings" ]] && . "$local_settings"
