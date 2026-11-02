#!/bin/bash
MUSIC_DIR=~/music
PLAYLIST_DIR=~/.config/mpd/playlists

generate() {
  rm -rf "$PLAYLIST_DIR"/*
  find -L "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | while read root; do
    root_name=$(basename "$root")
    find -L "$root" -type d | while read dir; do
      files=$(find -L "$dir" -maxdepth 1 -type f \( \
        -name "*.mp3" -o -name "*.flac" -o -name "*.ogg" \
        -o -name "*.m4a" -o -name "*.webm" \))
      if [ -n "$files" ]; then
        rel="${dir#$root/}"
        if [ -z "$rel" ]; then
          playlist_name="$root_name"
        else
          playlist_name="$root_name-$(echo "$rel" | tr '/' '-')"
        fi
        echo "$files" >"$PLAYLIST_DIR/$playlist_name.m3u"
      fi
    done
  done
  mpc update
}

generate
inotifywait -m -r -e create,delete,move "$MUSIC_DIR" | while read line; do
  echo "EVENT: $line"
  generate
done
