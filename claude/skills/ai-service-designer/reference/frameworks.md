# AI Service Designer — Frameworks

Ten operational frameworks for designing, scoping, and productising AI services. Use the decision tree at the top to jump to the right one.

---

## Decision Tree — Which framework now?

```
START: what are you trying to do?
 |
 |-- Brainstorm a new service from scratch
 |    |-- Need to understand what AI can actually do? --> F1 AI-capability matrix
 |    |-- Need to match service depth to client state? --> F2 Automation-maturity ladder
 |    |-- Need to place it in the offer sequence? ------> F9 Offer ladder mapping
 |
 |-- Evaluate a specific opportunity
 |    |-- Is the opportunity worth pursuing at all? ----> F1 + opportunity score (see Template 1)
 |    |-- Risk profile acceptable? ---------------------> F5 Risk-register structure
 |
 |-- Scope a specific client engagement
 |    |-- How do I run discovery? ----------------------> F10 Discovery cadence
 |    |-- How do I price it? ---------------------------> F4 Pricing-model selector
 |    |-- How much oversight do I build in? ------------> F8 Human-in-the-loop patterns
 |
 |-- Productise repeat work
 |    |-- Where am I on the custom-to-self-serve path? -> F3 Productisation stages
 |
 |-- Decide what to build vs buy
 |    |-- Buy off-the-shelf, build, or partner? --------> F6 Buy/build/partner
 |    |-- LLM or classical ML for this task? -----------> F7 LLM-vs-classical decision
```

---

## F1 — AI-capability matrix

**Use when:** brainstorming any new service, or sanity-checking a proposed scope.
**Rating:** 5 (gate every design through this).

What LLMs and related AI systems are good at, bad at, and genuinely dangerous at. If your service sits in the red zone without HITL, do not scope it.

| Capability | LLM rating | Classical ML rating | Notes |
|-|-|-|-|
| Summarise a single long document | Green | N/A | Reliable when source is given; cite-back if accuracy matters |
| Extract structured fields from documents | Green | Green (OCR) | Pair OCR for scans + LLM for semantic fields |
| Classify free-text into fixed categories | Green | Green | Classical wins on stable, high-volume categories; LLM wins on low-volume + nuance |
| Draft personalised copy (email, proposal) | Green | Red | LLM default; HITL review-before-send |
| Multi-step reasoning over novel domain | Amber | Red | Works for simple chains; break into steps and evaluate each |
| Real-time numeric calculation | Red | Green | Don't let an LLM do arithmetic — give it a tool |
| Precise quantitative forecasting | Red | Green | Time-series / regression beats LLM by orders of magnitude |
| Code generation for narrow tasks | Green | N/A | Always review; test before production |
| Voice conversation (inbound call) | Green | N/A | Modern voice LLMs are production-grade; still need HITL escalation |
| Detecting anomalies in tabular data | Amber | Green | Classical first, LLM to narrate the anomaly |
| Legal / regulatory reasoning | Red | Red | Out of scope without named accountability + documented precedent |
| Medical decisions | Red | Red | Refuse. Advisory framing only, with clinician oversight. |
| Multilingual translation | Green | N/A | Production-ready; check culturally sensitive terms |
| Source-grounded Q&A (RAG) | Green | N/A | Quality of retrieval dictates quality of answer |
| Sentiment / tone classification | Green | Green | Either works; LLM easier for multi-label |

**Green-zone scoping rule:** if the service outcome depends on red-zone capability without HITL, re-scope or refuse.

---

## F2 — Automation-maturity ladder

**Use when:** you're proposing a service and need to make sure it meets the client where they are.
**Rating:** 5.

Five levels. Mismatch is the #1 failure mode — a Level 5 service sold to a Level 1 client will collapse within three months.

