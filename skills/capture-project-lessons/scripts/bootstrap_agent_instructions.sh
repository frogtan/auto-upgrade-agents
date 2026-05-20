#!/usr/bin/env bash
set -euo pipefail

SCOPE="all"
PROJECT_ROOT="$PWD"
MARKER_USER_BEGIN="<!-- auto-upgrade-agents:user:start -->"
MARKER_USER_END="<!-- auto-upgrade-agents:user:end -->"
MARKER_PROJECT_BEGIN="<!-- auto-upgrade-agents:project:start -->"
MARKER_PROJECT_END="<!-- auto-upgrade-agents:project:end -->"

usage() {
  cat <<'USAGE'
Usage: bootstrap_agent_instructions.sh [--scope user|project|all] [--root PATH]

Ensures agent instruction files contain auto-upgrade-agents bootstrap rules.

Scopes:
  user     Update user-level instruction files and ~/LESSONS.md.
  project  Update project-level AGENTS.md and .codex/lessons.md.
  all      Do both. This is the default.
USAGE
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --scope)
      SCOPE="${2:-}"
      shift 2
      ;;
    --root)
      PROJECT_ROOT="${2:-}"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

case "$SCOPE" in
  user|project|all) ;;
  *)
    echo "--scope must be one of: user, project, all" >&2
    exit 1
    ;;
esac

append_marked_block() {
  local target="$1"
  local marker_begin="$2"
  local marker_end="$3"
  local content="$4"

  mkdir -p "$(dirname "$target")"
  touch "$target"

  if grep -Fq "$marker_begin" "$target"; then
    echo "Already present: $target"
    return
  fi

  {
    printf '\n%s\n' "$marker_begin"
    printf '%s\n' "$content"
    printf '%s\n' "$marker_end"
  } >> "$target"

  echo "Updated: $target"
}

ensure_user_lessons() {
  local target="$HOME/LESSONS.md"

  if [ -f "$target" ]; then
    echo "Already present: $target"
    return
  fi

  cat > "$target" <<'LESSONS'
# User Lessons

Reusable cross-project lessons for agent work.
LESSONS

  echo "Created: $target"
}

bootstrap_user() {
  local codex_home="${CODEX_HOME:-"$HOME/.codex"}"
  local cursor_home="${CURSOR_HOME:-"$HOME/.cursor"}"
  local claude_home="${CLAUDE_HOME:-"$HOME/.claude"}"
  local user_block

  user_block='## User-Level Lessons

Before starting work in a repository, read `~/LESSONS.md` when it exists and apply any relevant user-level lessons.

Use `$capture-project-lessons` before the final response for non-trivial work to decide whether the session produced reusable experience.

- Record cross-project or user-level lessons in `~/LESSONS.md`.
- Record project-specific lessons in the current repository lesson file, such as `.codex/lessons.md`.
- When reusable knowledge becomes a complex repeatable workflow, promote it into a new or updated skill instead of only adding a lesson note.
- Keep lessons concise, verified, and scoped. Do not record secrets, one-off logs, or generic programming advice.
- Prefer updating an existing related lesson over adding a duplicate.'

  ensure_user_lessons
  append_marked_block "$HOME/AGENTS.md" "$MARKER_USER_BEGIN" "$MARKER_USER_END" "$user_block"
  append_marked_block "$codex_home/AGENTS.md" "$MARKER_USER_BEGIN" "$MARKER_USER_END" "$user_block"
  append_marked_block "$cursor_home/AGENTS.md" "$MARKER_USER_BEGIN" "$MARKER_USER_END" "$user_block"
  append_marked_block "$claude_home/CLAUDE.md" "$MARKER_USER_BEGIN" "$MARKER_USER_END" "$user_block"
}

bootstrap_project() {
  local root="$PROJECT_ROOT"
  local lesson_file="$root/.codex/lessons.md"
  local project_block

  project_block='## Auto-Upgrade Agent Bootstrap

Before starting non-trivial work in this repository, load these lesson files when they exist:

- User-level lessons: `~/LESSONS.md`
- Project-level lessons: `.codex/lessons.md`

Use `$capture-project-lessons` before the final response to decide whether this work produced reusable experience.

- Record project-specific lessons in `.codex/lessons.md`.
- Record cross-project or user-level lessons in `~/LESSONS.md`.
- Promote complex repeatable workflows into skills instead of only adding lesson notes.
- Do not record secrets, one-off logs, or generic programming advice.'

  append_marked_block "$root/AGENTS.md" "$MARKER_PROJECT_BEGIN" "$MARKER_PROJECT_END" "$project_block"

  if [ ! -f "$lesson_file" ]; then
    mkdir -p "$(dirname "$lesson_file")"
    cat > "$lesson_file" <<'LESSONS'
# Project Lessons

Reusable project-specific lessons for this repository.
LESSONS
    echo "Created: $lesson_file"
  else
    echo "Already present: $lesson_file"
  fi
}

case "$SCOPE" in
  user)
    bootstrap_user
    ;;
  project)
    bootstrap_project
    ;;
  all)
    bootstrap_user
    bootstrap_project
    ;;
esac
