#!/usr/bin/env bash
# sync.sh - Pull updates from remote and sync plugins.
# Run on any machine to pull latest config changes.

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

echo "==> Pulling updates..."
git pull --ff-only

echo "==> Syncing plugins..."
if command -v nvim >/dev/null 2>&1; then
  nvim --headless "+Lazy! sync" +qa
  echo "==> Plugin sync complete."
else
  echo "WARNING: nvim not found. Skipping plugin sync." >&2
fi

echo "==> Sync complete."
