#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-"$HOME/.codex"}"
CODEX_SKILLS_DIR="$CODEX_HOME_DIR/skills"
SKILL_NAME="capture-project-lessons"
SNIPPET_FILE="$ROOT_DIR/templates/user-AGENTS-snippet.md"
SNIPPET_BEGIN="<!-- auto-upgrade-agents:start -->"
SNIPPET_END="<!-- auto-upgrade-agents:end -->"

install_agents_snippet() {
  local target="$1"

  mkdir -p "$(dirname "$target")"
  touch "$target"

  if grep -Fq "$SNIPPET_BEGIN" "$target"; then
    echo "AGENTS snippet already present in $target"
    return
  fi

  {
    printf '\n%s\n' "$SNIPPET_BEGIN"
    cat "$SNIPPET_FILE"
    printf '%s\n' "$SNIPPET_END"
  } >> "$target"

  echo "Added AGENTS snippet to $target"
}

mkdir -p "$CODEX_SKILLS_DIR"
rm -rf "$CODEX_SKILLS_DIR/$SKILL_NAME"
cp -R "$ROOT_DIR/skills/$SKILL_NAME" "$CODEX_SKILLS_DIR/$SKILL_NAME"

if [ ! -f "$HOME/LESSONS.md" ]; then
  cp "$ROOT_DIR/templates/user-LESSONS.md" "$HOME/LESSONS.md"
fi

install_agents_snippet "$HOME/AGENTS.md"
install_agents_snippet "$CODEX_HOME_DIR/AGENTS.md"

echo "Installed $SKILL_NAME to $CODEX_SKILLS_DIR/$SKILL_NAME"
echo
echo "Installed user-level lesson support. Run ./scripts/check-install.sh to inspect installation."