| Level | State | Characteristics | Typical first service |
|-|-|-|-|
| 1 | Manual / ad-hoc | Paper, email threads, no shared tools; tribal knowledge | Document digitisation + single workflow |
| 2 | Basic tools | Spreadsheets, shared drive, standalone CRM or accounting package | Workflow automation bridging two tools |
| 3 | Workflow automated | Zapier / Make / n8n in use; some integrations working | AI-assisted layer on existing workflows (draft generation, classification) |
| 4 | AI-assisted | Co-pilots embedded in daily work; data flowing; someone owns it | Autonomous agents for bounded workflows |
| 5 | AI-native | Autonomous systems with HITL on exceptions; predictive models in use | Advisory + incremental upgrades |

**Rule of thumb:** plan a maximum of +2 levels per engagement. A client at L1 can move to L3 in six months with the right partner. A jump to L4 without an L2/L3 bridge rarely lands.

**Gap diagnostic:** during discovery, score each of the 10 opportunity categories (see SKILL.md) against the ladder. The variance between categories tells you where to start.

---

## F3 — Productisation stages

**Use when:** you've delivered a custom service more than twice and want to build margin through productisation.
**Rating:** 4.

Four stages; each trades margin for scale. You graduate one stage at a time.

| Stage | Shape | Margin | Scale | When to move on |
|-|-|-|-|-|
| 1. Custom | Bespoke every time. Fresh discovery, fresh build, fresh price. | Low-medium (labour-heavy) | 1 engagement at a time | After 3 similar engagements |
| 2. Templated | Discovery + scope reuse a template. Build reuses 60–80% of prior work. | Medium | 3–5 parallel engagements | After templates prove stable for 6 months |
| 3. Packaged | Fixed-scope, fixed-price offer with defined deliverables. Discovery shrinks to qualification. | Medium-high | Dozens | After ops runbook is stable and defect rate low |
| 4. Self-serve | Client runs it themselves via a tool you built or licensed. You handle support + exceptions. | High per-unit | Hundreds-thousands | Only if demand justifies the product investment |

**Movement rules:**
- Don't skip. Packaged without templated means your "fixed scope" is fiction.
- Hold the discipline. Packaged services die when the seller quietly agrees to "tiny" customisations.
- Most solo operators will never reach self-serve, and that's fine — packaged + retainer is a sustainable shape.

**Productisation artefacts needed at each stage:**

| Stage | Needs |
|-|-|
| Custom | SOW template |
| Templated | SOW template + service brief template + ops checklist |
| Packaged | Public service page with price + qualification call + fixed deliverables + SLA |
| Self-serve | All of the above + automated onboarding + support docs + billing integration |

---

## F4 — Pricing-model selector

**Use when:** choosing how to charge for a service or a specific engagement.
**Rating:** 5.

Effort shape dictates the model. Get this wrong and you either starve on thin margin or burn clients who feel overcharged.

| Effort shape | Recommended model | When to use | When to avoid |
|-|-|-|-|
| Linear (hours scale with scope) | Time-and-materials | Short, exploratory work; unknown scope | Anything templated |
| Front-loaded (big build, then maintenance) | Project fee + monthly retainer | Standard service setup (new chatbot, new workflow) | Purely ad-hoc work |
| Recurring (steady ongoing effort) | Retainer (monthly) | Managed services, ongoing ops | Work with no ongoing role |
| Variable tied to client value | Outcome-based (% of savings or revenue) | High-trust relationships, measurable outcome, baseline established | No baseline, no measurement, no trust |
| Per-unit (doc, call, seat) | Usage fee + floor | Clear unit cost + unit value (e.g. per-document) | When volume unknowable |

**Blended example — packaged service:**
- Setup fee: $3K–$10K (front-loaded engineering + discovery)
- Monthly fee: $500–$1,500 (ops, drift, minor enhancements)
- Per-unit overage: only if usage can spike dramatically (e.g. call minutes beyond a cap)

**Outcome-based warning:** requires all three — baseline, measurement, trust. Most of the time you're better off charging for effort and tracking outcome as a retention hook.

