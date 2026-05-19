#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_SKILLS_DIR="${CODEX_HOME:-"$HOME/.codex"}/skills"
SKILL_NAME="capture-project-lessons"

mkdir -p "$CODEX_SKILLS_DIR"
rm -rf "$CODEX_SKILLS_DIR/$SKILL_NAME"
cp -R "$ROOT_DIR/skills/$SKILL_NAME" "$CODEX_SKILLS_DIR/$SKILL_NAME"

if [ ! -f "$HOME/LESSONS.md" ]; then
  cp "$ROOT_DIR/templates/user-LESSONS.md" "$HOME/LESSONS.md"
fi

echo "Installed $SKILL_NAME to $CODEX_SKILLS_DIR/$SKILL_NAME"
echo
echo "Add this snippet to your global AGENTS.md if it is not already present:"
echo
cat "$ROOT_DIR/templates/user-AGENTS-snippet.md"
