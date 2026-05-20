#!/usr/bin/env bash
set -euo pipefail

CODEX_HOME_DIR="${CODEX_HOME:-"$HOME/.codex"}"
CURSOR_HOME_DIR="${CURSOR_HOME:-"$HOME/.cursor"}"
CLAUDE_HOME_DIR="${CLAUDE_HOME:-"$HOME/.claude"}"
SKILL_NAME="capture-project-lessons"
MARKER_USER="auto-upgrade-agents:user:start"
MARKER_LEGACY="auto-upgrade-agents:start"

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

  if [ -f "$path" ] && { grep -Fq "$MARKER_USER" "$path" || grep -Fq "$MARKER_LEGACY" "$path"; }; then
    echo "ok: $label contains auto-upgrade-agents snippet"
  else
    echo "missing: $label does not contain auto-upgrade-agents snippet"
  fi
}

check_skill_dir() {
  local label="$1"
  local path="$2"

  if [ -f "$path/$SKILL_NAME/SKILL.md" ]; then
    echo "ok: $label skill -> $path/$SKILL_NAME/SKILL.md"
  else
    echo "missing: $label skill -> $path/$SKILL_NAME/SKILL.md"
  fi
}

check_skill_dir "codex" "$CODEX_HOME_DIR/skills"
check_skill_dir "cursor" "$CURSOR_HOME_DIR/skills"
check_skill_dir "claude-code" "$CLAUDE_HOME_DIR/skills"
check_file "user lessons" "$HOME/LESSONS.md"
check_marker "home AGENTS" "$HOME/AGENTS.md"
check_marker "codex AGENTS" "$CODEX_HOME_DIR/AGENTS.md"
check_marker "cursor AGENTS" "$CURSOR_HOME_DIR/AGENTS.md"
check_marker "claude-code CLAUDE" "$CLAUDE_HOME_DIR/CLAUDE.md"
