# Workflow

`capture-project-lessons` acts as a knowledge router for Codex work.

## Decision Levels

1. Do not capture
   - one-off logs
   - incidental failures
   - generic programming advice
   - unverified guesses

2. Capture as a lesson
   - compact rule
   - recurring user preference
   - local setup quirk
   - non-obvious fix
   - verified debugging heuristic

3. Promote to a skill
   - multi-step workflow
   - reusable across repositories
   - depends on command order, validation, scripts, references, or templates
   - too procedural for a short note

## Scope

Use `~/LESSONS.md` for cross-project lessons.

Use a repository-local file such as `.codex/lessons.md` for project-specific notes.

Use `~/.codex/skills/<skill-name>` for promoted user-level skills.

## Promotion Rule

Promote a lesson into a skill when future agents need executable guidance rather than a reminder. A good promoted skill tells the next agent:

- when to use it
- what to inspect first
- what steps to follow
- what resources or scripts exist
- how to validate the result

Keep a short pointer in the lesson file after promotion so the lesson index remains useful.
