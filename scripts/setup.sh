#!/usr/bin/env bash
set -euo pipefail

phase="${1:-}"
case "$phase" in
  bootstrap|worktree) ;;
  *) echo "Usage: scripts/setup.sh <bootstrap|worktree>" >&2; exit 2 ;;
esac

: "${HARNESS_PROJECT_NAME:?HARNESS_PROJECT_NAME is required}"
: "${HARNESS_ROOT:?HARNESS_ROOT is required}"
printf 'setup: %s (%s)\n' "$HARNESS_PROJECT_NAME" "$phase"
