#!/bin/bash
set -e

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(git -C "$CURRENT_DIR" rev-parse --show-toplevel 2>/dev/null)" || {
  echo "ERROR: not inside a git repo"
  exit 1
}
SHARED_JOBS_DIR="$ROOT_DIR/src/setups/shared/jobs"
SHARED_FEDORA_JOBS_DIR="$ROOT_DIR/src/setups/fedora/shared/jobs"

for job in "$SHARED_JOBS_DIR/common"/*.sh; do
  [ -e "$job" ] || continue
  echo "=> Running $job"
  bash "$job"
done

for job in "$SHARED_JOBS_DIR/common/for-clean-systems"/*.sh; do
  [ -e "$job" ] || continue
  echo "=> Running $job"
  bash "$job"
done

for job in "$SHARED_FEDORA_JOBS_DIR/common"/*.sh; do
  [ -e "$job" ] || continue
  echo "=> Running $job"
  bash "$job"
done

for job in "$SHARED_FEDORA_JOBS_DIR/common/for-clean-systems"/*.sh; do
  [ -e "$job" ] || continue
  echo "=> Running $job"
  bash "$job"
done
