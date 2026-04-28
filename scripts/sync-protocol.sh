#!/bin/bash
# sync-protocol.sh — copies the canonical evidence-ledger-protocol.md
# from market-pain to every other research-using skill's reference/ folder.
# Skills are detected by grepping for research-tool references in SKILL.md.
#
# Usage:
#   bash scripts/sync-protocol.sh                          # syncs THIS toolkit's skills/
#   bash scripts/sync-protocol.sh --target /path/to/skills # syncs an external tree
#
# Trees this is run against:
#   - solo-builders-toolkit/skills/                        (this toolkit, default)
#   - solo-builders-toolkit-future-weeks/skills/           (archive)
#   - ~/.claude/skills/                                    (personal)

set -e

# Default target = this toolkit's skills/ (relative to repo root)
TARGET="skills"
if [ "$1" = "--target" ] && [ -n "$2" ]; then
    TARGET="$2"
fi

# Canonical lives in this toolkit
CANONICAL="skills/market-pain/reference/evidence-ledger-protocol.md"

if [ ! -f "$CANONICAL" ]; then
    echo "ERROR: canonical protocol not found at $CANONICAL"
    echo "Run this script from the solo-builders-toolkit repo root."
    exit 1
fi

if [ ! -d "$TARGET" ]; then
    echo "ERROR: target directory not found: $TARGET"
    exit 1
fi

echo "Canonical: $CANONICAL"
echo "Target:    $TARGET"
echo ""

SYNCED=0
SKIPPED=0
for skill_dir in "$TARGET"/*/; do
    skill_name=$(basename "$skill_dir")
    skill_md="$skill_dir/SKILL.md"
    [ -f "$skill_md" ] || continue

    # Skip canonical itself
    if [ "$skill_dir" = "$TARGET/market-pain/" ]; then
        # market-pain in the canonical tree IS the source — only target if syncing a different tree
        if [ "$TARGET" = "skills" ]; then
            continue
        fi
    fi

    # Does this skill use research tools?
    if grep -qE "perplexity_(search|ask|research|reason)|WebFetch|WebSearch|reddit\.com/r/.*\.json" "$skill_md" 2>/dev/null; then
        target_file="$skill_dir/reference/evidence-ledger-protocol.md"
        mkdir -p "$skill_dir/reference"
        cp "$CANONICAL" "$target_file"
        echo "  Synced: $target_file"
        SYNCED=$((SYNCED + 1))
    else
        SKIPPED=$((SKIPPED + 1))
    fi
done

echo ""
echo "Synced $SYNCED skill(s); skipped $SKIPPED non-research skill(s)."
