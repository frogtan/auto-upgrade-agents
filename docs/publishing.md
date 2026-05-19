# Publishing

This repository can be published as an agent skills repository because it uses the supported layout:

```text
skills/
  capture-project-lessons/
    SKILL.md
```

## Prerequisites

- GitHub CLI installed as `gh`
- `gh skill` available in your GitHub CLI build
- authenticated GitHub CLI session
- repository pushed to GitHub
- clean working tree before publishing

Check GitHub authentication:

```bash
gh auth status
```

Check that the skills preview command is available:

```bash
gh skill --help
```

If this prints `unknown command "skill"`, upgrade GitHub CLI to a version that includes the agent skills preview before publishing.

## Validate

Run a local publish validation without creating a release:

```bash
./scripts/publish.sh
```

This runs:

```bash
gh skill publish --dry-run
```

Use this before every release.

## Publish

Publish with a semver tag:

```bash
./scripts/publish.sh v0.1.0
```

This runs:

```bash
gh skill publish --tag v0.1.0
```

The publish command validates the skills, adds release metadata through GitHub, and creates a GitHub release for the tag.

## Install From GitHub

After publishing, users can install from the GitHub repository:

```bash
npx skills add frogtan/auto-upgrade-agents
```

For GitHub CLI agent-specific installs:

```bash
gh skill install frogtan/auto-upgrade-agents capture-project-lessons --agent codex --scope user
gh skill install frogtan/auto-upgrade-agents capture-project-lessons --agent cursor --scope user
gh skill install frogtan/auto-upgrade-agents capture-project-lessons --agent claude-code --scope user
```

If a user wants only one skill from a multi-skill repository, use the skill path:

```bash
npx skills add https://github.com/frogtan/auto-upgrade-agents/tree/main/skills/capture-project-lessons
```

## Release Checklist

1. Update `skills/capture-project-lessons/SKILL.md`.
2. Run skill validation:

```bash
python3 /Users/frog/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/capture-project-lessons
```

3. Run shell checks:

```bash
bash -n scripts/install.sh
bash -n scripts/check-install.sh
bash -n scripts/install-remote.sh
bash -n scripts/publish.sh
```

4. Commit and push changes.
5. Run `./scripts/publish.sh`.
6. Run `./scripts/publish.sh vX.Y.Z`.

## Notes

- Keep `SKILL.md` frontmatter limited to `name` and `description` unless the skill specification changes.
- Do not include secrets, private paths, tokens, or user-specific credentials in published skills.
- Prefer adding new reusable workflows as separate folders under `skills/`.
- Keep installation helpers in `scripts/`; they are repository utilities, not part of the skill runtime.
