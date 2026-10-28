for f in "$HOME/dotfiles/src/shell/modules/functions"/*.zsh(.N); do
  source "$f"
done

t() {
    dict "$@" | less -N -S
}

lst() {
    local dir="${1:-.}"
    local lines="${2:-10}"
    ls -lhtA "$dir" | head -n "$lines"
}

clc() { echo "$*" | bc -l; }

pwdc() {
  if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        pwd | wl-copy
    else
        pwd | xclip -selection clipboard
    fi
}

thu() {
    thunar "${1:-.}" &!
}

cutvid() {
  if [[ $# -lt 3 ]]; then
    echo "usage: cutvid <input> <start> <end> [output]" >&2
    return 1
  fi

  local in="$1" start="$2" end="$3" out="$4"

  if [[ -z "$out" ]]; then
    local base="${in%.*}_cut" ext="${in##*.}"
    out="$base.$ext"
    local n=1
    while [[ -e "$out" ]]; do
      out="$base($n).$ext"
      ((n++))
    done
  fi

  ffmpeg -n -i "$in" -ss "$start" -to "$end" \
    -map 0:v -map "0:a?" \
    -c:v libx264 -crf 18 -preset fast \
    -c:a copy "$out"
}
