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

SLASH_OK=1
if [[ -z "$unshipped" ]]; then
  echo "OK: every /slash-command reference resolves to a published skill."
  echo ""
  echo "Published skills ($(echo "$published" | wc -l | tr -d ' ')):"
  echo "$published" | sed 's/^/  - /'
else
  SLASH_OK=0
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
fi

# --- Evidence Ledger Protocol coverage + byte-identity check ---
# Every skill referencing perplexity_*, WebFetch, WebSearch, or reddit.*\.json
# MUST (a) ship its own reference/evidence-ledger-protocol.md, AND (b) reference it from SKILL.md,
# AND (c) the copy must be byte-identical to the canonical at market-pain/reference/.
echo ""
echo "=== Evidence Ledger Protocol coverage + integrity ==="

CANONICAL="skills/market-pain/reference/evidence-ledger-protocol.md"
if [ ! -f "$CANONICAL" ]; then
    echo "FAIL: canonical protocol missing at $CANONICAL" >&2
    exit 1
fi

LEDGER_VIOLATIONS=0
for skill_dir in skills/*/; do
    skill_name=$(basename "$skill_dir")
    skill_md="$skill_dir/SKILL.md"
    [ -f "$skill_md" ] || continue

    # Does this skill use research tools?
    if grep -qE "perplexity_(search|ask|research|reason)|WebFetch|WebSearch|reddit\.com/r/.*\.json" "$skill_md" 2>/dev/null; then
        skill_protocol="$skill_dir/reference/evidence-ledger-protocol.md"

        # Check 1: SKILL.md references the protocol
        if ! grep -q "evidence-ledger-protocol" "$skill_md"; then
            echo "MISSING REFERENCE: $skill_md does not reference reference/evidence-ledger-protocol.md" >&2
            LEDGER_VIOLATIONS=$((LEDGER_VIOLATIONS + 1))
        fi

        # Check 2: skill ships its own protocol copy
        if [ ! -f "$skill_protocol" ]; then
            echo "MISSING FILE:      $skill_protocol (run scripts/sync-protocol.sh)" >&2
            LEDGER_VIOLATIONS=$((LEDGER_VIOLATIONS + 1))
            continue
        fi

        # Check 3: byte-identity to canonical (skip for market-pain itself)
        if [ "$skill_name" != "market-pain" ]; then
            if ! diff -q "$CANONICAL" "$skill_protocol" > /dev/null 2>&1; then
                echo "DRIFT:             $skill_protocol differs from canonical (run scripts/sync-protocol.sh)" >&2
                LEDGER_VIOLATIONS=$((LEDGER_VIOLATIONS + 1))
            fi
        fi
    fi
done

if [ $LEDGER_VIOLATIONS -gt 0 ]; then
    echo "" >&2
    echo "FAIL: $LEDGER_VIOLATIONS protocol coverage/integrity violation(s)" >&2
    LEDGER_OK=0
else
    echo "PASS: all research-using skills ship Evidence Ledger Protocol byte-identical to canonical"
    LEDGER_OK=1
fi

if [[ $SLASH_OK -eq 1 && $LEDGER_OK -eq 1 ]]; then
    exit 0
else
    exit 1
fi
