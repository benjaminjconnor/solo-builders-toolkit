---
name: validate-opportunity
description: Use when you have a raw business idea for a specific industry + geography and need to decide whether to build it. Triggers on "validate opportunity", "validate this idea", "should I build [X]", "validate [industry]", "end-to-end validation", "run the full validation", "pain to build plan", "opportunity capstone", or any time a solo builder asks "is this vertical worth it?" with industry + idea in hand. Orchestrates /market-pain → /product-strategy → /ai-service-designer into one gated workflow with a consolidated GO / KILL / CONDITIONAL verdict and full evidence trail.
---

# Validate Opportunity

Sequential orchestrator. Takes an industry + geography + raw idea. Chains three existing skills — `/market-pain`, `/product-strategy`, `/ai-service-designer` — through gates that kill dead opportunities early and produce a consolidated build plan for live ones. Output is a single traceable report.

**Core rule:** **every claim in the final report cites the stage and phase that produced it.** No claim without a stage citation. No stage advance without its predecessor's gate passing. No gate bypass for any reason.

**This is a RIGID orchestrator.** No mental simulation of skills — actually invoke them. No paraphrasing their gates — honor them. No inventing phases — use what the underlying skills define.

---

## When to use

- You have a raw business idea + a target industry + a target geography and want a yes/no with evidence.
- You want to avoid spending 6 weeks on a vertical that `/market-pain` would have killed on day one.
- You want the `/market-pain` → `/product-strategy` → `/ai-service-designer` chain run once, end-to-end, with the consolidation and traceability the individual skills don't provide.

