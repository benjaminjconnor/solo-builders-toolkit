# Product Strategy — Vertical Playbooks

Three end-to-end worked examples showing the 12-phase workflow applied across different verticals and geographies. Each walks through the phase-by-phase decisions, surfaces the gate that protected (or would have protected) the solo builder, and ends with the verdict.

The outcomes are deliberately mixed: one clean GO, one KILL at Phase 3, one CONDITIONAL GO where Phase 11 validation returned ambiguous pricing signal. Read all three — the KILL and CONDITIONAL examples carry as much teaching as the GO.

All three are fictional composites. Names, clients, and platform details are illustrative. Follow the SKILL.md phase order exactly regardless of which example you pattern-match against.

---

## Example 1 — Cypress Ledger CPA (clean GO)

**Vertical**: US regional accounting (East Coast, Philadelphia metro)
**Team**: 11 people — 1 managing partner, 2 senior accountants, 6 bookkeepers, 2 admin
**Revenue**: ~$1.6M/year, 140 active small-business clients
**Pain summary** (from `/market-pain`): document chasing 26/30, admin-bottleneck 25/30, onboarding chaos 22/30

### Phase 1 — Pain Validation ✓

Pain report complete. All three top problems qualify (20+/30) with multi-source evidence and identified competitor gaps.

| Problem | Score | Gap |
|-|-|-|
| Document chasing | 26/30 | Multi-channel escalation (email → SMS → scheduled check-in) — incumbents do email-only |
| Admin bottleneck | 25/30 | Structured intake flow that auto-routes to the right bookkeeper by client tier |
| Onboarding chaos | 22/30 | Checklist-to-task-list auto-conversion plus template library — all incumbents are generic wizards |

**Gate**: PASSES. 3 problems at 20+. Proceed to Phase 2.

### Phase 2 — Integration Blueprint ✓

Dominant platforms in this segment (search term: "top cloud accounting platforms US small firm" on G2 category page for accounting software):

| Platform | API access | Default access | Small-company precedent | Write-access evidence | Verdict |
|-|-|-|-|-|-|
| Dominant cloud practice-management suite #1 | GATED | READ-WRITE | YES (3 sub-10-person integrators named in developer directory) | [VERIFIED: developer portal partner application, 4-6 week review, write scopes granted for invoicing + client records] | Integration viable |
| Dominant cloud accounting platform #2 | OPEN | READ-WRITE | YES (hundreds of public integrations) | [VERIFIED: public developer docs, OAuth self-service, write scopes unrestricted] | Integration viable |
| Document-management SaaS | OPEN | READ-WRITE | YES | [VERIFIED: REST API, no approval required] | Integration viable |

Standalone-viability verdict: product can launch MVP standalone (dedicated inbox + web review UI) in 2 weeks. Write-back to the two accounting platforms unlocks the premium tier at month 2.

**Gate**: PASSES. Both dominant platforms have open or gated-with-precedent write access. Proceed to Phase 3.

### Phase 3 — Legal & Compliance ✓

| Area | Rating | Reasoning |
|-|-|-|
| Data-protection law (state + federal) | GREEN | SOC 2 Type II not required for pilot; breach-notification obligations addressable via standard DPA |
| Financial-records regulation | GREEN | Bookkeeper-assisted review keeps final responsibility with the firm; no licensing required for the software itself |
| AI-specific disclosure | YELLOW | Firm must disclose automated extraction to clients; drafted a client-facing notice template |
| Insurance | GREEN | Tech-E&O policy $1.2M/year at $180/mo quote; acceptable |

No RED blockers. Total compliance startup cost: ~$2,200 (DPA templates + initial insurance + disclosure template). **Gate**: PASSES.

### Phase 4 — Service Architecture

Two named services:

1. **DocChase** — solves document chasing (26/30). MVP: dedicated ingest inbox, multi-channel escalation (email day 0, SMS day 3, phone-script prompt day 7), supplier-aware extraction schema, bookkeeper review queue, weekly ops report.
2. **IntakeFlow** — solves onboarding chaos (22/30). MVP: structured intake form, template library (trades, hospitality, allied health), auto-routing by client tier, task-list generation into the firm's existing project tool.

Both tied to 20+/30 pains with identified gaps. **Gate**: PASSES.

### Phase 5 — Bundle & Pricing

Three tiers, each validated against 2+ competitor benchmarks.

