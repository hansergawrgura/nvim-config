#!/usr/bin/env bash
# bootstrap.sh - One-shot setup for a new machine.
# Clones the repo and runs setup.sh.
#
# Usage: bash bootstrap.sh [clone_dir]
#   clone_dir defaults to ~/01-Repo/00-Config/nvim.config

set -euo pipefail

REPO_URL="https://github.com/hansergawrgura/nvim-config.git"
CLONE_DIR="${1:-$HOME/01-Repo/00-Config/nvim.config}"

echo "==> Cloning to: $CLONE_DIR"

if [ -d "$CLONE_DIR/.git" ]; then
  echo "==> Repo already exists. Pulling latest..."
  git -C "$CLONE_DIR" pull --ff-only
else
  mkdir -p "$(dirname "$CLONE_DIR")"
  git clone "$REPO_URL" "$CLONE_DIR"
fi

echo "==> Running setup.sh..."
bash "$CLONE_DIR/setup.sh"

echo "==> Bootstrap complete. Open nvim to verify."
