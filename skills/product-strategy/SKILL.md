---
name: product-strategy
description: Use when taking a validated vertical from market research through to build plan. Triggers on "product strategy", "vertical deep dive", "build plan for [industry]", "bundle strategy", "service architecture", "what should we build", "go-to-market plan", "from pain to product", "integration blueprint", "resource manifest", "scaling SOPs". Also use when resuming a partially-complete vertical strategy.
---

# Product Strategy

Take a validated vertical from `/market-pain` output through 12 sequential phases to a concrete, implementation-ready build plan. Owns the FULL journey from validated pain to launch blueprint.

**Core rule:** No phase runs without its prerequisite gate passing. No recommendation without research. No pricing without competitor benchmarks. Every builder phase ends with concrete next steps.

**State file:** save phase-by-phase progress to a file named `[industry-slug]-product-strategy.md` in the working directory or a `docs/strategy/` folder if one exists.

## Input Modes

### Start: `/product-strategy [industry]`

1. Check for an existing pain report (e.g., `[industry-slug]-pain-report.md` produced by `/market-pain`)
2. If pain report missing or phases 1-4 incomplete: **STOP. Run `/market-pain [industry]` first.**
3. If valid: show executive summary + top problems, proceed to Phase 1

### Resume: `/product-strategy resume [industry]`

1. Read the existing strategy file
2. Show phase status table
3. Resume at the next incomplete phase

## Scope & Related Skills

This skill owns: vertical strategy, service architecture, bundle design, build planning, risk analysis, SOPs, validation design, implementation verification.

**Out of scope — run these companions separately if available:**

| Need | See also |
|-|-|
| Market research / pain validation | `/market-pain` (required prerequisite) |
| Service packaging / pricing tiers | `/ai-service-designer` |

**Companion skills (ship in later weeks of the toolkit — see [README](../../README.md) for the roadmap):**

| Need | Companion skill | Ships |
|-|-|-|
| Copy for sales materials | dedicated copywriting skill | Week 3 |
| Email sequences | email-sequence skill | Week 3 |
| Funnel design | funnel-architect skill | Week 5 |
| UX review of demos | ux-audit skill | Week 5 |
| Ad campaigns | google-ads-optimize + facebook-ads-optimizer skills | Week 6 |

## Phase Status Table (track in output file)

| Phase | Name | Status | Gate |
|-|-|-|-|
| 1 | Pain Validation | - | 3+ problems 20+/30 |
| 2 | Integration Blueprint | - | MVP feasibility + Integration Viability Gate |
| 3 | Legal & Compliance | - | No hard blockers |
| 4 | Service Architecture | - | Each product tied to 20+/30 pain |
| 5 | Bundle Strategy | - | Pricing validated vs benchmarks |
| 6 | Resource Manifest | - | Full BOM with monthly costs |
| 7 | Operational Risk | - | Every risk has mitigation |
| 8 | Scaling SOPs | - | Written SOPs |
| 9 | Regulatory Specifics | - | Checklist complete |
| 10 | Build Plan | - | Concrete weekly plan |
| 11 | Validation Design | - | GO/NO-GO criteria defined |
| 12 | Implementation Verification | - | All phases green |

## Reference materials

| File | Use when |
|-|-|
| [`reference/pricing-benchmarks.md`](reference/pricing-benchmarks.md) | Running Phase 5. Competitor-pricing research protocol, hidden-pricing discovery, tier-spacing rules, setup-fee trade-offs, guarantee design, price-point validation, common pricing mistakes. |
| [`reference/vertical-playbooks.md`](reference/vertical-playbooks.md) | Any phase where the methodology feels abstract. Three worked end-to-end examples (accounting / trades / DTC subscription) distributed across US/UK/Canada — one clean GO, one KILL at Phase 3, one CONDITIONAL GO at Phase 11. Shows how gates protect the solo builder. |

---

## Phase 0: Evidence Setup (ALWAYS run first)

Before any research starts, initialize the evidence ledger so every claim made downstream is grep-verifiable.