| Tier | Setup | Monthly | Benchmark citations |
|-|-|-|-|
| **Starter** (DocChase only, email-only escalation) | $0 | $189/mo | [VERIFIED: comparable-docchase.com/pricing — $150/mo email-only tier]; [VERIFIED: alternative-docs.com/pricing — $199/mo single-channel] |
| **Pro** (DocChase + IntakeFlow, full escalation, 3 users) | $2,500 | $549/mo | [VERIFIED: mid-market-firm-tool.com/pricing — $499/mo mid tier]; [VERIFIED: practice-ops-platform.com/pricing — $599/mo integrated tier] |
| **Firm** (full bundle, unlimited users, dedicated support) | $4,500 | $1,100/mo | [VERIFIED: enterprise-firm-ops.com/pricing — $1,200/mo premium]; [VERIFIED: multi-tenant-cpa-suite.com/pricing — $999/mo firm tier] |

Contrast: bundled Pro saves $160/mo vs buying two single-product tools. **Gate**: PASSES.

### Phase 6 — Resource Manifest

At 50 customers: LLM extraction ~$1,800/mo, SMS+voice ~$900/mo, OCR ~$1,100/mo, infra ~$380/mo, delivery labour ~$3,200/mo. Per-customer COGS ~$150/mo. Blended monthly revenue ~$24,500. Gross margin ~38% — below 50% target but workable at this scale; margin expands to 58% by 100 customers as delivery labour dilutes.

### Phase 10 — Build Plan

Week 1: discovery + inbox setup + extraction schema for top 5 supplier templates. Weeks 2-3: review UI + escalation engine. Week 4: integration write-back for accounting platform #2. Weeks 5-6: pilot with 3 friendly firms. Week 7: partner-application submission for platform #1. Week 8: launch.

### Phase 11 — Validation Design

Target: 10 discovery calls with US small-firm managing partners (11-30 staff segment). Outreach via LinkedIn inmail + warm intro through one senior accountant's network.

**Kill criteria**:
- If <6 of 10 calls confirm document-chasing as top-3 operational pain, STOP.
- If <4 of 10 show willingness to pay $499+/mo for Pro tier, drop pricing to Starter-only strategy.
- If <2 of 10 commit to 30-day pilot at free-tier, the demand signal is too soft — STOP and revisit in 6 months.

### End-state verdict

**GO**. All gates passed. Cypress Ledger represents a validated segment with open integration paths, no legal blockers, and benchmark-supported pricing. Build plan is concrete and kill criteria are explicit.

### What the 12-phase workflow caught

Phase 2 confirmed the dominant accounting platform has an OPEN API with no partner approval needed for the MVP — meaning a standalone launch can start generating revenue before the gated-platform partner application completes. Without Phase 2, the builder might have over-scoped the MVP to include both platforms from day one, delaying launch by 4-6 weeks waiting on partner review.

---

## Example 2 — Ashbourne Plumbing Services (KILL at Phase 3)

**Vertical**: UK independent plumbing, Manchester metro
**Team**: 14 people — 1 owner-operator, 8 field plumbers, 3 office, 2 apprentices
**Revenue**: ~£1.8M/year, mix of domestic emergency + commercial maintenance
**Pain summary** (from `/market-pain`): missed-calls 28/30, quote follow-up 24/30, emergency triage at odd hours 23/30

### Phase 1 — Pain Validation ✓

Pain report shows all three problems qualifying. Emergency triage scored particularly well because Ashbourne's owner flagged safety-critical delay costs (burst pipes after 8pm going to voicemail, insurance claims contested).

| Problem | Score | Gap |
|-|-|-|
| Missed calls | 28/30 | Multi-tool market but no UK-specific trade-vertical AI agent that also handles quote-follow-up chain |
| Quote follow-up | 24/30 | Trade-specific cadence (3-day → 7-day → 14-day) absent from generic CRM tools |
| Emergency triage | 23/30 | AI-classified urgency with route-to-on-call flow; gas-work triage promising as highest-value wedge |

**Gate**: PASSES. Proceed to Phase 2.

### Phase 2 — Integration Blueprint ✓

Dominant UK tools: two field-service SaaS platforms and one job-management suite (searchable via "top UK trades job management" on G2 + Capterra for field service category).

| Platform | API access | Default access | Small-company precedent | Write-access evidence | Verdict |
|-|-|-|-|-|-|
| Field-service SaaS #1 | OPEN | READ-WRITE | YES (public partner directory, 40+ small integrators) | [VERIFIED: developer portal, OAuth self-service, write scopes on job records + client records] | Integration viable |
| Field-service SaaS #2 | GATED | READ-WRITE | YES (named partners) | [VERIFIED: developer application, ~3 week review] | Integration viable |
| Job-management suite | OPEN | READ-ONLY | Limited (read-only partners only, no write confirmation) | [VERIFIED: API docs list no POST/PUT endpoints for job creation] | Standalone workaround needed |