**Margin rule:** target 60–70% gross margin after tech-stack costs. If per-call LLM inference + vendor seats erode margin below 50%, re-price or re-scope.

---

## F5 — Risk-register structure

**Use when:** scoping any engagement, before contract.
**Rating:** 5.

Every AI service ships with a risk register. At a minimum cover these five categories.

| Risk | Shape | Mitigation pattern |
|-|-|-|
| Hallucination | Model produces confident-wrong output | HITL review for high-stakes outputs; sample audit for high-volume |
| Data leakage | Sensitive client data exposed to a third-party LLM or training pipeline | Use zero-retention APIs; encrypt at rest; sign vendor DPAs |
| Compliance exposure | Output crosses a regulated boundary (health, finance, legal advice) | Refuse scope or require named clinician / adviser accountability |
| Vendor continuity | Single vendor goes down, deprecates a model, or changes pricing | Abstract the model layer; plan for a switch within a week |
| Scope drift | Client expects features beyond the scoped agreement | Written scope + change-order process; re-quote, don't absorb |

**Added risks by service type:**

- **Call triage / voice:** misclassified emergency, missed escalation → explicit escalation path with human backup.
- **Document extraction:** wrong-field extraction contaminates downstream records → error-rate target + spot-audit schedule.
- **Sales follow-up:** off-brand voice, mis-targeted outreach → brand-voice prompt + sample review cadence.
- **Content generation:** factual errors, plagiarism, trademark issues → pre-publish checklist; never ship without human review.

Full risk-register template lives in `reference/templates.md` Template 6.

---

## F6 — Buy vs build vs partner

**Use when:** designing the tech stack for any service. Run once per capability the service needs.
**Rating:** 5.

Default is buy. Build only when differentiation is durable. Partner when a specialist saves time and the relationship is contractual.

**Buy — pick this when:**
- Off-the-shelf SaaS covers 80%+ of the need.
- Switching cost is low (abstraction over the vendor).
- The capability is not your differentiation.

**Build — pick this when:**
- No off-the-shelf option meets the need.
- You have durable advantage from building (data moat, process IP).
- Maintenance cost is budgeted from day one.

**Partner — pick this when:**
- Capability needs specialist expertise you don't have (voice AI, compliance tooling, domain-specific model).
- Buy-in is contractual, not pay-per-use.
- You can white-label the partner's work under your service.

**Decision matrix:**

| Factor | Buy | Build | Partner |
|-|-|-|-|
| Time to launch | Days | Months | Weeks |
| Upfront cost | Low | High | Medium |
| Ongoing cost | Subscription | Maintenance | Partner margin |
| Differentiation | None | High (if done right) | Medium |
| Switching cost | Low | High | Medium |
| Solo-operator fit | Best | Risky | Good for specialist capability |

**Default for solo operators:** buy the infrastructure (LLM API, vector DB, workflow tool), build the orchestration layer (the prompts, workflows, integrations that represent your IP), partner where a specialist capability is needed.

---

## F7 — LLM vs classical ML decision

**Use when:** designing a specific prediction or generation component.
**Rating:** 4.

Default is LLM. Deviate only with evidence.

**Use LLM when:**
- Input is natural language or unstructured.
- Task requires generation (not just classification).
- Volume is low-medium (per-call cost is tolerable).
- Task definition can drift (new categories, new languages, new edge cases).
- You need explanations alongside predictions.

**Use classical ML when:**
- Input is structured tabular data.
- Task is stable (fixed categories, stable feature space).
- Volume is high and per-call cost matters.
- Precise numeric output is required (forecasts, probabilities).
- Model interpretability is a requirement (some regulated domains).

**Hybrid pattern (most common):**
- Classical model produces the prediction or classification.
- LLM produces the narrative summary, reason, or recommendation.

**Evaluation:**
- For LLM: prompt-based accuracy test on a held-out set of 50–100 examples. Track precision and recall.
- For classical: standard cross-validation, confusion matrix, feature importance.
- Ship with monitoring either way — drift is real and will hit you.

