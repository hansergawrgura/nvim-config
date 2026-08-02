#!/usr/bin/env bash
# setup.sh - Deploy nvim config to ~/.config/nvim via symlink (overwrite if exists).
# Run after editing config locally to install/sync.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_DIR="$HOME/.config/nvim"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"

echo "==> Repo:   $REPO_DIR"
echo "==> Target: $NVIM_DIR"

# 1. Sanity: init.lua must exist
if [ ! -f "$REPO_DIR/init.lua" ]; then
  echo "ERROR: init.lua not found in $REPO_DIR" >&2
  exit 1
fi

# 2. Handle existing ~/.config/nvim (overwrite with backup)
SKIP_LINK=0
if [ -L "$NVIM_DIR" ]; then
  CURRENT="$(readlink -f "$NVIM_DIR")"
  if [ "$CURRENT" = "$REPO_DIR" ]; then
    echo "==> Symlink already points to repo. Skipping creation."
    SKIP_LINK=1
  else
    echo "==> Existing symlink -> $CURRENT. Backing up."
    mv "$NVIM_DIR" "$NVIM_DIR.bak.$TIMESTAMP"
  fi
elif [ -e "$NVIM_DIR" ]; then
  echo "==> $NVIM_DIR is a real directory. Backing up to $NVIM_DIR.bak.$TIMESTAMP"
  mv "$NVIM_DIR" "$NVIM_DIR.bak.$TIMESTAMP"
fi

# 3. Create symlink
if [ "$SKIP_LINK" -eq 0 ]; then
  mkdir -p "$(dirname "$NVIM_DIR")"
  ln -s "$REPO_DIR" "$NVIM_DIR"
  echo "==> Created symlink: $NVIM_DIR -> $REPO_DIR"
fi

# 4. Sync plugins via lazy.nvim
echo "==> Running lazy sync..."
if command -v nvim >/dev/null 2>&1; then
  nvim --headless "+Lazy! sync" +qa
  echo "==> Plugin sync complete."
else
  echo "WARNING: nvim not found. Skipping plugin sync." >&2
fi

# 5. Check external dependencies
echo "==> Checking external dependencies..."
check_dep() {
  if command -v "$1" >/dev/null 2>&1; then
    echo "  [OK] $1"
  else
    echo "  [MISSING] $1 - $2"
  fi
}
check_dep nvim "required (>= 0.11)"
check_dep git "required by lazy.nvim"
check_dep node "required by some LSP servers"
check_dep rg "ripgrep - required by Telescope"
check_dep fd "fd - improves file finding"
echo "  [INFO] Ensure your terminal uses a Nerd Font for icon glyphs."

echo "==> Deploy complete. Open nvim to verify."
