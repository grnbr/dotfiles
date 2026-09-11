#!/bin/bash
set -e

run_jobs() {
  local ROOT_DIR_LOCAL="${ROOT_DIR:-}"

  if [[ -z "$ROOT_DIR_LOCAL" ]]; then
    local CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    ROOT_DIR_LOCAL="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel)"
  fi

  local SHARED_ARCH_JOBS_DIR="$ROOT_DIR_LOCAL/src/setups/arch/shared/jobs"
  local SHARED_JOBS_DIR_LOCAL="${SHARED_JOBS_DIR:-$ROOT_DIR_LOCAL/src/setups/shared/jobs}"

  for job in "$SHARED_JOBS_DIR_LOCAL/common"/*.sh; do
    [ -e "$job" ] || continue
    echo "=> Running $job"
    bash "$job"
  done

  for job in "$SHARED_JOBS_DIR_LOCAL/common/for-clean-systems"/*.sh; do
    [ -e "$job" ] || continue
    echo "=> Running $job"
    bash "$job"
  done

  for job in "$SHARED_ARCH_JOBS_DIR/common"/*.sh; do
    [ -e "$job" ] || continue
    echo "=> Running $job"
    bash "$job"
  done

  for job in "$SHARED_ARCH_JOBS_DIR/common/for-clean-systems"/*.sh; do
    [ -e "$job" ] || continue
    echo "=> Running $job"
    bash "$job"
  done
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
  run_jobs
fi
