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

For multi-agent support, install promoted skills at user scope for each target agent. `auto-upgrade-agents` currently targets:

- Codex
- Cursor
- Claude Code

## Remote Installer

`scripts/install-remote.sh` is intended for explicit user execution, such as:

```bash
curl -fsSL https://raw.githubusercontent.com/frogtan/auto-upgrade-agents/main/scripts/install-remote.sh | bash
```

It clones the repository into a temporary directory, checks out `AUTO_UPGRADE_AGENTS_REF` when provided, runs `scripts/install.sh`, then runs `scripts/check-install.sh`.

Skill package managers should not auto-run this script. It exists as a convenient command for users who intentionally want full multi-agent setup.

## Bootstrap From The Skill

The `capture-project-lessons` skill includes:

```text
skills/capture-project-lessons/scripts/bootstrap_agent_instructions.sh
```

Use it to make future loading more seamless:

```bash
bash skills/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope user
bash skills/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope project --root /path/to/repo
bash skills/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope all --root /path/to/repo
```

This keeps instruction-file generation close to the skill that depends on it.

## Global Instruction Loading

User-level instructions are best treated as a bootstrap layer, not an absolute guarantee.

Install the snippet into both common global locations:

- `~/AGENTS.md`
- `~/.codex/AGENTS.md`
- `~/.cursor/AGENTS.md`
- `~/.claude/CLAUDE.md`

For repositories where the self-upgrade loop is important, also add a project-local `AGENTS.md` based on `templates/project-AGENTS.md`. Project-local instructions are easier to verify because they live in the same working tree as the task.

## Promotion Rule

Promote a lesson into a skill when future agents need executable guidance rather than a reminder. A good promoted skill tells the next agent:

- when to use it
- what to inspect first
- what steps to follow
- what resources or scripts exist
- how to validate the result

Keep a short pointer in the lesson file after promotion so the lesson index remains useful.