```bash
mkdir -p evidence/raw
test -f evidence/evidence.md || cat > evidence/evidence.md <<'EOF'
# Evidence Ledger — [vertical] product strategy, $(date +%Y-%m-%d)

**Tier**: [1=Perplexity / 2=Built-in / 3=Manual]

## Index

| # | Source type | URL | Fetched | Raw file | Status |
|-|-|-|-|-|-|

EOF
```

Announce: "Phase 0: Evidence ledger initialized at `evidence/evidence.md`. Tier: [1/2/3]."

**All web research follows the Evidence Ledger Protocol** at this skill's `reference/evidence-ledger-protocol.md` (self-contained — no cross-skill dependency; read once before any research). Three rules: **save raw → grep-verify quotes → cite by `[E:S#]` Source #**.

---

## Phase 1: Pain Validation

**Gate-check only.** Verify `/market-pain` phases 1-4 complete for this vertical.

1. Read the pain report
2. Confirm: Phase 4 (conversation guide) reached? Min 3 problems scored 20+/30?
3. Extract: top problems (20+/30), competitor gaps, economics data
4. **Output:** Summary table of qualifying problems with scores, gaps, economics
5. **Gate:** All market-pain phases done AND 3+ problems score 20+. Fail = **STOP, run `/market-pain` first.** Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.

---

## Phase 2: Integration Blueprint

How services connect to existing client systems. **Must complete BEFORE Phase 4.**

1. Identify dominant platforms from pain report or via verified web research (Perplexity + WebFetch — save raw to evidence/raw/, then grep-verify per reference/evidence-ledger-protocol.md)
2. Per platform: API access (OPEN/GATED/NONE), auth method, key endpoints, rate limits, costs
3. Map each qualifying problem to integration requirements
4. Assess standalone viability (can MVP launch WITHOUT platform integration?)
5. **Integration Viability Gate** — for EACH platform with >15% market share, document ALL of:
   - **API access type:** OPEN (self-service, no approval) / GATED (requires partner application) / NONE
   - **Default access level:** READ-WRITE / READ-ONLY / UNKNOWN
   - **Evidence:** link to developer portal, or explicit statement "no public developer portal found"
   - **Small company precedent:** has any company with <5 employees gotten access? Name them or state "none found"
   - **Write access evidence:** do existing integrators confirm write access? Or do they say "read-only API"? Quote specific sources.
   - **Cost:** any per-app fees, minimum monthly charges, revenue share?
   - **Timeline:** estimated approval timeline based on evidence, not assumption
6. **Output:** Platform access matrix (including all Integration Viability Gate fields) + per-problem integration map + standalone vs integrated verdict
7. **Gate:** MVP feasibility confirmed. If all paths GATED-RED/NONE AND no standalone path: **STOP.**
8. **GATE RULE:** If >50% of the addressable market uses platforms where write access is GATED or UNKNOWN, this is a **YELLOW flag** — note it prominently and proceed with caution. If >50% uses platforms where write access is confirmed READ-ONLY or no developer path exists, this is a **RED flag**. RED flags require explicit user acknowledgment before proceeding — the skill must **STOP and present the risk.** Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.

> **Measuring ">50%" correctly.** The rule measures **single-platform concentration**, not aggregate market share of read-only tools. If the dominant platform sits at 40% of the addressable market AND is confirmed READ-ONLY, that IS a RED flag — because 40% of the market uses ONE platform that blocks write-back, and those customers cannot be served. Do not aggregate scattered smaller tools to dodge the threshold. If any SINGLE platform holding ≥30% of the market is READ-ONLY with no write path, treat it as RED for that segment.

> **CRITICAL:** "MVP works standalone" is NOT sufficient to pass this gate. The question is: does the FULL PRODUCT (V2+) deliver enough value at the target price WITHOUT write-back to the dominant platform? If the answer is "operator still has to manually log everything", the integration gap destroys the value proposition.

---

## Phase 3: Legal & Compliance Scan

**Must complete BEFORE Phase 5 (pricing).** Cannot price what you cannot legally deliver.

1. Pull legal findings from the pain report
2. Add service-specific regulations for each proposed product
3. Insurance requirements + cost estimates
4. Industry-specific licensing requirements
5. Compliance-as-moat opportunities (state-aware logic, consent management, regulatory features)
6. **Output:** Per-area rating (GREEN/YELLOW/RED) + startup legal costs + insurance costs
7. **Gate:** No RED blockers. Total compliance startup costs estimated. Any RED = **STOP or redesign.**

