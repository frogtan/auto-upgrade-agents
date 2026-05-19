#!/usr/bin/env bash
set -euo pipefail

if ! command -v gh >/dev/null 2>&1; then
  echo "Missing gh. Install GitHub CLI before publishing." >&2
  exit 1
fi

if ! gh skill --help >/dev/null 2>&1; then
  echo "This GitHub CLI does not provide 'gh skill'." >&2
  echo "Upgrade GitHub CLI to a version that includes the agent skills preview, then retry." >&2
  echo "Current gh version:" >&2
  gh --version >&2
  exit 1
fi

if [ "$#" -eq 0 ]; then
  gh skill publish --dry-run
  exit 0
fi

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 [vX.Y.Z]" >&2
  echo "Run without a tag for --dry-run; pass a semver tag to publish." >&2
  exit 1
fi

tag="$1"

case "$tag" in
  v[0-9]*.[0-9]*.[0-9]*) ;;
  *)
    echo "Tag should look like v0.1.0" >&2
    exit 1
    ;;
esac

gh skill publish --tag "$tag"
