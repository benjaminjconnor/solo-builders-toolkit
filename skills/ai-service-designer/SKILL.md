---
name: ai-service-designer
description: Use when identifying AI automation opportunities for a client business, designing new AI service offerings, scoping a client engagement, or productising an existing service. Triggers on "new service idea", "automation opportunity", "what can AI do", "AI service", "what should we automate", "service design", "productise", "automation maturity", "scoping AI work", "AI capability map", "buy vs build vs partner", "LLM vs classical ML", "human in the loop", "risk register", "pricing model for AI service", "ops runbook".
---

# AI Service Designer

Design sellable AI-powered service offerings: identify automation opportunities, scope engagements, set pricing, map risks, and productise one-off work into recurring revenue.

Supporting reference material lives in `reference/`:

- `reference/frameworks.md` — 10 design frameworks (AI capability matrix, automation-maturity ladder, productisation stages, pricing-model selector, risk-register structure, buy/build/partner, LLM-vs-classical-ML, HITL patterns, offer-ladder mapping, discovery cadence)
- `reference/templates.md` — 8 fill-in-blank templates (opportunity-score worksheet, service brief, discovery questionnaire, scope of work, pricing-model selector, risk register, ops runbook, handoff checklist)
- `reference/audit-checklist.md` — 10-point quick diagnostic + 8-section / 60-item full audit for any proposed AI service
- `reference/decision-tree.md` — 15 problem-to-service-type decision trees (data entry, support chat, sales follow-up, content generation, forecasting, anomaly detection, and more)
- `reference/worked-examples.md` — 3 full composite engagements (accounting doc-intake, property call triage, proposal generation)
- `reference/knowledge.md` — conceptual foundations (where AI creates economic surplus, limits, pricing novel work, vendor lock-in, regulatory exposure)

Load reference files on demand — don't load them all upfront.

---

## Scope & Related Skills

This skill owns: AI opportunity identification, service packaging, scope definition, pricing-model selection, vendor/tech-stack decisions, risk assessment, human-in-the-loop design, and productisation of custom work.

**Out of scope — run these companions separately if available:**

| Need | See also |
|-|-|
| Write service page copy, one-liners | `/storybrand-copy` |
| Ad campaign for a new service | `/google-ads-optimize` + `/programmatic-advertising` |
| Funnel for a new service | `/funnel-architect` |
| Email sequences for onboarding | `/email-sequence` |
| Retention / upsell strategy | `/retention-engine` |
| Landing-page UX | `/ux-audit` |
| Broader marketing strategy | `/marketing-plan` |
| Statistical evaluation of AI outputs | `/experiment-engine` |
| Score generated content quality | `/expert-panel` |

---

## Core Concepts

- **AI-capability matrix** — explicit map of what LLMs do well (summarise, classify, extract, draft), what they do badly (multi-step reasoning over novel domains, quantitative precision, real-time truth). Service scope must sit in the green zone or use HITL to cover the red zone. Full matrix in `reference/frameworks.md` § F1.
- **Automation-maturity ladder (levels 1–5)** — L1 manual, L2 basic tools, L3 workflow automation, L4 AI-assisted / co-pilot, L5 autonomous with exception handling. Mismatch between client maturity and proposed service is the #1 failure mode. Details: `reference/frameworks.md` § F2.
- **Productisation stages** — custom engagement → templated engagement → packaged service → self-serve product. Each stage trades margin for scale. You graduate one service through stages; you don't start at self-serve. Details: `reference/frameworks.md` § F3.
- **Pricing-model decision** — effort shape dictates model. Linear effort → time-and-materials. Front-loaded effort → project fee. Recurring effort → retainer. Variable effort tied to client value → outcome-based (rare, risky). Details: `reference/frameworks.md` § F4.
- **Risk register** — every AI service ships with a register covering hallucination, data leakage, compliance, vendor continuity, and scope drift. Details: `reference/frameworks.md` § F5 and `reference/templates.md` Template 6.
- **Buy vs build vs partner** — for each capability the service needs, decide: buy off-the-shelf SaaS, build custom, or partner with a specialist vendor. Solo operators default to buy unless there's a durable reason to build. Details: `reference/frameworks.md` § F6.
- **LLM vs classical ML** — LLMs excel at language and ambiguity; classical ML (regression, trees, clustering) excels at stable tabular prediction. Default is LLM; deviate only with evidence. Details: `reference/frameworks.md` § F7.
- **Human-in-the-loop (HITL) patterns** — three patterns: review-before-send, sample-audit, escalation-on-uncertainty. Pick based on cost of error and volume. Details: `reference/frameworks.md` § F8.
- **Offer ladder mapping** — free audit → paid project → retainer → premium advisory. Every new service needs a placement on the ladder and a natural next rung. Details: `reference/frameworks.md` § F9.
- **Discovery cadence** — two-call discovery (context call → scope call) minimum for any engagement above a flat-fee threshold. Details: `reference/frameworks.md` § F10 and `reference/templates.md` Template 3.

