#!/bin/bash
set -e

output_result() {
  [[ -n "${LOG:-}" ]] && return 0 # already logging
  LOG="/tmp/setup-$(date +%s).log"
  exec > >(tee "$LOG") 2>&1
  echo "Logging to $LOG"
}
