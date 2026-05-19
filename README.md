# Auto Upgrade Agents

Reusable workflows for helping Codex-style agents improve themselves over time.

The project starts with one core skill:

- `capture-project-lessons`: routes reusable knowledge into the right artifact:
  - no capture for one-off noise
  - a lesson note for compact reusable knowledge
  - a new or updated skill for complex repeatable workflows

## Why

Agent work often produces useful discoveries: setup quirks, debugging paths, user preferences, and repeatable workflows. If those stay only in chat history, future sessions repeat the same work.

This repo makes that learning loop explicit:

```text
work happens -> reusable knowledge appears -> capture-project-lessons decides:
  ignore | write lesson | promote to skill
```

## Layout

```text
skills/
  capture-project-lessons/
    SKILL.md
    agents/openai.yaml
templates/
  user-AGENTS-snippet.md
  user-LESSONS.md
  project-AGENTS.md
scripts/
  install.sh
  publish.sh
docs/
  publishing.md
  workflow.md
```

## Install

From the repository root:

```bash
./scripts/install.sh
```

The installer:

- installs `skills/capture-project-lessons` for Codex, Cursor, and Claude Code at user scope
- creates `~/LESSONS.md` if missing
- appends the user-level instruction snippet to `~/AGENTS.md`, `~/.codex/AGENTS.md`, `~/.cursor/AGENTS.md`, and `~/.claude/CLAUDE.md`

The multiple instruction locations are intentional. Different agent surfaces and versions discover user-level instructions differently, so installation writes common locations with an idempotent marker block.

Check the installation:

```bash
./scripts/check-install.sh
```

## Manual Setup

Copy the skill:

```bash
mkdir -p ~/.codex/skills
cp -R skills/capture-project-lessons ~/.codex/skills/
mkdir -p ~/.cursor/skills
cp -R skills/capture-project-lessons ~/.cursor/skills/
mkdir -p ~/.claude/skills
cp -R skills/capture-project-lessons ~/.claude/skills/
```

Add the contents of `templates/user-AGENTS-snippet.md` to your global instruction files:

```bash
cat templates/user-AGENTS-snippet.md >> ~/AGENTS.md
mkdir -p ~/.codex
cat templates/user-AGENTS-snippet.md >> ~/.codex/AGENTS.md
mkdir -p ~/.cursor
cat templates/user-AGENTS-snippet.md >> ~/.cursor/AGENTS.md
mkdir -p ~/.claude
cat templates/user-AGENTS-snippet.md >> ~/.claude/CLAUDE.md
```

Create a user-level lesson file if needed:

```bash
cp templates/user-LESSONS.md ~/LESSONS.md
```

## Usage

At the end of non-trivial work, use:

```text
Capture Project Lessons
```

The skill should decide whether to store a short lesson or promote the knowledge into a full skill.

## Global Availability

There is no repository-local way to prove that every Codex surface will always load a user-level `AGENTS.md`. The robust pattern is:

1. Install the skill into user-scope skill directories for each target agent.
2. Install the user-level snippet into common instruction files for Codex, Cursor, and Claude Code.
3. Keep a project-local `AGENTS.md` in important repositories when you need stronger guarantees.
4. In a new session, ask Codex to confirm whether it sees the user-level lesson rule when validating setup.

This repo's installer covers steps 1 and 2 for Codex, Cursor, and Claude Code. Use `templates/project-AGENTS.md` for step 3.

## Publishing

This repository is structured as a skills repository. See `docs/publishing.md` for release steps.

Validate without publishing:

```bash
./scripts/publish.sh
```

If your GitHub CLI does not include the `gh skill` preview command yet, the script will stop with an upgrade message.

Publish a release:

```bash
./scripts/publish.sh v0.1.0
```
