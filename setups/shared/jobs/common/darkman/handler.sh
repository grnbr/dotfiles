#!/usr/bin/env bash

LOG_FILE="${XDG_STATE_HOME:-$HOME/.local/state}/darkman-handler.log"
mkdir -p "$(dirname "$LOG_FILE")"

log() { printf '%s [%s] %s\n' "$(date '+%F %T')" "${MODE:-?}" "$*" >>"$LOG_FILE"; }

# Log any command that fails, with line number
trap 'log "ERROR: line $LINENO: \"$BASH_COMMAND\" exited with $?"' ERR
set -o errtrace

# Keep the log from growing forever
if [[ -f "$LOG_FILE" ]] && (($(stat -c %s "$LOG_FILE") > 100000)); then
  tail -n 200 "$LOG_FILE" >"$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
fi

MODE="${1:-}"

if [[ -n "${XDG_RUNTIME_DIR:-}" && -d "$XDG_RUNTIME_DIR/hypr" ]]; then
  HYPRLAND_INSTANCE_SIGNATURE="$(ls -t "$XDG_RUNTIME_DIR/hypr" | head -n1)"
  export HYPRLAND_INSTANCE_SIGNATURE
  export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
fi

# Run a command, log its output and exit code
run() {
  local out rc
  out="$("$@" 2>&1)"
  rc=$?
  if ((rc != 0)); then
    log "FAIL rc=$rc: $* | $out"
  elif [[ -n "$out" ]]; then
    log "OK: $* | $out"
  else
    log "OK: $*"
  fi
  return $rc
}

find_wallpaper() {
  local base="$1" ext
  for ext in jpg jpeg png; do
    if [[ -f "$base.$ext" ]]; then
      echo "$base.$ext"
      return 0
    fi
  done
  return 1
}

set_wallpaper() {
  local wallpaper="$1"

  if [[ -z "$wallpaper" ]]; then
    log "set_wallpaper: no wallpaper file found"
    return 1
  fi

  if [[ ! -f "$wallpaper" ]]; then
    log "set_wallpaper: file not found: $wallpaper"
    return 1
  fi

  if [[ -n "${WAYLAND_DISPLAY:-}" ]]; then
    if pgrep -x hyprpaper >/dev/null 2>&1; then
      local monitor_name
      while read -r monitor_name; do
        run hyprctl hyprpaper wallpaper "$monitor_name,$wallpaper"
      done < <(hyprctl monitors | awk '/^Monitor/ {print $2}')
      log "active: $(hyprctl hyprpaper listactive 2>&1)"
      # run hyprctl hyprpaper wallpaper ",$wallpaper"
    else
      log "set_wallpaper: hyprpaper is not running"
      return 1
    fi
  elif [[ -n "${DISPLAY:-}" ]]; then
    run feh --bg-fill "$wallpaper"
  else
    log "set_wallpaper: no WAYLAND_DISPLAY or DISPLAY"
    return 1
  fi
}

apply_theme() {
  local gtk_theme="$1" scheme="$2" wallpaper_name="$3" wallpaper
  local wallpaper_dir="$HOME/Pictures/Wallpapers"
  [[ -d "/usr/share/themes/$gtk_theme" ]] &&
    run gsettings set org.gnome.desktop.interface gtk-theme "$gtk_theme"
  run gsettings set org.gnome.desktop.interface color-scheme "$scheme"

  if wallpaper="$(find_wallpaper "$wallpaper_dir/$wallpaper_name")"; then
    set_wallpaper "$wallpaper"
  else
    log "no $wallpaper_name.{jpg,jpeg,png} in $wallpaper_dir"
    return 1
  fi
}

main() {
  log "start mode=$MODE"
  local rc=0

  case "$MODE" in
  dark) apply_theme adw-gtk3-dark prefer-dark dark || rc=1 ;;
  light) apply_theme adw-gtk3 prefer-light light || rc=1 ;;
  *)
    log "unknown mode: '$MODE'"
    exit 2
    ;;
  esac

  log "done rc=$rc"
  return $rc
}

main
exit $?