Standalone MVP viable. **Gate**: PASSES.

### Phase 3 — Legal & Compliance ✗

This is where the strategy falls apart.

| Area | Rating | Reasoning |
|-|-|-|
| Data-protection law (GDPR applies) | GREEN | Standard DPA + breach-notification path; manageable |
| Trade-regulation body (general plumbing) | GREEN | No special licensing for AI-assisted scheduling or booking |
| **Gas-work regulation** | **RED** | Any triage or diagnostic guidance on gas-related calls must be performed by a certified engineer on the Gas Safe Register. An AI agent classifying a call as "gas-related, safe to wait" or "gas-related, book tomorrow" crosses into territory that the regulator treats as engineering judgement. Automated logic cannot legally substitute for certified human assessment on gas calls. |
| Insurance (professional indemnity) | YELLOW | Insurer would likely decline coverage for any automated gas-triage output; confirmed via pre-quote conversation with two UK trade-insurance brokers |

The proposed emergency-triage product was going to classify incoming calls by severity, and specifically flag gas-leak/gas-appliance calls for priority. After research:

- Gas Safe Register guidance explicitly requires gas-related diagnostic decisions to come from certified engineers.
- An AI that says "this sounds safe to wait until tomorrow" on a gas-appliance call is the regulator's worst case.
- Insurance brokers confirmed: no cover for AI-automated gas triage. Full liability sits on the business.

**Gate**: FAILS. RED blocker on the flagship feature. STOP or redesign.

### Redesign options surfaced (not the skill's job to pick — that's the owner's call)

1. **Drop gas-triage entirely** — ship missed-calls + quote-follow-up only. Kills the strongest urgency driver but the other two problems still score well. Re-run Phases 4-11 with a smaller scope.
2. **Route gas calls to a human agent** — AI handles initial capture, any gas-related keyword triggers immediate route-to-on-call certified engineer. No triage decision; the AI is purely a dispatcher. Legally defensible but product becomes thinner.
3. **Pivot vertical entirely** — electrical contractors, landscaping, or non-gas plumbing segments don't carry this blocker. Re-run `/market-pain` for an adjacent trade.

### End-state verdict

**KILL** on the original scope. Ashbourne's owner elected option 2 (route-gas-to-human) in the follow-up conversation; that restart begins a fresh Phase 1 with a redesigned service definition.

### What the 12-phase workflow caught

Phase 3 surfaced a legal blocker that would have otherwise emerged only after ~£20K of build spend and the first real gas-call incident. Without the gate-before-pricing rule, the builder would have priced, built, and launched a feature that carried uninsured regulatory exposure on every call. The KILL at Phase 3 saved that cost, and the redesign path is now on the owner's desk rather than being forced after a bad event.

---

## Example 3 — Wildroot Provisions (CONDITIONAL GO, ambiguous Phase 11)

**Vertical**: DTC specialty pantry subscription, based in Toronto
**Team**: 8 people — 2 founders, 2 ops, 2 customer care, 1 marketing, 1 warehouse lead
**Revenue**: ~C$950K/year, 4,200 active subscribers, avg order value C$58
**Pain summary** (from `/market-pain`): box churn at months 3-6 (24/30), SKU-curation fatigue for subscribers (22/30), customer-service volume spikes (21/30)

### Phase 1 — Pain Validation ✓

All three problems qualify. Churn is the headline — 24/30 with competitor gaps in how incumbent subscription-box platforms handle the 3-6 month "I'm bored of this" drop-off.

