# Industry Tracker — Template

Copy this file to your working directory as `industry-tracker.md` (or any path that makes sense for your project) and update as you research.

The tracker is optional for single-industry runs but **essential** for any `/market-pain compare` run. Without consistent history, comparisons become guesswork.

---

# Industry Research Tracker

_Last updated: [YYYY-MM-DD]_

## Top 20 Candidates (current ranking)

Ordered by composite score: pain signal strength × market size × accessibility × buildability.

| # | Industry | Geography | Status | Priority | Notes |
|-|-|-|-|-|-|
| 1 | [Industry A] | [Country] | ✅ DONE | — | Top problem 28/30. Ready for Phase 4. |
| 2 | [Industry B] | [Country] | ✅ DONE | — | KILLED at Phase 3. High competitor density. |
| 3 | [Industry C] | [Country] | 🔄 QUEUED | HIGH | Adjacent to Industry A; trades-bundle hypothesis. |
| 4 | [Industry D] | [Country] | 🔄 QUEUED | MED | High pain per Reddit; unverified sizing. |
| 5 | [Industry E] | [Country] | 🚫 KILLED | — | Phase 1 kill; no complaint signal. |
| ... | ... | ... | ... | ... | ... |

**Status legend**:
- ✅ DONE — Phases 1–4 complete (or Phases 1–3 + go/no-go recorded)
- 🔄 QUEUED — On research list
- 🚫 KILLED — Research complete, do not build
- ⏸ PAUSED — Started but blocked (access, data, etc.); flag reason
- 📅 SCHEDULED — Has a specific date assigned

**Priority legend**: HIGH / MED / LOW — based on your assessment of adjacency to current work, time sensitivity, or personal interest.

---

## Completed Research

Every completed run, in reverse-chronological order. Update after EVERY `/market-pain` run, including kills.

| Date | Industry | Geography | Status | Top Score | Top Problem | Report Path | Recommendation |
|-|-|-|-|-|-|-|-|
| 2026-05-10 | [Industry A] | [Country] | DONE | 28/30 | Missed after-hours calls | `docs/research/industry-a-pain-report.md` | PROCEED to Phase 4 — seasonal automation thesis |
| 2026-05-07 | [Industry B] | [Country] | KILLED P3 | 27/30 | Document chasing | `docs/research/industry-b-pain-report.md` | KILL — market saturated, no structural gap |
| 2026-05-03 | [Industry E] | [Country] | KILLED P1 | — | — | `docs/research/industry-e-pain-report.md` | KILL at Phase 1 — no pain signal |
| ... | ... | ... | ... | ... | ... | ... | ... |

**Column notes**:
- **Status**: DONE / KILLED P1 / KILLED P2 / KILLED P3 / KILLED P2.5 / PAUSED
- **Top Score**: Highest Phase 2 score (even if killed downstream, record the score you got)
- **Top Problem**: Name of the top-scoring problem (even for kills at Phase 1, leave a short note)
- **Report Path**: Link to the saved Phase 1–4 report
- **Recommendation**: One-line outcome — PROCEED / KILL / PAUSE + reason

---

## Queued for Research

Industries you've flagged but not yet researched. Prune this list regularly — keeping 40 stale "maybe someday" entries dilutes the actual top candidates.

| Industry | Geography | Priority | Rationale | Added date |
|-|-|-|-|-|
| [Industry C] | [Country] | HIGH | Trades-bundle play; adjacent to confirmed Industry A. | 2026-05-08 |
| [Industry D] | [Country] | MED | Reddit signal strong; sizing unverified. | 2026-04-22 |
| [Industry F] | [Country] | LOW | Personal interest; no evidence of demand. Verify first. | 2026-03-15 |
| ... | ... | ... | ... | ... |

**Rationale field**: Write down WHY this is on the list. Without rationale, you'll later wonder why Industry F is here and delete it (or worse, research it again from scratch).

---

## Killed Industries