---

## Decision Tree — Which framework for the job

Load `reference/frameworks.md` and `reference/decision-tree.md` for the full trees. Summary:

- **Brainstorming a new service from scratch** → F1 capability matrix → F2 maturity ladder → F9 offer ladder
- **Evaluating whether a specific opportunity is worth pursuing** → opportunity-score worksheet (Template 1) + F5 risk register
- **Scoping a specific client engagement** → F10 discovery → scope template (Template 4) → F4 pricing selector
- **Productising repeat custom work** → F3 productisation stages
- **Choosing vendors or deciding whether to build** → F6 buy/build/partner + F7 LLM-vs-classical
- **Deciding how much human oversight** → F8 HITL patterns
- **Problem-to-service-type match for 15+ common scenarios** → `reference/decision-tree.md`

---

## Modes of Operation

Detect mode from user intent. If ambiguous, ask.

### 1. Brainstorm (new service)

Generate candidate AI service offerings from a client's business, a vertical, or a capability you already hold.

**Process:**
1. Run through the 10 opportunity categories (see "Opportunity Categories" section below) and the AI-capability matrix (F1). For each category, note: does LLM/classical/workflow automation fit?
2. For each candidate, score against the opportunity-score worksheet (Template 1) — time saved, revenue impact, data readiness, risk, delivery effort.
3. Keep candidates scoring 7+/10 weighted. Reject anything that scores low on data readiness — no data, no service.
4. For the top 3, sketch a service brief (Template 2): outcome, scope, HITL pattern, pricing model, tech stack.
5. Output: 3 service briefs with weighted score, risk profile, and estimated gross margin.
6. **See also:** copy for service page → `/storybrand-copy`. Funnel to sell it → `/funnel-architect`.

### 2. Evaluate (specific opportunity)

Decide whether a single opportunity is worth pursuing before investing discovery time.

**Process:**
1. Score against Template 1 (10 questions).
2. Check against `reference/decision-tree.md` — is this problem a known automation fit?
3. Run the 10-point quick diagnostic from `reference/audit-checklist.md`.
4. If any red flag (no data, regulated without precedent, vendor lock, effort shape misaligned with pricing), stop.
5. Output: go / iterate / kill with reasoning.

### 3. Scope (client engagement)

Turn "yes, we'll work with this client" into a priced scope of work.

**Process:**
1. Run two-call discovery (F10) using the discovery questionnaire (Template 3).
2. Draft scope of work (Template 4): outcome, deliverables, assumptions, exclusions, success criteria, timeline.
3. Select pricing model (F4) using the pricing-model selector (Template 5).
4. Attach a risk register (Template 6) — at minimum cover hallucination, data access, HITL, vendor continuity.
5. Decide HITL pattern (F8) and document in the scope.
6. Output: signed-ready SOW with fee, milestones, risk register, and runbook sketch.

### 4. Productise (existing work)

Move an existing custom service up the productisation ladder.

**Process:**
1. Pull the last 3–5 delivered engagements of the same type. Note similarities and variations.
2. Identify the templatable 60–80% and the client-specific 20–40%.
3. Map current stage (custom → templated → packaged → self-serve). See F3.
4. Define one upgrade move: what can be templated next? What operational change does that require?
5. Re-price at the new stage. Templated beats custom on margin if fixed-scope discipline holds.
6. Output: productisation plan, updated scope template, updated fee structure, ops-runbook draft (Template 7).

### 5. Build Plan (tech stack + HITL)

Decide how to build the service: LLM vs classical, buy vs build vs partner, HITL pattern.

**Process:**
1. Walk the capability map (F1) for each part of the service.
2. For each capability, run buy/build/partner (F6). Default buy.
3. LLM vs classical ML (F7) for any prediction/generation work.
4. HITL pattern (F8) for each risk-bearing output.
5. Document tech-stack choices with cost estimates (per-seat, per-call, per-doc) so pricing stays margin-positive.
6. Output: build-plan doc — capability map with decisions, vendor list, HITL pattern, per-unit cost estimate, margin at target price.

### 6. Audit (existing service)

Review a service you're already selling for scope creep, margin erosion, or delivery risk.

**Process:**
1. Run the 10-point quick diagnostic (`reference/audit-checklist.md` Layer 1).
2. On any red flag, drill into the 8-section / 60-item full audit (Layer 2).
3. Score out of 120. Identify the top 5 priority fixes.
4. Output: scored audit, top 5 fixes, expected impact on margin or retention.

### 7. Prioritise (multiple opportunities)

Given several candidate services or client opportunities, sequence them.

**Process:**
1. Score each against Template 1.
2. Sort by weighted score × confidence. Remove anything below 7 unless it's a stepping stone.
3. Identify dependencies (tech-stack overlap, client-base overlap, operational-overlap).
4. Start with one quick win to prove delivery shape, then expand.
5. Map to a 90-day roadmap with one milestone per month.
6. Output: sequenced roadmap with rationale.

