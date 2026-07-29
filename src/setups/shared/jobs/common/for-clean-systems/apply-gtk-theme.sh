#!/bin/bash
set -e

apply_gtk_theme() {
  if ! command -v gsettings >/dev/null 2>&1; then
    warn "gsettings not found, skipping GTK theme setup"
    return 0
  fi
  if ! gsettings list-schemas | grep -q "^org.gnome.desktop.interface$"; then
    warn "org.gnome.desktop.interface schema not found (gsettings-desktop-schemas missing?), skipping"
    return 0
  fi
  gsettings set org.gnome.desktop.interface gtk-theme "Adwaita"
  gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
  gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"
}
apply_gtk_theme
