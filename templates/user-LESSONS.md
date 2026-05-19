# User Lessons

Reusable cross-project lessons for Codex-style agent work.

## 2026-05-18 - Use worktrees as virtual workspaces

- Context: Multiple Codex sessions may need to work in the same repository at the same time.
- Lesson: Treat each `git worktree` as an isolated virtual workspace: one task, one branch, one filesystem checkout, then merge through Git instead of sharing one dirty working tree.
- Apply when: Parallel Codex sessions need to edit, build, or test independently without overwriting each other's files.

## 2026-05-19 - Promote complex lessons into skills

- Context: Some Codex learnings are too procedural for a short lesson note.
- Lesson: Use `$capture-project-lessons` as a knowledge router: small durable rules go into lesson files, while complex reusable workflows should create or update a Codex skill with procedural instructions and validation.
- Apply when: A repeated workflow needs ordering, commands, resources, scripts, templates, or enough nuance that future agents need executable guidance rather than a short note.