| Problem | Score | Gap |
|-|-|-|
| Mid-tenure churn | 24/30 | Pause-vs-cancel flow with AI-curated "refresh your box" suggestions; incumbents offer binary cancel-or-continue |
| Curation fatigue | 22/30 | AI that adapts box composition based on skip/keep history; incumbents ship everyone the same monthly box |
| CS volume spikes | 21/30 | AI-triaged inbound (where's my order, can I pause, swap this item); incumbents route everything to humans |

**Gate**: PASSES.

### Phase 2 — Integration Blueprint ✓

Dominant platforms for DTC subscription commerce:

| Platform | API access | Default access | Small-company precedent | Write-access evidence | Verdict |
|-|-|-|-|-|-|
| Headless commerce platform (the dominant DTC store builder) | OPEN | READ-WRITE | YES (thousands of public apps) | [VERIFIED: public developer docs, OAuth, write scopes on customers + subscriptions + orders] | Integration viable |
| Subscription-management app (most-installed in the DTC-subscription category) | GATED | READ-WRITE | YES (partner directory) | [VERIFIED: partner application, ~2 week review for subscription-mutation scopes] | Integration viable |
| Helpdesk SaaS (dominant CS platform for DTC) | OPEN | READ-WRITE | YES | [VERIFIED: REST API + webhooks, self-service] | Integration viable |

**Gate**: PASSES. All three integrations viable within 4 weeks.

### Phase 3 — Legal & Compliance ✓

| Area | Rating | Reasoning |
|-|-|-|
| Canadian federal privacy law (PIPEDA) | GREEN | Standard consent + data-handling path |
| Provincial consumer-protection (ON) | GREEN | Subscription cancellation must remain easy; no AI obstacle to cancel path required |
| Payment-data handling | GREEN | Tokenized via platform; we never see card data |
| Cross-border data flow (US processors) | YELLOW | Addressable via DPA + disclosure in privacy policy |

No RED. **Gate**: PASSES.

### Phase 4 — Service Architecture

Two named services:

1. **BoxKeep** — solves mid-tenure churn (24/30). AI-driven pause-vs-cancel flow + curated "refresh" suggestions based on skip/keep history. MVP: rules-based flow in month 1, LLM-enhanced suggestions in month 2.
2. **BoxFit** — solves curation fatigue (22/30). Adaptive box composition engine using subscriber preference signal (skips, feedback, purchase history). MVP scope: suggestion-mode (humans approve), full-auto mode later.

### Phase 5 — Bundle & Pricing

| Tier | Setup | Monthly | Benchmark citations |
|-|-|-|-|
| **Starter** (BoxKeep only) | $0 | $249/mo | [VERIFIED: churn-app.com/pricing — $199/mo starter]; [VERIFIED: retention-tool.com/pricing — $279/mo base] |
| **Pro** (BoxKeep + BoxFit) | $1,500 | $549/mo | [VERIFIED: curation-app.com/pricing — $499/mo]; [VERIFIED: dtc-retention-suite.com/pricing — $599/mo] |

### Phase 6 — Resource Manifest

At 40 customers: LLM ~$900/mo, infra ~$280/mo, delivery labour ~$2,200/mo. Per-customer COGS ~$85/mo. Monthly revenue ~$18,000. Gross margin ~52%. Healthy.

### Phase 10 — Build Plan

Weeks 1-2: rules-based pause-vs-cancel flow (BoxKeep MVP). Weeks 3-4: helpdesk integration for CS triage. Weeks 5-6: BoxFit preference engine. Week 7: pilot with Wildroot + 2 others. Week 8: launch.

### Phase 11 — Validation Design

Target: 10 discovery calls with DTC subscription founders (2K-10K active-subscriber segment) in North America.

**Kill criteria**:
- GO: 6+ calls confirm mid-tenure churn as a top-3 problem AND 5+ show willingness to pay $249+/mo for Starter tier.
- NO-GO: <4 confirm the problem OR <2 show willingness to pay $249+/mo.
- AMBIGUOUS: problem confirmed by 6+ calls BUT willingness to pay splits — some accept $249, some want $99-129 range. This is the CONDITIONAL zone.

### Phase 11 result (what the validation calls actually returned)

10 calls completed over 3 weeks.

- Problem confirmation: 8/10 confirmed mid-tenure churn as a real problem. **STRONG**.
- Willingness to pay at $249 Starter: 4/10 accepted, 3/10 countered at $99-129, 3/10 said "interesting but not now".
- Willingness to pay at $549 Pro: 2/10 accepted, 5/10 said "too high for our current scale".

Net: the problem is real. The pricing ceiling is unclear. Founders in the 2K-5K subscriber range want something closer to $99-149/mo; founders in the 5K-10K range can justify $249+ but want the Pro bundle features bundled into that price.

**Gate**: AMBIGUOUS. Kill criteria for NO-GO not met (problem is validated). Kill criteria for clean GO not met (willingness-to-pay at target pricing is split).

### CONDITIONAL GO with specific next step

The skill returns CONDITIONAL — not a forced decision, but a required action before commit:

- Run 5 additional calls exclusively in the 5K-10K subscriber range.
- If 4+ of those 5 accept $249 Starter, clean GO on the original pricing with tighter targeting.
- If 2+ of those 5 still resist, drop to a two-tier structure — $149 Starter / $399 Pro — and re-benchmark competitors at those price points.

Do not commit the 6-week build plan until the extra 5 calls return a clearer signal.

### End-state verdict

**CONDITIONAL GO** pending 5 more targeted validation calls. The ambiguity is on pricing ceiling, not demand. Problem-fit is strong; price-fit needs more data.

### What the 12-phase workflow caught

Phase 11's explicit kill criteria forced additional data-gathering instead of committing on founder instinct alone. The pattern-matching temptation on 8/10 problem-confirmation was strong — many builders would have declared GO and moved to build. The criteria-before-commit discipline surfaced that pricing signal was not yet calibrated. The cost of 5 more calls is ~2 days; the cost of building at a wrong price and having to re-cut pricing mid-launch is 6-8 weeks.

---

## Patterns across the three examples

### What the GO example had that the KILL didn't

Cypress Ledger's Phase 3 surfaced only YELLOW flags with known mitigations (disclosure template, standard DPA, tech-E&O insurance at acceptable cost). Ashbourne's Phase 3 surfaced a RED blocker on the flagship feature that no amount of product design could engineer around — the regulation prohibits the specific automated decision the product was built to make.

The structural difference: Cypress's regulations govern *how* the service operates (disclose, handle data properly, carry insurance). Ashbourne's regulation governs *whether* the service can operate at all on the key use-case. Insurance mitigations can solve the first. The second requires redesign.

### Kill-criteria discipline across all three

Every example carried explicit kill criteria entering Phase 11, with specific numbers. Cypress's "6 of 10 confirm top-3 pain" would have been testable. Ashbourne's product never reached Phase 11 because Phase 3 killed it first — but the Phase 11 criteria would have been drafted alongside the design, not after. Wildroot hit kill criteria that returned AMBIGUOUS, and the skill returned CONDITIONAL GO with a specific next-action instead of forcing a GO or a KILL.

The common thread: criteria were set BEFORE validation, not derived from results. That is the discipline that prevents founder-instinct post-hoc rationalisation.

### How Phase 2 Integration Viability Gate performs across different vertical types

Three different vertical types, three different integration landscapes:

- **Cypress (accounting)** — a gated-but-precedented platform plus an open platform. Both pass the gate but via different paths (partner application vs self-service).
- **Ashbourne (trades)** — mostly open APIs with strong precedent. The gate was never the blocker; the legal gate was. Phase 2 correctly said "integration is viable" — it was Phase 3's job to catch the regulatory blocker.
- **Wildroot (DTC)** — all three dominant platforms viable within a month. Integration was the easiest gate. The Phase 11 pricing ambiguity was the harder test.

The lesson: Phase 2 is necessary-but-not-sufficient. A vertical with perfect integration viability can still fail Phase 3 (legal) or Phase 11 (validation). Run the phases in sequence and trust the gate sequence.

### When CONDITIONAL GO is the right verdict vs a forced decision

Wildroot's ambiguous Phase 11 result is a pattern most solo builders misread. The temptation is to call it GO (because the problem is validated) or NO-GO (because the pricing isn't clean). Both are wrong — the skill's job is to return CONDITIONAL with a specific data-gathering action.

