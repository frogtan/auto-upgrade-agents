#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${AUTO_UPGRADE_AGENTS_REPO:-https://github.com/frogtan/auto-upgrade-agents.git}"
REF="${AUTO_UPGRADE_AGENTS_REF:-main}"
WORK_DIR="$(mktemp -d "${TMPDIR:-/tmp}/auto-upgrade-agents.XXXXXX")"

cleanup() {
  rm -rf "$WORK_DIR"
}

trap cleanup EXIT

echo "Installing auto-upgrade-agents"
echo "Repository: $REPO_URL"
echo "Ref:        $REF"
echo "Work dir:   $WORK_DIR"
echo

if ! command -v git >/dev/null 2>&1; then
  echo "Missing git. Install git before running this installer." >&2
  exit 1
fi

git clone --depth 1 --branch "$REF" "$REPO_URL" "$WORK_DIR/repo" 2>/dev/null || {
  echo "Could not clone ref '$REF' with --depth 1. Retrying full clone and checkout..." >&2
  git clone "$REPO_URL" "$WORK_DIR/repo"
  git -C "$WORK_DIR/repo" checkout "$REF"
}

"$WORK_DIR/repo/scripts/install.sh"
echo
"$WORK_DIR/repo/scripts/check-install.sh"
