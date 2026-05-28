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

