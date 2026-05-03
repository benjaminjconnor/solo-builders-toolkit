# Market Pain — Worked Examples

Three end-to-end walk-throughs showing the skill in action. Each one is genericized from a real research run, with names and specifics changed but structure preserved.

Read Example 1 first — it's the cleanest teaching case. Examples 2 and 3 show trickier situations where the methodology pays for itself.

---

## Example 1 — HVAC contractors (best teaching case)

**Why this example**: One vertical, two distinct gaps, strong revenue math, a clear "trades bundle" pattern that generalizes. Mid-complexity competitive landscape so gap analysis is instructive without being overwhelming.

### Input

`/market-pain hvac contractors in [country]`

No existing tracker entry — fresh run.

### Phase 1 — Problem mining

Sources accessed (Phase 1 citation trail):
- r/hvacadvice (subreddit, ~180K members)
- r/smallbusiness filtered for "HVAC"
- 6 software review pages — found via Google "[vertical] software reviews" and G2/Capterra "[vertical] CRM", then picked the top 5-6 by review volume (mix of vertical-specific CRMs, general field-service platforms, and AI phone add-ons)
- Industry association complaint forum
- 3 national business registry / classification stats pages

8 complaint clusters mined. Verbatim excerpts captured with source URLs and upvote scores.

Top 5 by surface signal:
1. Missed after-hours emergency calls (47 mentions across 6 sources)
2. Customer communication during service windows (31 mentions)
3. Seasonal scheduling chaos — summer AC / winter heating peaks (28 mentions)
4. Quote follow-up (22 mentions)
5. Admin time: invoicing, scheduling, parts ordering (19 mentions)

**Phase 1 kill switch**: 5+ distinct complaints required. 8 found. **PASSES.** Proceed to Phase 2.

### Phase 2 — Problem scoring

Scored top 5 complaints on 6 dimensions:

| Problem | Freq | Urgency | Spend | Switch | Market | Build | TOTAL |
|-|-|-|-|-|-|-|-|
| Missed after-hours calls | 5 | 5 | 4 | 5 | 4 | 5 | **28/30** |
| Seasonal scheduling chaos | 4 | 4 | 2 | 4 | 4 | 5 | **23/30** |
| Customer comms during jobs | 5 | 4 | 2 | 4 | 4 | 5 | **24/30** |
| Quote follow-up | 4 | 3 | 3 | 4 | 4 | 4 | **22/30** |
| Admin time overhead | 5 | 3 | 2 | 3 | 4 | 3 | **20/30** |

Scoring notes (why each problem scored what it did):
- **Missed calls urgency = 5**: Multiple owners cite $500–$1,200 per missed call. One report: "2–3 after-hours missed calls per month cost us $18K–$48K/year." This is crisis-level.
- **Seasonal chaos spending = 2**: No dedicated software for this; owners cope with spreadsheets and manual reminders. Low current spend, but high urgency.
- **Customer comms spending = 2**: Owners know it's a problem but don't pay to fix it. This is a classic "active pain, no current spend" combo — you're creating a new budget line, not swapping an existing one.

**Phase 2 kill switch**: At least one problem 20+/30. Five problems qualify. **PASSES.** Proceed to Phase 2.5.

### Phase 2.5 — Economic viability

Four parallel research streams (market segmentation, price benchmarks, platform risk, regulatory landscape).

**Market segmentation**:
- Total businesses in vertical: ~25K (verified via classification-code registry)
- Estimated revenue per business (median): ~$450K/year
- Owner-operator (1–3 staff): ~40% of the market, ~10K businesses. Likely can't afford $300+/mo.
- Small/medium (4–20 staff): ~45%, ~11K businesses. Target segment.
- Large (20+ staff): ~15%, ~3.5K businesses. Can afford premium tools but often use enterprise platforms.

**Price ceiling math**:
- Current spend on answering services: $300–$600/mo (replacement spend)
- Current spend on field service software: $50–$200/mo
- Industry gross margin: 18–25% on service revenue
- Price ceiling for small/medium segment: **$150–$400/mo** (bounded by willingness to pay, not just margin)

**Top problem → sell type**:
- Missed calls: SWAP sell (replaces answering service budget)
- Seasonal scheduling: NEW LINE ITEM (no current spend)
- Customer comms: NEW LINE ITEM (no current spend)

