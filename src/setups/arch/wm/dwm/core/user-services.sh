#!/bin/bash
set -e

user_services() {
  local action="$1"

  # local extra_systemd=(
  # )
  #
  # apply_systemd user "${extra_systemd[@]}"

  local services=(
  )

  case "$action" in
  install)

    echo "Enabling user services..."
    for service in "${services[@]}"; do
      if systemctl --user list-unit-files | grep -q "^${service}"; then
        if ! systemctl --user is-enabled --quiet "$service" 2>/dev/null; then
          if systemctl --user enable --now "$service"; then
            echo "Enabled: $service"
          else
            echo "WARNING: $service failed to start — check config"
          fi
        else
          echo "$service already enabled, skipping."
        fi
      else
        echo "WARNING: $service unit not found, skipping."
      fi
    done
    ;;

  uninstall)
    echo "Disabling user services..."
    for service in "${services[@]}"; do
      if systemctl --user list-unit-files | grep -q "^${service}"; then
        if systemctl --user is-enabled --quiet "$service" 2>/dev/null; then
          systemctl --user disable --now "$service" ||
            echo "WARNING: failed to disable $service"
          echo "Disabled: $service"
        else
          echo "$service already disabled, skipping."
        fi
      else
        echo "WARNING: $service unit not found, skipping."
      fi
    done
    ;;

  *)
    echo "Usage: $FUNCNAME {install|uninstall}"
    return 1
    ;;
  esac
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  user_services "$1"
fi