CONDITIONAL is the right verdict when:
- Problem-fit is confirmed (demand exists) BUT
- One specific variable is under-calibrated (pricing, target segment, feature scope), AND
- Additional data can resolve it within days not months.

CONDITIONAL is NOT the right verdict when:
- Problem-fit is weak (that's a NO-GO).
- Pricing is clear but the demand isn't (also NO-GO).
- The ambiguity is foundational (wrong vertical, wrong business model) — that calls for a restart, not a conditional.

Forcing a binary GO/KILL on an ambiguous signal destroys the skill's value. The CONDITIONAL verdict exists precisely to prevent that forcing function.

---

## How to use these playbooks

When you're running the skill on your own vertical:

1. After Phase 2, pattern-match your integration landscape against the three examples. If it resembles Ashbourne (open APIs, strong precedent), make sure Phase 3 gets the rigour.
2. After Phase 3, check whether any RED flags emerged on the flagship use-case specifically. A RED flag on a secondary feature is a scope cut; a RED flag on the headline value proposition is a redesign.
3. When drafting Phase 11 kill criteria, write them BEFORE the calls. Cypress's "6 of 10 confirm top-3 pain" works because it was committed to upfront. If you retro-fit criteria after seeing results, the discipline is gone.
4. If Phase 11 returns ambiguous, use the Wildroot template: specify exactly which 5-10 more data points would resolve the ambiguity, and commit not to build until that data comes in.

Follow the phases in order. Respect the gates. Trust the sequence even when a vertical you really want to work is being stopped by a gate earlier than Phase 12.