---

## F8 — Human-in-the-loop patterns

**Use when:** designing any service that produces outputs with non-zero cost-of-error.
**Rating:** 5.

Three patterns. Pick based on cost of error × volume.

| Pattern | Shape | Best when | Cost |
|-|-|-|-|
| Review-before-send | Every output reviewed by a human before it reaches client/customer | High cost of error, low volume (proposals, contracts, high-value outreach) | High per-output labour |
| Sample audit | Fixed sample of outputs reviewed after the fact; quality dashboard tracks drift | Medium cost of error, high volume (content, classified tickets) | Low per-output, predictable total |
| Escalation-on-uncertainty | Model confidence thresholded; anything below threshold routed to a human | Variable cost of error, high volume, confidence-score available (triage, support) | Low steady-state, spikes with drift |

**Design questions:**
1. What's the cost of a wrong output? (dollar amount or qualitative category)
2. What's the volume per day/week?
3. Is there a reliable confidence signal?
4. Who is the reviewer? (internal ops? client's team? the client themselves?)
5. What's the SLA on review? (same-day? within the hour?)

**Common mistake:** design the model first, bolt HITL on afterwards. Better: design the HITL pattern, then design the model to produce outputs that fit the pattern (e.g. confidence score for escalation, structured reason for review).

---

## F9 — Offer ladder mapping

**Use when:** placing a new service in your portfolio, or planning next-rung moves.
**Rating:** 4.

Every service sits on a ladder. Natural next rung should be clear to both client and seller.

Standard shape:

```
Rung 0: Free audit / assessment (lead capture)
    v
Rung 1: Entry project ($1K–$5K, 1–4 weeks)
    v
Rung 2: Flagship project ($5K–$25K, 4–12 weeks)
    v
Rung 3: Ongoing retainer ($500–$5K/mo)
    v
Rung 4: Premium advisory / exclusivity (5–10× retainer)
```

**Placement questions for a new service:**
1. Which rung does it belong on? (size, complexity, price)
2. What rung is the natural upgrade?
3. What rung downgrades to this one if a client can't commit?

**Rules:**
- Never launch a new rung without launching the rung below (no "premium only" without a proof-of-competence path).
- Each rung should have a distinct named offer, not just a price point.
- The ratio between rungs is typically 3–5× (helps create contrast).

Full bundle structure and starter-kit logic in the pricing section of SKILL.md.

---

## F10 — Discovery cadence

**Use when:** scoping any engagement above a flat-fee threshold (say $5K+).
**Rating:** 4.

Two calls minimum. Free discovery is an investment, not a giveaway — but cap it.

### Call 1: Context call (30–45 min)

**Goals:**
- Confirm problem shape and urgency.
- Map current maturity (F2) across the 10 opportunity categories.
- Identify data readiness (access, quality, lineage).
- Qualify budget / authority / timing.

**Questions to ask:**
- What's the specific workflow you're trying to change? Walk me through it.
- Who's doing it today, how long does it take, what goes wrong?
- What data is involved? Where does it live? Who owns access?
- If we did nothing, what happens in 6 months?
- What's your budget band for this? (Give the band first.)
- Who else has to say yes?
- When do you need this live?

**Output:** notes + fit-or-no-fit call. If it's a fit, propose Call 2.

### Call 2: Scope call (45–60 min)

**Goals:**
- Present scope, pricing, timeline.
- Walk risk register.
- Confirm HITL pattern.
- Agree next step (SOW signed / revised quote / no-go).

**Structure:**
1. Recap context call findings (2 min).
2. Proposed scope + deliverables (10 min).
3. Pricing model + fee (5 min).
4. Risk register walk-through (10 min).
5. HITL design (5 min).
6. Timeline + milestones (5 min).
7. Q&A (10 min).
8. Close: next step + date (5 min).

**Rule:** never scope a paid engagement from a single call for anything above the flat-fee threshold.

Discovery questionnaire template in `reference/templates.md` Template 3.
