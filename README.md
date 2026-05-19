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
docs/
  workflow.md
```

## Install

From the repository root:

```bash
./scripts/install.sh
```

The installer copies `skills/capture-project-lessons` into `~/.codex/skills/`, creates `~/LESSONS.md` if missing, and prints the global `AGENTS.md` snippet to add to your user-level agent instructions.

## Manual Setup

Copy the skill:

```bash
mkdir -p ~/.codex/skills
cp -R skills/capture-project-lessons ~/.codex/skills/
```

Add the contents of `templates/user-AGENTS-snippet.md` to your global `AGENTS.md`.

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
