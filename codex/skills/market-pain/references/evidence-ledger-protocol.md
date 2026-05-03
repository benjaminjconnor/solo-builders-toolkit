# Evidence Ledger Protocol

**Purpose**: Make every research-derived claim mechanically verifiable by both the agent and the user. No claim enters a report without a verbatim quote that `rg` or `Select-String` proves exists in a saved raw file.

**Why**: Real URLs aren't enough. Synthesis layers â€” Perplexity, LLM paraphrasing, search-engine snippets â€” can produce quotes that "feel right" even when the source page says something different. The fix is mechanical: save raw, rg or Select-String-verify quotes, cite by Source #. The user can re-run the same rg or Select-String to verify independently.

## The three rules

1. **Raw-first** â€” every fetched page saves to `evidence/raw/{type}-{slug}-{date}.{ext}` BEFORE anything is written into the ledger or report. If the file isn't on disk, the source doesn't exist.
2. **rg or Select-String-verify every quote** â€” after writing a verbatim quote into `evidence/evidence.md`, run the `rg` or `Select-String` tool against the raw file for an 8-12 word substring of that quote. Zero matches = hallucinated, delete and re-extract or drop the source.
3. **Cite by Source #** â€” every claim in the report cites `[E:S3]` or `[I:S5,S7]` (Evidence or Inference, with source numbers). No bare URLs in the report. The user opens `evidence/evidence.md` to verify any claim.

## Phase 0: Setup (run at skill invocation)

```bash
mkdir -p evidence/raw
test -f evidence/evidence.md || cat > evidence/evidence.md <<'EOF'
# Evidence Ledger â€” {topic} run, {YYYY-MM-DD}

**Tier**: [1=Perplexity / 2=Built-in / 3=Manual]

## Index

| # | Source type | URL | Fetched | Raw file | Status |
|-|-|-|-|-|-|

EOF
```

The skill announces "Evidence ledger initialized at evidence/evidence.md" and proceeds.

## Three-tier research hierarchy

**Tier 1 â€” Perplexity available**

- `available research/search tools` returns URLs + snippets. Snippets are NEVER citable on their own. For each cited URL, follow with web fetch tool + raw save + rg or Select-String-verify.
- `available research/search tools` is allowed ONLY for theme discovery (directions to investigate). Anything cited from `available research/search tools` output must be re-grounded via `available research/search tools` â†’ web fetch tool â†’ raw save.
- `available research/search tools` is BANNED â€” cost and unreliability documented across many runs.

**Tier 2 â€” Built-in only (default for users without Perplexity MCP)**

- `web search tool` returns titles + URLs + descriptions. Descriptions are snippets; same rule as Perplexity.
- `web fetch tool` each cited URL. Save raw to `evidence/raw/web-{url-slug}-{YYYY-MM-DD}.md`. The first two lines of the saved file are: `URL: {full URL}` and `Fetched: {ISO timestamp}`.
- Reddit: `web fetch tool` blocks reddit.com directly. Use Bash + curl on the JSON API:
  ```bash
  curl -A 'market-research/1.0' \
    "https://www.reddit.com/r/{sub}/search.json?q={query}&restrict_sr=on&sort=relevance&t=all&limit=25" \
    > evidence/raw/reddit-{sub}-{slug}-{YYYY-MM-DD}.json
  ```
- Robots.txt-blocked pages: try available browser automation (available browser navigation tool then available browser page-text tool). Save the extracted text to `evidence/raw/chrome-{slug}-{YYYY-MM-DD}.md` with URL + fetched-date headers.

**Tier 3 â€” Manual (rare, no internet/no MCP)**

- User pastes URLs they've already collected.
- For each URL, the user copies the relevant page content into `evidence/raw/manual-{slug}-{YYYY-MM-DD}.md` with URL + date headers at top.
- Same rg or Select-String-verify discipline applies â€” the pasted file IS the raw source.

## Ledger entry format (mandatory per source)

```markdown
## S{N} â€” {one-line description}
- **URL**: {full URL}
- **Fetched**: {ISO timestamp UTC}
- **Raw file**: `raw/{filename}` (locator: post_id / line range / section heading)
- **Source type**: Reddit post | Reddit comment | forum thread | blog post | G2 review | government page | corporate page | news article | manual paste
- **Author**: /u/username | "Article author name" | "anonymous" | "site editor"
- **Score / signal**: Reddit score N | star rating M/5 | view count | "no signal"
- **Created**: {original publish date if known, else "unknown"}
- **Verbatim**:
  > {1â€“3 sentences, exact substring from raw file â€” quote literally, do not edit punctuation}
- **rg or Select-String-verified**: yes ({pattern used, count})
- **Used in**: {phase + ledger location â€” Phase 1 P1-3, Phase 3 gap analysis, etc.}
```

Append each new source to the Index table at the top AND as a `## S{N}` block below.