A separate section for killed research, so you don't re-research them. Include WHY, not just that it was killed.

| Industry | Geography | Killed Date | Kill Phase | Reason | Revisit Trigger |
|-|-|-|-|-|-|
| [Industry E] | [Country] | 2026-05-03 | P1 | No public complaint signal; practitioners quieter online. | New regulation, new platform entrant, customer asking directly |
| [Industry B] | [Country] | 2026-05-07 | P3 | 6+ mature competitors; no structural gap; FEATURE-only competition. | Major competitor exit, pricing disruption in segment |
| ... | ... | ... | ... | ... | ... |

**Revisit trigger**: What signal would make you re-research this industry? Without this, killed industries stay killed forever, which is usually right — but occasionally wrong. A named trigger keeps the door ajar.

---

## Comparison Matrix (Mode 3 output cache)

When you run `/market-pain compare`, paste the output table here so you can diff current and previous comparisons. (The skill generates this table; you just save it.)

_Last compare: [YYYY-MM-DD]_

| Dimension | [Industry A] | [Industry C] | [Industry D] |
|-|-|-|-|
| Top problem score (/30) | 28 | — | — |
| Market size (businesses) | 25K | — | — |
| Accessibility | OPEN | — | — |
| Competitor density | MEDIUM | — | — |
| Gap clarity | HIGH | — | — |
| Buildability on your stack | 5/5 | — | — |
| Price ceiling | $150–$400/mo | — | — |
| Current software spend | $300–$600/mo | — | — |
| Top problem replacement spend | $300–$600/mo (SWAP) | — | — |
| Sell type | SWAP + NEW LINE | — | — |
| Viable segment + count | 11K @ $150+/mo | — | — |
| MRR at 1% penetration | $21.9K | — | — |
| Platform risk | GREEN | — | — |
| Human validation result | TBD (Phase 4 pending) | — | — |
| Time to first revenue (est.) | 60–90 days | — | — |

Note: "—" marks industries where that data hasn't been collected yet (e.g., Phase 2.5 not run).

---

## Notes & Methodology

Free-form section for observations about your research process across industries. Examples:

- _"Trades verticals (plumbing, electrical, HVAC) all show the same top-3 pain pattern. Confirms trades-bundle hypothesis. Next: consider building once, positioning three ways."_
- _"Classification-code registry was slow but reliable. Review sites were faster but biased toward positive reviews. Reddit was most honest."_
- _"Phase 3 always takes longer than estimated. Budget 2x expected time."_

Keep this section under 20 lines. If it grows longer, split into a separate methodology file.

---

## Tips on using the tracker

- **Update after every run, including kills.** A kill is data; a vague "eh, wasn't great" is not.
- **Don't edit past entries.** If you re-run a vertical, add a new row with a new date. The tracker is an audit trail, not a draft.
- **Prune queued candidates monthly.** If an industry has been queued 6+ months without movement, ask why. Delete or promote.
- **Export to a shared doc** if you're working with a partner, but keep the source of truth in this file — merge conflicts on a shared doc get ugly.
- **Do not rank by Phase 2 score alone.** Use the "current ranking" table at the top, which reflects your synthesized judgment across all phases.

---

## Minimal tracker (if the above feels heavy)

For solo builders doing quick research runs, strip the tracker down to 3 sections:

```markdown
## Completed
| Date | Industry | Status | Top Score | Recommendation |
|-|-|-|-|-|
| 2026-05-10 | [Industry A] | DONE | 28/30 | PROCEED |
| 2026-05-07 | [Industry B] | KILLED P3 | 27/30 | KILL |

## Queued
- [Industry C] — HIGH — trades bundle adjacent
- [Industry D] — MED — unverified sizing

## Killed (do not re-research without new signal)
- [Industry E] — 2026-05-03 — P1 — no signal
- [Industry B] — 2026-05-07 — P3 — competitor density
```

This is enough to prevent re-researching old verticals and to see at a glance what's in flight.
