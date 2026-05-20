#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CODEX_HOME_DIR="${CODEX_HOME:-"$HOME/.codex"}"
CURSOR_HOME_DIR="${CURSOR_HOME:-"$HOME/.cursor"}"
CLAUDE_HOME_DIR="${CLAUDE_HOME:-"$HOME/.claude"}"
SKILL_NAME="capture-project-lessons"
TARGET_AGENTS=("codex" "cursor" "claude-code")

copy_skill_to_dir() {
  local target_dir="$1"

  mkdir -p "$target_dir"
  rm -rf "$target_dir/$SKILL_NAME"
  cp -R "$ROOT_DIR/skills/$SKILL_NAME" "$target_dir/$SKILL_NAME"
  echo "Installed $SKILL_NAME to $target_dir/$SKILL_NAME"
}

install_skills() {
  if command -v gh >/dev/null 2>&1 && gh skill --help >/dev/null 2>&1; then
    for agent in "${TARGET_AGENTS[@]}"; do
      gh skill install "$ROOT_DIR" "$SKILL_NAME" --from-local --agent "$agent" --scope user --force
    done
    return
  fi

  echo "gh skill is unavailable; falling back to common user skill directories."
  copy_skill_to_dir "$CODEX_HOME_DIR/skills"
  copy_skill_to_dir "$CURSOR_HOME_DIR/skills"
  copy_skill_to_dir "$CLAUDE_HOME_DIR/skills"
}

install_skills

bash "$ROOT_DIR/skills/$SKILL_NAME/scripts/bootstrap_agent_instructions.sh" --scope user

echo "Installed user-level lesson support. Run ./scripts/check-install.sh to inspect installation."