**MRR at 1% penetration** (small/medium segment only):
- 11K × 1% = 110 customers
- 110 × $199/mo = **$21.9K MRR**. Viable for a solo.

**Platform risk**: GREEN. Email, SMS, voice, web. No single-platform dependency.

**Kill switch #3**: Viable segment ≥1K at ≥$75/mo? Yes — 11K small/medium businesses at $150+/mo. **PASSES.**

### Phase 3 — Solution gap analysis

For the top 3 problems, map competitors and test gap durability.

**Missed after-hours calls (28/30)**:

Competitors:
- [Vendor A] — AI phone agent, from $29/mo, platform-generic
- [Vendor B] — vertical-specific AI receptionist, $150–$300/mo
- [Vendor C] — full CRM with AI calls module, $300+/mo

Gap: none. Market is served. Even the best "sub-gaps" (better after-hours triage, emergency routing logic) are FEATURE-level — competitors can add them in 1–2 sprints. **Confidence: LOW on finding a durable gap here.**

Recommendation: don't position around missed calls. The market's already solved this one.

**Seasonal maintenance automation (23/30)**:

Competitors:
- [Vendor C] has seasonal reminder toggles, but only single-channel email
- [Vendor A] does generic follow-ups but no seasonal-specific campaign builder
- Industry-specific CRMs: manual reminder workflows only

Gap: **GREENFIELD**. Nobody auto-triggers vertical-seasonal maintenance campaigns with multi-channel escalation (email → SMS → call) tied to the vertical's actual seasonal rhythm.
- Feature gap? Partial — incumbents could add it, but their data models don't include seasonal metadata. STRUCTURAL for 6–12 months.
- Durability: MEDIUM-HIGH.
- **Confidence: HIGH**.

**Customer communication during jobs (24/30)**:

Competitors:
- Generic "auto-text 'on my way'" features exist in most field service tools
- None chain job-stage-specific comms (dispatch → arrival → in-progress → completion → follow-up)

Gap: FEATURE gap. Existing tools offer pieces; nobody offers the full chain as a single product. Competitors could close this in 1–2 sprints.
- Durability: LOW.
- **Confidence: MEDIUM**.

**Phase 3 synthesis**:

| Problem | Gap type | Confidence | Durability | Recommendation |
|-|-|-|-|-|
| Missed calls | None (solved) | LOW | N/A | Skip |
| Seasonal automation | Greenfield → Structural | HIGH | MED-HIGH | **Build first** |
| Customer comms | Feature | MEDIUM | LOW | Build second, fast |

Recommended product positioning: **"Seasonal campaign automation for HVAC contractors"** — lead with the greenfield, layer in comms chain as secondary.

### Phase 4 — Conversation guide

Target: 10 discovery calls with HVAC business owners, 5–20 staff segment, before any build.

Discovery script (abbreviated):
1. "Walk me through what happens when summer hits and AC calls triple."
2. "How do you remind existing customers about pre-season maintenance?"
3. "If a tool auto-scheduled October 'summer's coming' campaigns with SMS follow-ups and booking links, would that matter to you?"
4. "What are you paying today for customer comms tools?"
5. "If it worked, what would you pay per month?"

Post-call rubric (see `scoring-rubric.md` for anchored descriptions).

### Go/no-go threshold (pre-committed)

- GO: 7+ calls confirm problem, avg urgency ≥ 3, current-spend ≥ 5 calls, willingness-to-pay ≥ 4 calls at $199/mo
- NO-GO: Any single criterion fails

### Output — recommendation

**PROCEED TO PHASE 4** with seasonal automation as the product thesis. Expected Phase 4 outcome range:
- GO (likely 40–60% probability): build seasonal campaign automation as the flagship, comms chain as v2.
- AMBIGUOUS (30–40%): seasonal campaigns confirmed but willingness-to-pay softer than $199; iterate on pricing or packaging.
- NO-GO (10–20%): seasonal concept doesn't resonate; owners say they'd "just remember" to send reminders themselves.

---

## Example 2 — Accounting firms (high competitor density trap)

**Why this example**: Teaches what to do when Phase 2 scores look great but Phase 3 reveals the market is crowded. Most naive researchers would proceed; this example shows when NOT to.

