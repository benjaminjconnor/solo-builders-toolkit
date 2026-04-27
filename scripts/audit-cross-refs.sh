#!/usr/bin/env bash
# Audit cross-references in published skills.
#
# Fails (exit 1) if any SKILL.md or reference/*.md file in skills/ contains
# a `/skill-name` slash-command reference for a skill that does NOT exist as
# a directory under skills/.
#
# Run before every weekly launch. Run from the repo root.
#
# Background: this guardrail exists because we shipped Week 1 twice with
# slash-command references to Week 2-7 skills, creating the impression that
# those skills had already been published. Catch it locally, never in public.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
SKILLS_DIR="$REPO_ROOT/skills"

if [[ ! -d "$SKILLS_DIR" ]]; then
  echo "ERROR: skills/ directory not found at $SKILLS_DIR" >&2
  exit 2
fi

# Build the set of currently-published skill names (directory names under skills/).
published=$(ls -1 "$SKILLS_DIR" | sort -u)

# Find every backtick-quoted slash-command reference of the form `/skill-name`
# inside any markdown file under skills/. Strip backticks, leading slash,
# trailing punctuation. Keep unique names.
referenced=$(grep -rhoE '`/[a-z][a-z0-9-]+`' "$SKILLS_DIR" \
  | tr -d '`' \
  | sed 's|^/||' \
  | sort -u)

# Compute the set difference: referenced - published.
unshipped=$(comm -23 <(echo "$referenced") <(echo "$published"))

if [[ -z "$unshipped" ]]; then
  echo "OK: every /slash-command reference resolves to a published skill."
  echo ""
  echo "Published skills ($(echo "$published" | wc -l | tr -d ' ')):"
  echo "$published" | sed 's/^/  - /'
  exit 0
fi

echo "FAIL: published skills reference unshipped skills via /slash-command syntax." >&2
echo "" >&2
echo "Unshipped skill references found:" >&2
echo "$unshipped" | sed 's|^|  - /|' >&2
echo "" >&2
echo "Locations:" >&2
while IFS= read -r name; do
  [[ -z "$name" ]] && continue
  echo "  /$name:" >&2
  grep -rn "\`/$name\`" "$SKILLS_DIR" | sed 's/^/    /' >&2
done <<< "$unshipped"
echo "" >&2
echo "Fix: replace each /slash-command reference to an unshipped skill with a" >&2
echo "plain-text description plus a 'ships Week N' marker. Slash-command syntax" >&2
echo "implies the skill is invokable today; readers will assume it has shipped." >&2
echo "" >&2
echo "See docs/research/solo-builders-toolkit/public-release-audit-checklist.md" >&2
echo "(in the F&L repo) for the full pattern." >&2
exit 1