## rg or Select-String-verify step (REQUIRED after every quote)

Immediately after writing a verbatim quote, the agent runs:

```
rg or Select-String tool call:
  pattern: {first 8-12 word substring of the quote, no special regex characters}
  path: {full path to the raw file}
  output_mode: count
```

- If count â‰¥ 1 â†’ ledger entry's `rg or Select-String-verified` field is set to `yes ({pattern}, count={N})`. Source can be cited.
- If count = 0 â†’ quote was hallucinated. Three valid responses:
  1. Re-open the raw file, find an actual matching substring, replace the quote, re-rg or Select-String.
  2. If no matching content exists for the claim, drop the source from the ledger.
  3. Mark the claim `[A]` (Assumption) and exclude it from kill-switch counts.

The user can re-run the same `rg or Select-String -F "{pattern}" {raw file}` command from a terminal to verify independently. This reproducibility is the trust mechanism.

## Forbidden phrases (signal hallucination)

These never appear in research output. The skill flags them as a quality-check failure:

- "Many users sayâ€¦", "Users often complainâ€¦", "It's commonly reportedâ€¦"
- "The general sentiment isâ€¦", "Industry studies showâ€¦", "Research suggestsâ€¦"
- "X is a known issue", "X is widely documented", "X is well-established"
- "Most {industry} businessesâ€¦", "Typically, {industry} ownersâ€¦"

**Replace with structured citations:**

- "N of M posts reviewed in r/X (D1â€“D2) mentioned Y. Example: '[verbatim]' â€” /u/author, score N [E:S3]"
- "{Source name} ({URL}) reports X [E:S5]."
- "Across {S3} and {S5}, the pattern is Y [I:S3,S5]."

## Snippet-vs-page rule

A search-engine snippet (Perplexity description, web search tool description, Google preview) is NEVER citable on its own. To use the content of a page:

1. web fetch tool the URL (or available browser automation fallback if web fetch tool returns empty/403).
2. Save the raw page to `evidence/raw/`.
3. Extract the verbatim quote from the raw file.
4. rg or Select-String-verify.

If both web fetch tool and Chrome fail, the source is `[INACCESSIBLE]`. Document in the ledger entry's Status column and drop the source from cited claims. Do NOT paraphrase from the snippet.

## Evidence / Inference / Assumption labels

Every factual claim in the final report carries one tag:

- `[E:S{N}]` â€” Evidence: direct verbatim quote from named ledger source S{N}.
- `[I:S{N},S{M}]` â€” Inference: pattern across â‰¥2 [E] sources. List which sources support it.
- `[A]` â€” Assumption: no source yet. Flagged for user verification. **Cannot feed kill switches.**

Examples:
- "47 of the top 100 listings on G2 had a complaint about onboarding [E:S12]"
- "Two independent reviews note manual data entry as the top friction [I:S4,S9]"
- "The vertical likely supports a $300/mo price point [A]"

## Phase exit check

Before moving to the next phase, the agent runs a self-diff:

> "For each claim in this phase's output section, point to the ledger entry it came from. Any claim without an `[E:S#]`, `[I:S#,S#]`, or `[A]` tag â†’ delete it or label `[A]` and exclude from kill-switch evaluation."

If the phase has a kill switch tied to a count (e.g., "â‰¥5 distinct complaints"), the count is **ledger entries** with the relevant tag, not the model's judgment of "enough evidence."

## Output: evidence.md is a deliverable

At the end of every research run, `evidence/evidence.md` is delivered alongside the report. The report cites `[E:S#]` / `[I:S#,S#]`; the user opens `evidence.md` to verify each one. The report's appendix lists the directory tree under `evidence/` so the user can spot-check raw files.

## optional delegated pass rules

When dispatching optional delegated passes for parallel research:
- The optional delegated pass MUST save raw files to `evidence/raw/` (provide the absolute path in the prompt).
- The optional delegated pass MUST return ledger entries in the format above, including the `rg or Select-String-verified` field with the pattern + count it actually ran.
- The main context re-runs `rg` or `Select-String` on each optional delegated pass-claimed quote before merging into the master ledger. **Do not trust optional delegated pass rg or Select-String claims unverified.**

## Anti-patterns (red flags)

- Writing a quote into a ledger entry before the raw file exists on disk.
- Skipping rg or Select-String-verify because "it obviously matches".
- Pasting a snippet into a ledger as if it were a verbatim quote.
- Treating `[A]` (assumption) entries as if they were `[E]`.
- Citing a URL in the report without an `[E:S#]` tag pointing to a ledger entry.
- "Cleaning up" a verbatim quote (fixing typos, punctuation) â€” this breaks rg or Select-String-verify.

If you catch yourself doing any of these: the claim doesn't ship.

## Version
- v1 â€” 2026-04-28 â€” Initial protocol. Authored during evidence-ledger-rollout (see plan in F&L docs/plans/).