### Input

`/market-pain accounting firms in [country]`

### Phase 1 — Problem mining

11 complaint clusters. Top 3 by surface signal:
1. Chasing clients for documents — "request one thing, get 4 billion unrelated things"
2. Onboarding new clients — 6–8 weeks, manual
3. Scope creep without invoicing for it — ~$100K/yr lost per firm (industry average)

**Phase 1 kill switch**: PASSES.

### Phase 2 — Problem scoring

| Problem | Freq | Urgency | Spend | Switch | Market | Build | TOTAL |
|-|-|-|-|-|-|-|-|
| Document chasing | 5 | 5 | 3 | 4 | 5 | 5 | **27/30** |
| Onboarding chaos | 4 | 4 | 3 | 4 | 5 | 4 | **24/30** |
| Scope creep | 5 | 4 | 3 | 3 | 5 | 4 | **24/30** |

**Phase 2 kill switch**: PASSES. On paper, this looks incredible — a 27/30 problem.

### Phase 2.5 — Economic viability

- Total firms in vertical: ~35K
- Addressable segment (small-to-mid firms, 3–25 staff): ~15K
- Current stack spend: $300–$1,500/mo per firm
- Price ceiling: $200–$500/mo for a single-problem tool

MRR at 1% penetration: 150 × $299 = $44.8K MRR. **Very viable**.

**Kill switch #3**: PASSES.

So far, every gate has said PROCEED. But Phase 3 is where the thesis falls apart.

### Phase 3 — Solution gap analysis

**Document chasing (27/30)**:

Competitors (verified as of research date):
- [Vendor D] — purpose-built document request platform, $75–$200/mo
- [Vendor E] — integrated practice management with document workflows, $300+/mo
- [Vendor F] — document automation add-on, $100+/mo
- [Vendor G] — niche competitor, email-only reminders, $50/mo
- 3 additional sub-$100/mo indie tools

Competitor density: **HIGH.**

Gap-hunting:
- Multi-channel escalation (email → SMS → voice)? Only [Vendor D] does email+SMS. Nobody does voice. → Potential gap.
- Integration with the top 3 accounting platforms? All major competitors do this.
- Pricing disruption? The segment has tools at $50, $100, $200, $300 — every price point is covered.

**Gap durability test on multi-channel**: Can the top 3 competitors add a voice-escalation feature in 6 months?
- [Vendor D]: has infrastructure for SMS, voice would take 1 sprint. Yes.
- [Vendor E]: has Twilio integration elsewhere. Yes.
- [Vendor F]: partnered with a VoIP provider already. Yes.

→ **FEATURE gap, LOW durability.** Would be copied in months.

**Document chasing: KILL** despite 27/30 Phase 2 score.

### Teaching point

Phase 2 measures PAIN. Phase 3 measures WHETHER A SOLO CAN WIN.

A 27/30 pain score in a market with 6 well-funded competitors and no structural gap is NOT a buildable opportunity for a solo. The incumbents will copy any feature you ship.

This is the most common mistake researchers make: they fall in love with the Phase 2 numbers and skip the honest Phase 3 conversation about durability.

### What should've been tested in Phase 2.5 but was missed

In hindsight, Phase 2.5 should have flagged the competitor-density risk earlier. Some optional Phase 2.5 signals:
- "How many competitors at the right price point, with right integrations, have existed for 2+ years?"
- If the answer is >3, flag for gap-durability emphasis in Phase 3.

A good Phase 2.5 catches Phase 3 kills before you invest in Phase 3 research.

### Output — recommendation

**KILL** on all three problems. Market is real; competition is too mature for a solo entrant to establish durable gap.

Secondary finding: an accounting firm tools comparison article COULD be a valid entry wedge (content/SEO play, not a product). But that's a different skill's conversation.

---

## Example 3 — "Nothing here" (the Phase 1 kill)

**Why this example**: The most important result in vertical research is often "don't build here." This example shows how to recognize and document a Phase 1 kill without wasting hours on downstream phases.

### Input

`/market-pain licensed massage therapists in [country]`

Assumed thesis: "healthcare adjacent, many small operators, probably pain points around scheduling / intake / no-shows."

### Phase 1 — Problem mining