---

## Phase 4: Service Architecture

Define distinct products from validated pain. **Requires Phase 2 (integration) complete.**

1. For each problem scoring 20+/30: define a named service product
2. Map each to: pain solved, score, competitive gap, integration needs (from Phase 2)
3. Define MVP scope per product (v1 vs v2 features)
4. Name each service (branded names, not descriptions)
5. **Output:** Product catalogue with pain mapping, gap mapping, MVP scope
6. **Gate:** Every product tied to a 20+/30 pain. No product without a validated gap.

---

## Phase 5: Bundle Strategy

**REQUIRES verified web research for ALL pricing claims.** Use deepthink / extended thinking. Pull exact competitor tiers from their public pricing pages, not summaries — Perplexity for source-URL discovery, WebFetch for the actual pricing page, nothing taken from AI-generated answers (save raw to evidence/raw/, then grep-verify per reference/evidence-ledger-protocol.md).

1. Bundle vs standalone analysis — which products are stronger together?
2. Run verified web research for competitor pricing (exact tiers, not estimates). Use Perplexity to find the pricing page URLs, then WebFetch each page for verbatim tier/price data (save raw to evidence/raw/, then grep-verify per reference/evidence-ledger-protocol.md).
3. Design ascension path (entry → mid → premium → managed)
4. Pricing: setup + monthly (never just one-time, per `/ai-service-designer` rules)
5. Contrast principle: bundle price < sum of individual products
6. **Output:** Tiered bundle structure + pricing + competitor benchmark table + ascension path
7. **Gate:** Every price point validated against 2+ competitor benchmarks via verified web research. Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.
8. **Weak-signal handling.** If a price point has only ONE competitor benchmark, that is weak signal — not a gate pass. Weak signal REQUIRES all of: (a) run all five hidden-pricing discovery techniques from `reference/pricing-benchmarks.md` Section 3, (b) enter the weak-signal pricing into the Phase 7 risk register, (c) schedule a 90-day pricing re-evaluation based on close-rate / churn signals, (d) tighten the Phase 11 validation ramp (more customers, smaller price steps). Proceeding to Phase 6 on one benchmark WITHOUT completing a-d fails the gate.

**Deep-dive support:** [`reference/pricing-benchmarks.md`](reference/pricing-benchmarks.md) covers the full research protocol, hidden-pricing discovery techniques (G2 review mining, team-size proxies, investor leaks), tier-spacing rules (3-4× multiplier), guarantee design, and the pass/weak/fail patterns for the 2-benchmark validation rule.

---

## Phase 6: Resource Manifest [BUILDER]

**Use deepthink.** Exact costs, not estimates. No "TBD" entries.

1. Tech stack: each service/API, exact vendor, exact pricing tier
2. Per-customer cost of goods sold at target usage level
3. Team: roles needed at each scale (solo → 10 → 50 → 100 customers)
4. Infrastructure: hosting, monitoring, backups, disaster recovery
5. Unit economics table at 10 / 50 / 100 / 500 customers
6. **Output:** Full bill of materials with monthly costs at each scale + margin analysis
7. **Gate:** Complete BOM. Every line has a dollar figure. No TBD.
8. **"TBD pending pilot" is still TBD.** Every line needs a current-best-estimate dollar figure grounded in published vendor pricing, research, or a real quote from a signed NDA. Post-pilot validation refines the estimate — it does not replace the estimate. The gate exists so Phase 12 can cross-check bundle pricing (Phase 5) against margins (Phase 6) with real numbers BEFORE demand validation in Phase 11. Skipping this breaks the whole phase sequence.
9. **Concrete next steps:** [specific actions to validate costs or secure access]

---

## Phase 7: Operational Risk Analysis [BUILDER]

**Use deepthink.** Includes competitive moat audit.

