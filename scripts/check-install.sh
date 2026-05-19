#!/usr/bin/env bash
set -euo pipefail

CODEX_HOME_DIR="${CODEX_HOME:-"$HOME/.codex"}"
SKILL_PATH="$CODEX_HOME_DIR/skills/capture-project-lessons/SKILL.md"
MARKER="auto-upgrade-agents:start"

check_file() {
  local label="$1"
  local path="$2"

  if [ -f "$path" ]; then
    echo "ok: $label -> $path"
  else
    echo "missing: $label -> $path"
  fi
}

check_marker() {
  local label="$1"
  local path="$2"

  if [ -f "$path" ] && grep -Fq "$MARKER" "$path"; then
    echo "ok: $label contains auto-upgrade-agents snippet"
  else
    echo "missing: $label does not contain auto-upgrade-agents snippet"
  fi
}

check_file "skill" "$SKILL_PATH"
check_file "user lessons" "$HOME/LESSONS.md"
check_marker "home AGENTS" "$HOME/AGENTS.md"
check_marker "codex AGENTS" "$CODEX_HOME_DIR/AGENTS.md"