### 8. Report

Track the health of a service offering.

**Process:**
1. Per-service: active clients, MRR / quarterly revenue, churn, gross margin, delivery hours per client.
2. Per-client: outcome metrics (hours saved, errors reduced, revenue lifted), maturity progression, escalations.
3. Pipeline: opportunities identified, proposals sent, close rate, average cycle time.
4. Output: one-page dashboard with trend direction, expansion candidates, churn risks.

---

## Opportunity Categories

Use this table in Brainstorm mode to systematically cover automation surface area. For each category, the "AI fit" column says whether LLM, classical ML, or workflow automation is the best tool.

| # | Category | What AI Automates | AI Fit | Typical Service Model |
|-|-|-|-|-|
| 1 | Document intake & extraction | OCR, field extraction, categorisation, routing | LLM + classical OCR | Setup + monthly managed |
| 2 | Customer-support chat | First-line answers, ticket routing, escalation | LLM with RAG + HITL escalation | Setup + monthly per-seat |
| 3 | Call triage & receptionist | After-hours call answering, urgency classification, booking | LLM voice + workflow | Setup + monthly per-line |
| 4 | Sales follow-up | Draft outreach, personalisation, cadence | LLM + workflow | Setup + monthly |
| 5 | Content generation | Social posts, blog drafts, product descriptions | LLM with brand prompt | Setup + monthly managed |
| 6 | Email sequences | Nurture drafts, broadcast ideation, subject-line variants | LLM + `/email-sequence` | Mid setup + low monthly |
| 7 | Proposal & quote generation | Template filling, pricing draw-down, risk clauses | LLM + document workflow | Setup + per-doc fee |
| 8 | Forecasting & planning | Demand forecasts, staffing, cash-flow projections | Classical ML (regression, time-series) | Mid setup + quarterly refresh |
| 9 | Anomaly detection | Fraud, quality-control, error-rate monitoring | Classical ML + LLM summary | Setup + monthly monitoring |
| 10 | Reporting & insights | Daily dashboards, narrative reports, anomaly callouts | LLM over SQL / BI | Low monthly |

For each, the `reference/decision-tree.md` file gives a specific "given client shape X, recommend service Y" tree.

---

## Pricing Model Reference

Rules of thumb (full selector in `reference/frameworks.md` § F4):

- **Setup + monthly** is the default. Upfront pays for build, monthly pays for ongoing ops and drift.
- **Never just one-time** — even a one-shot audit benefits from a follow-up engagement hook.
- **Templated services have transparent list prices** — custom engagements get quoted after discovery.
- **Bundle for discount** — a starter-kit bundle should price 15–25% below summed a-la-carte parts.
- **Name the service** — named services ("Document Automation", "Receptionist") close faster than descriptions ("AI tools for your business").
- **10× test** — "if a client paid 10× this price, what would we provide?" Answer reveals the premium tier.

---

## Common Mistakes

1. **Automating before understanding** — run discovery; don't sell what you haven't scoped.
2. **Proposing everything at once** — one quick win, prove value, expand.
3. **No recurring revenue** — one-time projects produce feast-or-famine cash flow.
4. **Complexity over clarity** — clients buy outcomes, not tech stacks.
5. **No offer ladder** — every engagement needs a clear next rung.
6. **Ignoring maturity mismatch** — L5 autonomous services sold to L1 clients break. Meet them where they are.
7. **Skipping the risk register** — when the model hallucinates on a regulated doc, you'll wish you had one.
8. **Accepting "we have data" at face value** — audit the data before pricing. Access, quality, and lineage.
9. **No HITL design** — pick a pattern at scoping, not after the first failure.
10. **Pricing by hours when effort is lumpy** — effort shape dictates model. Read F4 before quoting.

---

## Anti-patterns to refuse

- Pricing an outcome-based deal with no baseline measurement in place.
- Scoping a service on a regulated use case (health, finance, legal) without documented precedent and named accountability.
- Productising work you've delivered once — graduate through stages, don't jump them.
- Building custom when a buy-option exists, unless there's a durable differentiation reason.
- Promising a maturity-level jump greater than +2 for a client in a single engagement.

---

## Cross-links

Load in tandem when relevant:

- `/market-pain` — before you design a service for a vertical, validate demand.
- `/product-strategy` — for a full multi-service architecture in a vertical.
- `/marketing-plan` — to take the service to market.
- `/funnel-architect` — for the sales sequence.
- `/storybrand-copy` — for service-page copy.
- `/email-sequence` — for onboarding and nurture flows.
- `/experiment-engine` — when evaluating AI output quality statistically.
- `/expert-panel` — to score generated content before it ships to a client.
- `/pm` — to manage the resulting engagement.