Sources accessed:
- r/massagetherapy (subreddit)
- 3 industry association forums
- 4 software review pages — found via G2/Capterra searches for "[vertical] booking software" and "[vertical] practice management", picked top 4 by review volume
- 1 national classification-code registry

Results after ~60 min of research:

**Top surface complaints (all low-frequency)**:
1. "Insurance billing is a hassle" — 3 mentions across 2 sources
2. "No-shows are annoying" — 2 mentions, software handles this already
3. "Finding clients is hard" — 2 mentions, not a tooling problem

No single complaint has more than 3 verifiable mentions. Most threads on the subreddit are about technique, not business ops. Software reviews are overwhelmingly positive — users are content with current tools.

### Phase 1 kill switch

Required: 5+ distinct complaints with verifiable sources.
Found: 3 weak clusters, none exceeding 3 mentions.

**FAILS.** STOP.

### Output

Total time spent: ~75 minutes.

Report content (complete):
> **Licensed massage therapists — KILLED at Phase 1.**
> 
> Phase 1 mining across [X sources over Y hours] returned 3 complaint clusters, each with fewer than 5 mentions. No dominant pain signal. The 4 dominant booking/practice-management platforms score 4+ stars with content users.
> 
> **This is a valid, valuable result**: either there's no meaningful unmet pain, or it's not loud enough to surface through public research. Either way, it means don't build here right now.
> 
> **Possible reasons**:
> - The pain may exist but solo practitioners aren't discussing it publicly (quieter community, less online).
> - Incumbents may be "good enough" — modest pain with adequate solutions, not a gap.
> - The real pain may be elsewhere (e.g., finding clients, not running the practice).
> 
> **Don't revisit** without new signal: a specific customer asking, a new regulation, a platform change that breaks existing tools.

### Teaching point

A 75-minute kill is a win. Compare:
- Researcher A takes the skill seriously, kills at Phase 1, moves to next vertical. Total time: 75 min. Moved on.
- Researcher B "feels" the vertical should work, pushes through Phases 2–4 anyway, builds an MVP based on weak signal, launches, gets no traction. Total time: 6 months.

The skill exists to get researchers to kill fast. This example shows what that looks like in practice.

### Tracker update

After a Phase 1 kill, still update the tracker:

```
| Licensed massage therapists | [geography] | 2026-05-10 | KILLED P1 | — | — | docs/research/massage-therapist-pain-report.md | Don't build. Revisit only with new signal. |
```

This prevents rerunning the same vertical 6 months later.

---

## Pattern extraction across examples

Reading all three, you should recognize:

**Healthy vertical signature** (Example 1 — HVAC):
- Phase 1: 8+ complaint clusters, multiple sources
- Phase 2: 3+ problems at 20+/30
- Phase 2.5: replacement spend exists, addressable segment >5K
- Phase 3: at least one STRUCTURAL or GREENFIELD gap with HIGH confidence
- Outcome: proceed to Phase 4

**Trap vertical signature** (Example 2 — accounting):
- Phase 1: 10+ complaint clusters (looks great)
- Phase 2: 27/30 top score (looks incredible)
- Phase 2.5: economics check out (still looks great)
- Phase 3: 6+ mature competitors, no structural gap, all FEATURE gaps
- Outcome: KILL despite impressive upstream scores

**Kill-fast signature** (Example 3 — massage therapy):
- Phase 1: <5 complaints, weak signal
- Outcome: KILL at Phase 1, move on same day

**The lesson**: Phase 2 scores measure pain intensity. Phase 3 measures whether a solo can win. Both gates must pass. High Phase 2 + failed Phase 3 = still a kill.

---

## How to use these examples

When you're running the skill on your own vertical:

1. After Phase 2 scoring, pattern-match against Example 1 (good signature) and Example 2 (trap signature). If your scores look like Example 2, be extra rigorous in Phase 3.
2. If Phase 1 is producing thin results, compare to Example 3. If you're at 75 min and under 5 complaint clusters, you have your answer — kill and move on.
3. When writing the final report, use these examples' structure as your template. Executive summary → Phase 1 → Phase 2 → Phase 2.5 → Phase 3 → Phase 4 → Recommendation.

The skill is rigid on purpose. Follow the phases in order, respect the kill switches, and trust the process even when you really want a vertical to work.
