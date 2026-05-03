# Validate Opportunity Consolidated Report Template

This Codex reference holds detailed workflow material moved out of SKILL.md to keep the trigger-time instructions lean.

## Consolidated report template

Every run produces `docs/strategy/[industry-slug]/validate-opportunity-report.md` with this structure. This is the single deliverable the builder reads.

```markdown
# Validate Opportunity â€” [Industry] ([Geography])

**Raw idea:** [verbatim from input]
**Verdict:** GO / KILL / CONDITIONAL
**Report date:** [YYYY-MM-DD]
**Stage 1 completed:** [date, or "skipped â€” reused from [date]"]
**Stage 2 completed:** [date, or "â€”" if killed earlier]
**Stage 3 completed:** [date, or "â€”" if killed earlier]

## Executive summary

[3-5 sentences. State the verdict and cite WHICH stage + phase produced the decision.
Example for KILL: "KILLED at Stage 2 Phase 3 â€” legal blocker: [specific regulation]. No redesign path because [reason]. Suggest pivot to [adjacent vertical] where the regulation doesn't apply, per the Stage 2 Phase 3 findings."]

## Stage 1 â€” Market pain validation

**Verdict:** PASS / FAIL
**Source artifact:** [docs/strategy/[industry-slug]/[industry-slug]-pain-report.md]

### Top 3 problems (from market-pain skill Phase 2)

| Rank | Problem | Score | Top-line evidence |
|-|-|-|-|
| 1 | [problem] | XX/30 | "[verbatim quote]" [source URL] |
| 2 | [problem] | XX/30 | "[verbatim quote]" [source URL] |
| 3 | [problem] | XX/30 | "[verbatim quote]" [source URL] |

### Economic viability (from market-pain skill Phase 2.5)

- Viable segment: [N businesses] at [$X/mo ceiling]
- Sell type: SWAP / NEW LINE ITEM
- Platform Risk: GREEN / YELLOW / RED

### Phase 4 execution log

- Calls run: [N] on [dates]
- Confirmed the problem: [N of N]
- Willingness to pay: [$X-$Y range]
- Referrals: [N offered]

## Stage 2 â€” Product strategy

**Verdict:** PASS / FAIL / CONDITIONAL
**Source artifact:** [docs/strategy/[industry-slug]/[industry-slug]-product-strategy.md]

### Phase status

| Phase | Name | Status | Gate |
|-|-|-|-|
| 1 | Pain Validation | GREEN | 3+ problems 20+/30 confirmed |
| 2 | Integration Blueprint | GREEN/YELLOW/RED | Platform Risk: [X]. Single-platform concentration: [Y]% |
| 3 | Legal & Compliance | GREEN/YELLOW/RED | [Specific regulations checked] |
| 4 | Service Architecture | GREEN | [N named services] |
| 5 | Bundle Strategy | GREEN | [N competitor benchmarks, weak-signal status] |
| 6 | Resource Manifest | GREEN | No TBD; per-customer COGS $X |
| 7 | Operational Risk | GREEN | [N risks with mitigations] |
| 8 | Scaling SOPs | GREEN | Written |
| 9 | Regulatory Specifics | GREEN | Complete |
| 10 | Build Plan | GREEN | [N-week plan] |
| 11 | Validation Design | GREEN | Kill criteria: [count + threshold + binary outcome] |
| 12 | Implementation Verification | GREEN | Phase 11 executed, all cross-checks pass |

### Named services (from Phase 4)

[List the 2-3 named services with the pain each solves, cited to Phase 2 problem #N]

### Bundle pricing (from Phase 5)

[Table: tier, price, competitor benchmark citations (URLs)]

### Risk register top 5 (from Phase 7)

[Table: risk, likelihood, impact, mitigation, trigger signal]

### 6-week build plan (from Phase 10)

[Weekly milestones]

## Stage 3 â€” Service design

**Verdict:** PASS / SEND BACK
**Source artifact:** [docs/strategy/[industry-slug]/[industry-slug]-product-strategy.md Â§ Stage 3]

- Positioning: [descriptive one-liner]
- Offer-ladder placement: [rung]
- HITL pattern(s): [per-service]
- First-customer acquisition sketch: [channel + timeline]

## Decision

Drift findings cited in the verdict must trace to `[E:S#]` ledger entries. Bare URLs without ledger backing don't count toward verdict changes.

### If GO:

**Build plan summary:** [reference Stage 2 Phase 10]
**Validation kill criteria:** [reference Stage 2 Phase 11]
**First-customer target:** [reference Stage 3]
**Next action:** [specific first step, who does it, by when]

### If KILL:

**Kill reason:** [cite stage + phase that produced the kill]
**Evidence:** [1-2 sentences with source URLs or Phase 4 call notes]
**Suggested alternatives:** [adjacent verticals where the kill reason doesn't apply, if any exist in Stage 1-2 data]

### If CONDITIONAL:

**Condition:** [what's ambiguous, cite phase]
**Required next action:** [specific, bounded â€” e.g., "5 more Phase 4 calls in the [segment] sub-segment", or "complete Phase 6 BOM lines 3-5 with current-best-estimate quotes"]
**Re-enter at:** [stage + phase]

## Evidence trail

| Stage | Phase | Artifact | Date |
|-|-|-|-|
| 1 | 1-4 | [path] | [date] |
| 2 | 1-12 | [path] | [date] |
| 3 | Scope + Build Plan | [path] | [date] |

Every claim in this report must cite (Stage X, Phase Y) or a fetched source URL from that phase. Uncited claims = FAIL at the capstone level.
```

---

