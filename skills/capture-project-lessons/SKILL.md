---
name: capture-project-lessons
description: Capture reusable lessons from Codex work into the appropriate user-level or project-level memory, and promote complex reusable knowledge into a new or updated Codex skill when it deserves procedural reuse. Use when Codex encounters a recurring problem, non-obvious fix, project-specific convention, tool/setup quirk, debugging discovery, workflow improvement, multi-step process, reusable tool workflow, or completed task that may produce durable experience worth recording for future agents or teammates. Also use when the user asks to mark, remember, record, preserve, document, distill, promote, or turn lessons, learnings, project memory, experience, gotchas, reusable knowledge, or complex workflows into a skill.
license: MIT
---

# Capture Project Lessons

## Purpose

Decide whether the current work produced reusable knowledge. Store lightweight lessons in the right memory file. Promote complex, repeatable workflows into a new or updated skill so future Codex sessions can execute them, not just read about them.

## Quick Workflow

1. Review the work just done, including failures, fixes, commands, environment constraints, and user preferences.
2. Decide whether any lesson meets the capture criteria below.
3. Decide the artifact level: no capture, lesson note, or skill promotion.
4. For lessons, find the right lesson file and add or update one compact entry.
5. For skill promotions, create or update the relevant skill, then add a short pointer in the lesson file.
6. Mention the captured lesson or promoted skill in the final response. If nothing was worth capturing, do not force a note.

## Capture Criteria

Capture a lesson when it is likely to help a future agent avoid wasted work or make a better decision in this repository.

Good candidates:

- A non-obvious root cause and its fix.
- A local setup, dependency, sandbox, proxy, build, test, or deployment quirk.
- A project-specific convention that was discovered rather than obvious from standard practice.
- A repeated user preference or workflow rule that affects future work.
- A command sequence that reliably verifies or repairs a known issue.
- A risky edge case, regression pattern, or debugging heuristic.
- A decision that future agents are likely to revisit unless recorded.

Do not capture:

- Generic programming advice that applies everywhere.
- One-off command output, temporary logs, or incidental errors.
- Secrets, tokens, private credentials, personal data, or sensitive operational details.
- A guess that has not been verified or clearly labeled as uncertain.
- Large transcripts. Distill the reusable rule instead.

## Promotion To Skill

Promote knowledge into a skill when a plain lesson would be too weak because future Codex needs a procedure, decision tree, resource layout, script, template, or repeated execution pattern.

Promote when at least two of these are true:

- The knowledge describes a multi-step workflow rather than a single rule.
- The workflow will likely be reused across repositories or many future tasks.
- Correct execution depends on ordering, validation, file locations, commands, or tool choices.
- The workflow benefits from bundled scripts, references, templates, or examples.
- The user explicitly asks to turn knowledge into a skill or make it automatic.
- A lesson file would become long, ambiguous, or hard to apply without procedural instructions.

Do not promote when:

- The knowledge is a one-sentence preference or simple rule.
- The content is project-specific and better belongs in `AGENTS.md`, project docs, or a project lesson file.
- The workflow depends on secrets, private credentials, or unverified assumptions.
- The existing skill can be updated with a small clarification instead of creating a new skill.

## Skill Promotion Workflow

When promoting:

1. Search existing skills by name and description before creating a new one.
2. If a matching skill exists, update it instead of creating a duplicate.
3. If creating a new skill, use the `skill-creator` workflow and default to `~/.codex/skills` for user-level skills.
4. Keep the skill lean: put core procedure in `SKILL.md`; add `scripts/`, `references/`, or `assets/` only when they materially improve repeatability.
5. Validate the skill with `quick_validate.py`.
6. Add a short lesson entry pointing to the new or updated skill, including when to use it.

Name promoted skills with lowercase hyphen-case and an action-oriented name. Prefer names such as `sync-vpn-script`, `capture-project-lessons`, or `review-api-contracts` over vague names like `knowledge-base`.

If the user has explicitly requested automatic skill generation, proceed when the promotion criteria are met. Otherwise, ask before creating a new global skill; updating an already-triggered skill for the current request is acceptable when it is clearly in scope.

## Instruction Bootstrap

This skill includes `scripts/bootstrap_agent_instructions.sh` for making lessons easier to load in future sessions.

Use it when the user asks to:

- generate or update `AGENTS.md` or `CLAUDE.md`;
- make lessons load more seamlessly;
- bootstrap the current project for lesson capture;
- install user-level instruction snippets for Codex, Cursor, or Claude Code.

Examples:

```bash
bash path/to/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope user
bash path/to/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope project --root /path/to/repo
bash path/to/capture-project-lessons/scripts/bootstrap_agent_instructions.sh --scope all --root /path/to/repo
```

The script appends marker-delimited blocks only when missing. It creates `~/LESSONS.md` for user scope and `.codex/lessons.md` for project scope when absent. Project-scope bootstrap mounts both `~/LESSONS.md` and `.codex/lessons.md` in the project root `AGENTS.md` so future sessions know which lesson files to load.

## Scope And Location

Decide the scope before writing.

For cross-project or user-level lessons, write to the user's shared lesson file:

1. Use `~/LESSONS.md` when the lesson applies across repositories, Codex sessions, or the user's general workflow.
2. Create `~/LESSONS.md` if it does not exist.

For project-specific lessons, write into the current project repository, not inside the skill folder. Use this priority order:

1. Existing explicit lesson file if present: `.codex/lessons.md`, `.agents/lessons.md`, `docs/codex-lessons.md`, `docs/lessons.md`, or similarly named project memory file.
2. Existing agent instruction file if it already has a lessons/project memory section: `AGENTS.md`, `.agents/AGENTS.md`, or `.codex/AGENTS.md`.
3. Otherwise create `.codex/lessons.md`.

If creating `.codex/lessons.md`, also create the `.codex` directory as needed.

For promoted skills, write the skill itself to `~/.codex/skills/<skill-name>` unless the user specifies another location. Record only a concise pointer in the lesson file so the lesson index stays readable.

## Entry Format

Keep entries short and scannable. Use the user's language when clear from the conversation; otherwise match the dominant language of the project notes.

Use this format:

```markdown
## YYYY-MM-DD - Short lesson title

- Context: What situation produced the lesson.
- Lesson: The durable rule, fact, or preference to remember.
- Apply when: The trigger for using this lesson later.
- Evidence: Optional command, file, PR, or observed behavior that verifies it.
```

For very small lessons, combine context and lesson into one or two bullets. Avoid more than about 150 words per entry unless the lesson is unusually important.

## Deduplication

Before writing, scan the lesson file for related entries.

- If an entry already says the same thing, do not add a duplicate.
- If the old entry is incomplete, update it with the new evidence or refined rule.
- If the new lesson supersedes an old one, edit the old entry and note the newer date inside it.

## End-Of-Task Check

When this skill is active, run this mental check before the final response:

- Did I discover something project-specific or non-obvious?
- Would future Codex waste time without this?
- Can I express it as a small rule with a clear trigger?
- Is this complex enough that a future Codex needs a skill rather than a note?

If yes, update the lesson file or promote/update a skill before finalizing. If no, simply finish the task.