**NOT for:**
- Polishing an already-validated opportunity (use the individual skills).
- Brainstorming a raw idea from scratch (use `/ai-service-designer` brainstorm mode).
- Re-running validation on a vertical that already has a current, signed-off build plan.
- Single-skill needs (run the specific skill directly — don't orchestrate for one step).

---

## Inputs

Three required. Accept as slash-command arguments, or prompt interactively if missing.

| Input | Required | Example |
|-|-|-|
| `industry` | Yes | `commercial roofing contractors` |
| `geography` | Yes | `US midwest`, `UK`, `Ontario`, `ANZ` |
| `raw_idea` | Yes | `AI agent for quote follow-up — drafts personalised messages to unsigned quotes and flags hot leads for callback.` |

**Interactive prompt template** when any input is missing:

> Three inputs needed:
> 1. **Industry** — the specific vertical (e.g., "commercial roofing contractors", "independent bookkeeping practices", "solo physiotherapy clinics"). Broad categories like "SMBs" are too vague.
> 2. **Geography** — country + region or metro (e.g., "US midwest", "UK", "Toronto-Ottawa corridor"). Regulation, platform mix, and purchasing power vary by geography.
> 3. **Raw idea** — 1-2 sentences describing what you'd build. Verb + noun + who-it's-for. No need to name features.

Do NOT proceed to Stage 1 until all three are present.

---

## The chain

```
INPUT: industry + geography + raw_idea
   │
   ▼
STAGE 1 — /market-pain [industry] in [geography]
   │
   ├─ Kill Switch #1 FAIL (<5 complaints in Phase 1)         → EXIT KILL
   ├─ Kill Switch #2 FAIL (no problem 20+/30 in Phase 2)     → EXIT KILL
   ├─ Kill Switch #3 FAIL (Phase 2.5 economics)              → EXIT KILL
   ├─ Kill Switch #4 FAIL (Phase 4 calls <5 confirmed)       → EXIT KILL
   │
   ▼ (Phase 4 complete, 3+ problems 20+/30, Phase 2.5 passed, 7+ confirmed in Phase 4 OR 5-6 after refine)
STAGE 2 — /product-strategy [industry]
   │
   ├─ Phase 1 FAIL (no valid pain report)                    → EXIT KILL (loop back to Stage 1)
   ├─ Phase 2 RED (integration viability: single-platform
   │   ≥30% READ-ONLY or all paths GATED-RED/NONE)           → EXIT KILL
   ├─ Phase 3 RED (legal blocker)                            → EXIT KILL
   ├─ Phase 5 gate fail (no benchmarks AND weak-signal
   │   remediation not completed)                            → EXIT KILL
   ├─ Phase 6 gate fail (BOM has TBD)                        → EXIT CONDITIONAL (remediate)
   ├─ Phase 7 gate fail (H/H risk without mitigation)        → EXIT KILL
   ├─ Phase 11 gate fail (kill criteria fuzzy OR split signal) → EXIT CONDITIONAL
   ├─ Phase 12 gate fail (any prior phase has gap)           → CONDITIONAL (remediate the flagged phase)
   │
   ▼ (all 12 phases GREEN, Phase 11 executed with log)
STAGE 3 — /ai-service-designer (Scope + Build Plan modes)
   │
   └─► Consolidated report written to
       docs/strategy/[industry-slug]/validate-opportunity-report.md
```

Exit on the FIRST failing gate. Do not attempt downstream stages. Preserve all intermediate artifacts produced up to the exit point.

---

## Input modes

### Mode 1 — Start fresh

`/validate-opportunity [industry] [geography] [raw_idea]` or interactive prompt.

1. Create `docs/strategy/[industry-slug]/` if missing (slug = lowercase, hyphenated).
2. Write initial `validate-opportunity-report.md` with frontmatter (industry, geography, raw_idea, verdict: IN PROGRESS, started-date).
3. Proceed to Stage 1.

### Mode 2 — Resume (reuse existing artifacts)

Check `docs/strategy/[industry-slug]/` for existing artifacts:

| Artifact | Reuse if |
|-|-|
| `[industry-slug]-pain-report.md` | File exists AND `last modified <90 days` AND Phases 1-4 complete (check by reading the phase status/headings) |
| `[industry-slug]-product-strategy.md` | File exists AND `last modified <90 days` AND any of Phases 1-12 complete |
| `validate-opportunity-report.md` | Previous run exists — show summary to user, ask whether to resume or start fresh |

**Reuse decision:**

- Pain report recent + complete + passed all 4 kill switches + industry+geography+platform match → **skip Stage 1's re-run**, load findings from the report, proceed to Stage 2. Note "Stage 1 reused from [date]" in the consolidated report.
- Pain report recent but only Phases 1-3 complete (no Phase 4 execution log) → **do NOT skip**. Phase 4 is mandatory before any BUILD decision per `/market-pain` rules. Run Stage 1 from Phase 4.
- Pain report stale (>90 days) → **re-run Stage 1**. Market shifts, platform rules change, new competitors enter.
- Pain report geography mismatch → **re-run Stage 1**. Geography-specific findings don't transfer (e.g., US regulation ≠ UK regulation).
- Pain report is a KILL report (triggered any `/market-pain` kill switch) → **do NOT reuse for a GO decision**. The kill is the answer. Resume mode only reuses reports that PASSED all 4 kill switches. If the builder wants to retry the same vertical, it's a re-run (industry may have shifted), not a resume.
- **Platform drift check (named)**: if the `raw_idea` names a dominant platform different from the one the pain report researched in Phase 3, **re-run Stage 1 Phase 3 at minimum**. Different platform = different API access, different competitor set, different gap durability. Example: pain report researched Xero-integrating tools; new idea says FreshBooks — Phase 3 must re-run.
- **Platform drift check (market)**: before Stage 2 begins with a reused pain report, run 1-2 quick `perplexity_search` or WebFetch queries against current market share data to confirm the Phase 3 dominant platform is still dominant today. If the market's dominant platform has shifted (e.g., pain report said Xero at 60% share, current market data shows a new leader), re-run Stage 1 Phase 3 at minimum. Market share shifts meaningfully within the 90-day window in fast-moving verticals.

**Never** skip Stage 1's Phase 4. Online complaints reveal pain; calls reveal purchasing behavior. No validated demand without Phase 4 execution log.

---

## Stage 1 — /market-pain

**Purpose:** validate the pain exists, score urgency, check economics, verify gap, design + execute human validation calls.

### Dispatch

Invoke `/market-pain [industry] in [geography]`. The skill runs its own 4-phase mandatory chain (Phase 1 Problem Mining → Phase 2 Scoring → Phase 2.5 Economic Viability → Phase 3 Solution Gap → Phase 4 Conversation Guide). Honor every kill switch. Do not advance to Stage 2 until Phase 4 returns a confirmed go-signal (7+ calls confirmed or 5-6 after refine).

### Prerequisites checked here

- [ ] Phase 1 returned ≥5 distinct complaints
- [ ] Phase 2 top problem scores ≥20/30
- [ ] Phase 2.5 passed (viable segment ≥1,000 businesses at ≥$75/mo)
- [ ] Phase 3 documented competitor gaps + Platform Risk (GREEN/YELLOW/RED)
- [ ] Phase 4 executed — 10 calls with post-call scoring rubric completed, 7+ confirmed (or 5-6 after a refine round of 5 additional calls)

### Kill conditions

| Signal | Verdict | Report reason |
|-|-|-|
| Phase 1 <5 complaints | **KILL** | "Insufficient complaint volume in [industry] + [geography]. No market signal." |
| Phase 2 top score <20/30 | **KILL** | "Pain exists but not urgent enough. Top score: [X]/30 on '[problem]'." |
| Phase 2.5 economics fail | **KILL** | "Pain is real but economics don't work. Segment/price-ceiling from Phase 2.5." |
| Phase 3 Platform Risk RED (≥30% single-platform READ-ONLY + no standalone path) | **KILL** | "Dominant platform blocks integration. Cannot deliver full value at target price." |
| Phase 3 Platform Risk YELLOW | **CONDITIONAL** | "Gated API requires partner application. Remediate: acknowledge in risk register, plan 4-6 week approval window, tighten Phase 11 pricing ramp. Advance only after remediation." |
| Phase 4 <5 confirmed | **KILL** | "Online pain didn't convert to real-world purchase intent." |
| Phase 4 5-6 confirmed | **CONDITIONAL** (refine offer + 5 more calls). Only exit at <5 after refine. | "Partial validation. Refine offer description and retry." |

### Output (Stage 1)

`docs/strategy/[industry-slug]/[industry-slug]-pain-report.md` — the `/market-pain` report produced by the skill itself. Do not re-format or truncate it. This is the evidence trail for every Stage 2+ claim about pain.

### What Stage 1 gives Stage 2

Extract for handoff:

- Top 3 problems scoring 20+/30 (name + score + verbatim complaint)
- Phase 2.5 segments and price ceiling
- Phase 3 competitor set + Platform Risk rating + gap durability per problem
- Phase 4 call notes: willingness-to-pay per call, referrals offered, "what would it be worth" dollar figures

---

## Stage 2 — /product-strategy

**Purpose:** take the validated pain and turn it into a priced, architected, risk-assessed, validation-designed, verified build plan.

### Dispatch

Invoke `/product-strategy [industry]`. The skill checks for the pain report (produced in Stage 1), reads it, and runs 12 sequential phases. Honor every gate. Do not advance to Stage 3 until Phase 12 (Implementation Verification) returns ALL GREEN.

### Prerequisites checked here

- [ ] `/market-pain` artifact exists at the expected path, contains Phase 1-4 complete, has Phase 2.5 data
- [ ] Raw idea from the original input is represented in Stage 1's top 3 problems (if not, flag to user: "your raw idea doesn't match the validated pain — choose which to pursue")

### Kill conditions

| Phase gate | Verdict | Report reason |
|-|-|-|
| Phase 1 (pain validation) fails — `/market-pain` missing or incomplete | **KILL** | Loop back to Stage 1. This should not happen if Stage 1 exited cleanly. |
| Phase 2 (integration) RED — single-platform ≥30% READ-ONLY + no standalone viability, OR all platforms GATED-RED/NONE | **KILL** | "Cannot integrate with the platforms your market uses. Standalone product doesn't deliver enough value." |
| Phase 3 (legal) RED blocker | **KILL** | "Legal/regulatory barrier: [specific]. Two suggested next actions in the report: (a) redesign scope so the regulation doesn't apply, OR (b) pivot vertical — restart Stage 1 with a clarified industry string that sits outside the regulation's reach." |
| Phase 3 (legal) YELLOW | **CONDITIONAL** | "Compliance work required (specific). Must complete before Phase 5 pricing; acknowledge cost in Phase 6 BOM; re-run Phase 3 after remediation." |
| Phase 2 (integration) YELLOW (30-49% single-platform concentration on gated platforms) | **CONDITIONAL** | "Integration path exists but gated. Remediate: log in Phase 7 risk register, plan approval timeline, confirm standalone viability as fallback." |
| Phase 5 (bundle pricing) gate — no competitor benchmarks AND weak-signal remediation (hidden-pricing discovery + risk register entry + 90-day re-eval + tightened Phase 11 ramp) NOT completed | **KILL** | "Cannot price without competitor anchor. Pricing ceiling unknowable at decision quality." |
| Phase 6 (resource manifest) gate — BOM has TBD entries | **CONDITIONAL** | "Remediate TBD lines to current-best-estimate. Post-pilot refinement is not discovery." |
| Phase 7 (operational risk) gate — any H/H risk without documented mitigation | **KILL** | "Unmitigated high-likelihood/high-impact risk: [specific]. Mitigate or kill." |
| Phase 11 (validation design) gate — kill criteria use fuzzy quantifiers ("some", "moderate", "strong tone", "genuine interest") | **CONDITIONAL** | "Kill criteria must be count + threshold + binary outcome. Rewrite before calls run." |
| Phase 11 kill criteria are numeric but binary outcome relies on post-hoc interpretation of call logs | **CONDITIONAL** | "Binary outcome must resolve to YES/NO from the Phase 1-2 data itself (e.g., 'cites the exact pain from Phase 2 top problem #1' + 'quotes a specific dollar budget' + 'no implementation-timeline hesitation'). No criterion that requires judgement calls on call-log tone." |
| Phase 11 validation executed and returned split signal (problem confirmed but pricing/segment ambiguous) | **CONDITIONAL** | Specific bounded next action (e.g., "5 more calls in the X sub-segment"). |
| Phase 12 gate — any prior phase has unresolved gap | **CONDITIONAL** | Remediate the flagged phase before proceeding to Stage 3. |

### Phase execution requirements

`/product-strategy` has BUILDER phases (6, 7, 8, 9) that require deepthink-level effort and produce concrete next steps. Honor that discipline. Do not shortcut to a summary.

Phase 11 is DESIGNED by `/product-strategy` but EXECUTED by the human (validation calls). Phase 12 requires an execution log (dates, participant initials or first-names, call notes). No log = FAIL.

### Output (Stage 2)

`docs/strategy/[industry-slug]/[industry-slug]-product-strategy.md` — the state file produced by `/product-strategy`. Contains all 12 phases with gates, findings, and Phase 12 verification.

### What Stage 2 gives Stage 3

Extract for handoff:

- Named services from Phase 4 (product catalogue with pain mapping)
- Bundle structure + pricing + competitor benchmark table from Phase 5
- Tech stack + per-customer COGS + unit economics from Phase 6
- Risk register with mitigations from Phase 7
- Validation design + kill criteria from Phase 11
- Phase 10 build plan (weekly milestones)

---

## Stage 3 — /ai-service-designer

**Purpose:** polish the validated architecture into a sellable service package: positioning, HITL design, pricing confirmation against service-model rules, offer-ladder placement, first-customer approach.

### Dispatch

Invoke `/ai-service-designer` in **Scope** and **Build Plan** modes. Pass the Stage 2 outputs (named services, bundle pricing, tech stack, risk register, validation design) as scope inputs.

- **Scope mode** — produces scope-of-work structure, HITL pattern, risk register polish (adds hallucination/data-leakage/vendor-continuity entries if Stage 2 missed them).
- **Build Plan mode** — confirms tech-stack choices (LLM vs classical, buy/build/partner), HITL pattern per risk-bearing output, per-unit cost + margin at target price.

### Prerequisites checked here

- [ ] Stage 2 Phase 12 passed (all GREEN)
- [ ] Named services exist from Phase 4
- [ ] Bundle pricing validated against 2+ benchmarks from Phase 5
- [ ] BOM complete with no TBD from Phase 6

### Kill conditions

Stage 3 does not introduce new kills. It can surface service-design issues that send the work back to Stage 2 Phase 4 or 5:

- **Maturity mismatch** — proposed autonomy level >+2 from client's current maturity. Send back to Phase 4 for scope narrowing.
- **HITL pattern missing** on a risk-bearing output. Send back to Phase 7 to add the mitigation.
- **Pricing model misfit** (e.g., outcome-based priced without baseline measurement in place). Send back to Phase 5.

If Stage 3 sends work back, the verdict is **CONDITIONAL**, not GO. Fix + re-run Stage 3.

**Stage 3 send-back vs. mid-run re-run — not the same thing.** A Stage 3 CONDITIONAL that patches a specific `/product-strategy` phase (e.g., adding a missing HITL pattern to Phase 7, or confirming a pricing-model match in Phase 5) is a remediation of the Stage 2 artifact, not a full Stage 2 re-run. Document the patch in the Stage 2 artifact with a dated "Stage 3 feedback" note, update Phase 12 status to re-GREEN for the fixed phase, then re-run Stage 3 only. This is the ONE allowed exception to Hard Rule #12's "full restart from Stage 1" requirement — and it's only allowed because the Phase 12 cross-checks are still being honored (the remediation has to be verified, not assumed). If the Stage 3 feedback requires scope-level changes (e.g., drop a named service from Phase 4 entirely), that IS a full restart from Stage 1 with a clarified raw_idea.

### Output (Stage 3)

Service package documentation appended to `docs/strategy/[industry-slug]/[industry-slug]-product-strategy.md` under a "Stage 3 — Service Packaging" section. Contents:

- Positioning one-liner (not marketing copy — descriptive)
- Offer-ladder placement (free audit / paid project / retainer / premium)
- HITL pattern per service (review-before-send / sample-audit / escalation-on-uncertainty)
- Pricing model confirmation (setup + monthly default, deviations explained)
- First-customer acquisition sketch (referencing Stage 1 Phase 4 referrals where available)
- Per-service runbook sketch

---

## Consolidated report template

Every run produces `docs/strategy/[industry-slug]/validate-opportunity-report.md` with this structure. This is the single deliverable the builder reads.

```markdown
# Validate Opportunity — [Industry] ([Geography])

**Raw idea:** [verbatim from input]
**Verdict:** GO / KILL / CONDITIONAL
**Report date:** [YYYY-MM-DD]
**Stage 1 completed:** [date, or "skipped — reused from [date]"]
**Stage 2 completed:** [date, or "—" if killed earlier]
**Stage 3 completed:** [date, or "—" if killed earlier]

## Executive summary

[3-5 sentences. State the verdict and cite WHICH stage + phase produced the decision.
Example for KILL: "KILLED at Stage 2 Phase 3 — legal blocker: [specific regulation]. No redesign path because [reason]. Suggest pivot to [adjacent vertical] where the regulation doesn't apply, per the Stage 2 Phase 3 findings."]

## Stage 1 — Market pain validation

**Verdict:** PASS / FAIL
**Source artifact:** [docs/strategy/[industry-slug]/[industry-slug]-pain-report.md]

### Top 3 problems (from /market-pain Phase 2)

| Rank | Problem | Score | Top-line evidence |
|-|-|-|-|
| 1 | [problem] | XX/30 | "[verbatim quote]" [source URL] |
| 2 | [problem] | XX/30 | "[verbatim quote]" [source URL] |
| 3 | [problem] | XX/30 | "[verbatim quote]" [source URL] |

### Economic viability (from /market-pain Phase 2.5)

- Viable segment: [N businesses] at [$X/mo ceiling]
- Sell type: SWAP / NEW LINE ITEM
- Platform Risk: GREEN / YELLOW / RED

### Phase 4 execution log

- Calls run: [N] on [dates]
- Confirmed the problem: [N of N]
- Willingness to pay: [$X-$Y range]
- Referrals: [N offered]

## Stage 2 — Product strategy

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

## Stage 3 — Service design

**Verdict:** PASS / SEND BACK
**Source artifact:** [docs/strategy/[industry-slug]/[industry-slug]-product-strategy.md § Stage 3]

- Positioning: [descriptive one-liner]
- Offer-ladder placement: [rung]
- HITL pattern(s): [per-service]
- First-customer acquisition sketch: [channel + timeline]

## Decision

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
**Required next action:** [specific, bounded — e.g., "5 more Phase 4 calls in the [segment] sub-segment", or "complete Phase 6 BOM lines 3-5 with current-best-estimate quotes"]
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

## Hard rules

1. **No stage advance without the predecessor's gate passing.** Every exit condition above is binding. No gate bypass "because the idea sounds good."
2. **No claim in the consolidated report without a stage + phase citation** (or a fetched source URL from that phase). Uncited claims are a capstone failure, not a style issue.
3. **Actually invoke the underlying skill.** Mental simulation, paraphrasing, or "what that skill would say" is forbidden. The skills have their own kill switches, research protocols, and gate logic — use them as written.
4. **Preserve all intermediate artifacts on kill.** Never delete `/market-pain` output because `/product-strategy` killed the plan. The pain report remains evidence for a pivot-vertical decision later.
5. **Phase 4 execution log is mandatory.** No GO verdict without dates + participant initials/first-names + call notes from Stage 1 Phase 4 OR Stage 2 Phase 11 (or both if both ran). Designed kill criteria ≠ executed validation.
6. **Resume mode does not skip Phase 4.** If an existing pain report has Phases 1-3 but no Phase 4 execution log, Stage 1 must run Phase 4.
7. **Geography and industry lock at Stage 1.** If Stage 2 discovers the addressable market has to be redefined, that's a RESTART at Stage 1 with a clarified industry string — not a quiet redefinition in Stage 2.
8. **The verdict is the first failing gate.** Do not continue to later stages to "see what the output would look like." Exit on the first kill.
9. **Use brand-level model names, not dated versions.** "Claude", "GPT-4-class", "a frontier LLM". Never specific numbered versions (they date fast and violate the audit checklist).
10. **The underlying skills are locked.** If the capstone seems to need new methodology in `/market-pain`, `/product-strategy`, or `/ai-service-designer`, STOP and flag — don't edit them. Orchestrator is composition, not redesign.
11. **GREEN/YELLOW/RED gate mapping — explicit.** Several `/product-strategy` phases report GREEN/YELLOW/RED. Map to capstone verdicts as follows:
    - **GREEN** → stage advances.
    - **RED** → KILL (unless the skill's own gate says "redesign OR pivot"; then CONDITIONAL with a specific redesign task).
    - **YELLOW** → CONDITIONAL. YELLOW is NOT "proceed as GREEN." It means remediate the flagged item before advancing. Typical remediations: re-run the sub-phase with tighter scope, acknowledge the risk explicitly in the Phase 7 risk register with a named trigger signal, or tighten the Phase 11 validation ramp. Log the remediation in the consolidated report.
    - A run with even one YELLOW gate cannot emit GO. It's CONDITIONAL until the YELLOW is closed to GREEN.
12. **Stage inputs lock at stage entry.** Once Stage 2 starts reading Stage 1's pain report, Stage 1 is frozen for that run. Mid-run re-runs of an earlier stage require a full restart from Stage 1 with a fresh `docs/strategy/[industry-slug]/` folder (or an archived-then-overwritten one — preserve the old artifacts with a `-archived-[date]` suffix). No mixing of v1 and v2 findings across stages in a single consolidated report.

---

## Anti-patterns (from RED baseline findings)

These are the exact rationalizations a solo builder reaches for when running the three skills by hand. The capstone exists to make them impossible.

| Anti-pattern | What it looks like | Why it fails |
|-|-|-|
| **Score hallucination** | "Phase 2 top problems: quote follow-up 22/30, manual admin 21/30, no hot-lead signal 20/30" — invented without running Phase 1's complaint mining. | Scores come from evidence in Phase 1. Invented scores = invented market. |
| **Fake phase names** | "/product-strategy Phase 2: Concept" (the real Phase 2 is "Integration Blueprint"). | The underlying skills have specific phase numbers and names. Invention = not actually running the skill. |
| **Gate-bypass "assumed passable"** | "Phase 2: integration question ambiguous — assumed passable, proceeding to Phase 3." | Gates exist so you don't proceed with an open question. If a gate is ambiguous, the gate is FAILING — exit or remediate. |
| **Stage skipping** | "Stage 2 Phase 1-3 cover everything we need; we can go straight to Stage 3 for pricing." | Each phase gates the next for a reason. Stage 3 without Stage 2 Phase 6 = pricing without unit economics. |
| **Fake traceability** | Report says "Phase 3 Legal: CLEAR" without any Stage 2 artifact showing Phase 3 was actually run. | Traceability means citing the artifact. No artifact = no claim. |
| **Report hallucination** | Filling in Phase 5 pricing with round-number estimates because no competitor benchmark was found. | Phase 5 gate requires 2+ benchmarks per price point. No benchmarks = Phase 5 fails. Don't fake the output. |
| **Premature kill** | Kill at Phase 2 with top score 19/30 "since 20 is the threshold." | The skill's anti-inflation rule says scores lock at the original number. 19 IS a kill — that's the skill working. Not premature. |
| **Delayed kill** | Kill at Phase 2 with top score 19/30 rationalized back to 20 "because the next-highest problem is close, combining them is essentially 20+." | Scores are per-problem. No combining. 19/30 = KILL. |
| **Resume-mode bypass** | "An old pain report exists; reuse it. Phase 4 calls from 14 months ago are fine." | Market shifts. Pain reports expire at 90 days for Stage 1 reuse. Phase 4 is re-run if the execution log is stale. |
| **Skill methodology drift** | "Let me adapt `/market-pain` Phase 2 scoring to only 4 dimensions for this run to save time." | The underlying skills are locked. No in-flight edits. Run them as written or don't run them. |
| **Citing dated models** | Any specific numbered version in the report stack (e.g. a vendor name plus a numbered-point revision). | Model names in the consolidated report use brand-level only ("Claude", "GPT-4-class"). Audit rule + forward-compatibility. |

---

## Red flags — STOP and re-check

When you catch yourself thinking any of these, stop and re-check against the hard rules:

- "I can skip Phase 4 calls because the online pain was so strong." → Phase 4 is mandatory. Re-read `/market-pain` rules.
- "I'll write the consolidated report while Stage 2 is still running." → The report is written AFTER all stages complete. Interim status goes in the artifact files.
- "Phase 11 kill criteria like 'strong interest from most of the call set' are specific enough." → Not specific. Count + threshold + binary outcome. Re-read `/product-strategy` Phase 11 rule.
- "The raw idea is obviously good, we can shortcut to Stage 3." → Not an orchestrator. Back to Stage 1.
- "Stage 1 was run 6 months ago but the industry hasn't changed." → 90 days = stale. Re-run Stage 1.
- "Stage 3 surfaced a service-design issue; let's edit the Stage 2 output to fix it." → Stage 3 sends work back via CONDITIONAL verdict; don't silently retrofit Stage 2.
- "The pain report was for Portland, Oregon but this idea is US-wide — close enough." → Geography mismatch = re-run. State-level regulation, platform mix, and labour markets differ.
- "The pain report was for Xero-integrating tools but my idea is FreshBooks — most of it transfers." → Platform drift. Re-run Stage 1 Phase 3 at minimum. Different platform = different API, different competitors, different gap durability.
- "The existing pain report was a KILL, but that was 4 months ago — I want to try this vertical again." → Not resume mode. Start fresh Stage 1. A KILL report is not a reusable artifact.
- "Phase 3 came back YELLOW — basically GREEN, let's proceed." → YELLOW is not GREEN. Remediate per Hard Rule #11 before Stage 2 advances. A GO cannot be emitted with an outstanding YELLOW.

---

## Common mistakes

| Mistake | Fix |
|-|-|
| Running all 3 stages without checking resume mode | Check `docs/strategy/[industry-slug]/` FIRST. Reuse if <90 days + complete. |
| Writing the consolidated report without each stage's artifact file existing | Artifacts are the evidence. No artifact = no citation = no claim. |
| Naming the output file `validate-opportunity-report.md` without the industry slug subfolder | Multiple verticals collide. Use `docs/strategy/[industry-slug]/validate-opportunity-report.md`. |
| Treating Stage 3 as required even when Stage 2 killed the plan | Stages exit on first kill. Stage 3 does not run after a Stage 2 kill. Preserve Stage 2 artifact, emit KILL verdict. |
| Emitting "GO" when Stage 2 is CONDITIONAL | CONDITIONAL is CONDITIONAL. GO means Phase 12 GREEN + Phase 11 executed log. Don't round up. |
| Letting the raw idea override validated pain | If the raw idea maps to a problem that scored 15/30 while a different problem scored 27/30, flag this. The builder can pursue the 27/30 problem instead — but ASK, don't silently swap. |
| Quoting complaints without source URLs | Every verbatim quote in the consolidated report cites a URL from Phase 1's source table. No URL = UNVERIFIED = don't quote. |
| Generic "industry" input like "SMBs" | Reject and prompt for specificity. "Commercial roofing contractors" is actionable; "SMBs" is not. |
| Forgetting to ask about geography | Regulation + platform mix + purchasing power vary. Geography is required input, not optional. |

---

## Quality bar

A finished `/validate-opportunity` run must:

- Produce the consolidated report at `docs/strategy/[industry-slug]/validate-opportunity-report.md`
- Have the underlying stage artifacts alongside it (`[industry-slug]-pain-report.md`, `[industry-slug]-product-strategy.md`)
- State the verdict (GO / KILL / CONDITIONAL) in the first 5 lines of the report
- Cite stage + phase on every claim (or a fetched source URL)
- Include Phase 4 execution log (dates + participants + call notes) if the verdict is GO
- Include the specific kill reason with phase citation if KILL
- Include the specific required next action with stage+phase re-entry point if CONDITIONAL
- Produce something obviously more consolidated and traceable than running the 3 skills ad-hoc — if not, the capstone added no value and should not have been run

If any of those miss, the run is not complete. Fix the gap, re-run the affected stage, re-write the report.

---

## Cross-links

- `/market-pain` — Stage 1 dispatch target. Required prerequisite.
- `/product-strategy` — Stage 2 dispatch target. Required prerequisite.
- `/ai-service-designer` — Stage 3 dispatch target. Required prerequisite.
- `/storybrand-copy` — post-GO, for service-page copy.
- `/funnel-architect` — post-GO, for the sales funnel.
- `/pm` — post-GO, to manage the build plan execution.