1. Technical risks (API changes, vendor lock-in, latency, accuracy thresholds)
2. Market risks (demand shift, regulation change, economic downturn)
3. Competitive risks: **moat audit** — what stops a funded competitor copying this in 90 days?
4. Scaling bottlenecks (support per customer, ops overhead, single points of failure)
5. For EACH risk: likelihood (H/M/L), impact (H/M/L), mitigation, trigger signal
6. **Output:** Risk register + moat analysis + mitigation plan
7. **Gate:** Every identified risk has a documented mitigation. Any H/H risk without mitigation = **STOP.** Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.
8. **Concrete next steps:** [specific actions to reduce top 3 risks]

---

## Phase 8: Scaling SOPs [BUILDER]

1. Customer onboarding: step-by-step from signed contract to live system
2. Support model: tiers, response times, escalation paths
3. Capacity planning: max customers per support person, when to hire
4. Monitoring: dashboards, alerts, SLAs
5. **Output:** Written SOPs for onboarding, support, hiring triggers, monitoring
6. **Gate:** SOPs are specific enough that someone else could execute them.
7. **Concrete next steps:** [first SOP to implement, first hire trigger to monitor]

---

## Phase 9: Regulatory Specifics [BUILDER]

1. Industry-specific compliance checklist (state-by-state if applicable)
2. Licence requirements for operation in target markets
3. Insurance minimums (professional indemnity, public liability, cyber) with provider quotes
4. Privacy obligations (applicable data-protection law, breach notification, cross-border data)
5. AI-specific regulations (transparency, automated decision-making disclosure)
6. **Output:** Compliance checklist with responsible party + deadline for each item
7. **Gate:** Checklist complete. No "unknown" entries. All costs estimated.
8. **Concrete next steps:** [first 3 compliance items to action]

---

## Phase 10: Build Plan

1. MVP scope: exact features for launch (from Phase 4 v1 definitions)
2. Sprint milestones: weekly plan for 4-8 weeks
3. Demo-first vs live-first decision with rationale
4. **Demo-to-live gap analysis:** what's real vs faked in demo, engineering effort to close each gap
5. Dependencies and critical path
6. **Output:** Weekly build timeline + demo gap analysis + launch checklist
7. **Gate:** Concrete weekly plan with deliverables. No "explore" or "research" tasks in sprint 1.

---

## Phase 11: Validation Design

1. How to test demand before full build (demo calls, landing page, letters of intent, Loom videos)
2. Outreach strategy: who to contact, what channel, what script (copy work delegated to the Week 3 copywriting skill)
3. Success metrics per test (calls booked, demo completion, willingness to pay)
4. **Pricing progression** — ramp methodology to discover price through early customers:
   - Start FREE for first 5 customers (buy testimonials and reps, not revenue)
   - After 5: set a price. Increase by 20% every 5 customers until you hit price resistance (close rate drops significantly)
   - Stop raising when volume drops — that's your market price
   - Validation pricing ≠ launch pricing. Phase 5 benchmarks set the ceiling; this ramp finds the floor customers will accept
   - Track: what price did each customer accept? What was the close rate at each tier? This data feeds Phase 5 bundle pricing refinement
5. **Kill criteria:** Explicit STOP conditions (e.g., "if <2 of 5 calls show willingness to pay $X+, STOP"). Write criteria BEFORE the calls run — retro-fitting criteria to results destroys the discipline.
6. **Kill criteria format — MANDATORY.** Every kill criterion must contain: **(a)** a target count of calls or participants (e.g., "10 calls"), **(b)** a numeric count threshold (e.g., "≥4 of 10"), **(c)** a single binary outcome per threshold (e.g., "willingness to pay $249+/mo"). Fuzzy quantifiers are rejected: no "some", "most", "moderate", "a few", "strong tone", "genuine interest", "open to the idea". If you cannot write a kill criterion with a count, a threshold, and a binary outcome, you have not defined a kill criterion — you have defined a hope. Phase 12 step 3 checks this explicitly.
7. **CONDITIONAL verdict:** If validation returns split signal — problem confirmed but pricing or target-segment unclear — do NOT force a binary GO/KILL. Return CONDITIONAL with a specific, bounded next action (e.g., "5 more calls in the X segment"). See `reference/vertical-playbooks.md` Example 3 for the pattern.
8. **Output:** Validation plan + outreach script + pricing ramp schedule + kill criteria + timeline
9. **Gate:** GO/NO-GO/CONDITIONAL criteria defined with specific numbers (count + threshold + binary outcome per step 6). Pricing ramp schedule includes starting price and increment plan. Human executes validation. Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.

---

## Phase 12: Implementation Verification

1. Read all prior phases in the strategy file
2. Check: every recommendation cites a phase number or a verified web source (URL fetched directly)
3. **Check: Phase 11 kill criteria are formatted correctly.** Each criterion has (a) target count, (b) numeric threshold, (c) binary outcome. Reject any criterion using fuzzy quantifiers ("some", "most", "moderate", "a few", "strong tone", "genuine interest"). Fuzzy criteria = flag + send back to Phase 11.
4. Check: no phase has status "-" or "IN-PROGRESS"
5. Check: all gates passed
6. Cross-reference: bundle pricing (Phase 5) vs resource manifest margins (Phase 6)
7. Cross-reference: build plan (Phase 10) vs resource manifest stack (Phase 6)
8. Check: **Phase 2 Integration Viability** — verified write access path for platforms covering >50% of the addressable market AS DEFINED IN PHASE 1. Do not redefine the addressable market in Phase 12 to dodge the gate. If not verified, flag as gap and send back to Phase 2.
9. **Verify Phase 11 was EXECUTED, not just designed.** Kill criteria on paper do not count. Confirm validation calls happened: dates, participant initials or first-names, brief call notes, close-rate or willingness-to-pay signal per call. A Phase 11 verdict with no execution log = FAIL. Send back to Phase 11 for actual execution. The skill designs validation; the human executes it; Phase 12 verifies it happened.
10. **Output:** Verification checklist + gaps found + Phase 11 execution log confirmation + FINAL GO/NO-GO/CONDITIONAL recommendation
11. **Gate:** All 11 prior phases GREEN AND Phase 11 execution verified. Any gap = flag and send back to that phase. Counts feed from `evidence/evidence.md` ledger entries with `[E:S#]` tags, not from agent recall. `[A]` (assumption) entries don't count.

---

## Hard Rules

1. **No claim without source** — cite a phase number or a verified web source (URL fetched directly, not AI summary)
2. **`/market-pain` is prerequisite** — Phase 1 gate-checks completion. No exceptions.
3. **Legal before pricing** — Phase 3 must complete before Phase 5
4. **Integration before architecture** — Phase 2 must complete before Phase 4
5. **Every builder phase (6-9) ends with concrete next steps** — not "consider" but "do X, here's how"
6. **Deepthink for configuration** — Phases 5, 6, 7 require extended thinking
7. **No pricing without verified research** — Phase 5 and any pricing claims require competitor URLs fetched directly, not AI-summarised

## Anti-Patterns

1. **Skipping to build plan** — Phases exist for a reason. No jumping to Phase 10.
2. **Estimated pricing** — "around $200/mo" fails Phase 5 gate. Get exact tiers by fetching competitor pricing pages directly.
3. **Generic SOPs** — "provide good support" fails Phase 8 gate. Specifics required.
4. **Orphan products** — Any service not tied to a 20+/30 pain point gets cut in Phase 4.
5. **Ignoring legal for speed** — Phase 3 is mandatory before pricing. RED blocker at Phase 10 wastes all downstream work.
6. **Copy-paste from pain report** — Synthesise and build on findings. Don't repeat them.
7. **Forgetting the human** — Phases 4, 11 generate scripts. The human executes calls. AI cannot validate demand.
8. **"TBD" in Resource Manifest** — Phase 6 requires dollar figures. Research until you have them.

## Common Mistakes

| Mistake | Fix |
|-|-|
| Running Phase 5 before Phase 3 | Legal blocks kill pricing work. Always legal first. |
| Designing services without integration check | Phase 2 before Phase 4. Can't build what can't connect. |
| No kill criteria in validation | Phase 11 REQUIRES explicit STOP numbers. |
| Recommending without citing research | Every claim needs a phase number or a verified web source (URL fetched directly). |
| Builder phases without next steps | Phases 6-9 MUST end with actionable items, not observations. |
| Pricing without benchmarks | Phase 5 requires 2+ competitor benchmarks per price point. |
