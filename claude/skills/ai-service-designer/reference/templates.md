# AI Service Designer — Templates

Eight fill-in-blank templates. Each one is a working artefact — copy it into a doc, fill the blanks, and it becomes the deliverable.

---

## Template 1 — AI opportunity scoring worksheet

Use when evaluating whether to build a candidate service. Score each row 1–10 (10 = strongest), then multiply by weight and sum.

**Candidate name:** _________________
**Brief description (1 sentence):** _________________

| # | Criterion | Weight | Score (1–10) | Weighted | Notes |
|-|-|-|-|-|-|
| 1 | Time saved per client (per month) | 0.15 | | | |
| 2 | Revenue impact per client (per year) | 0.15 | | | |
| 3 | Number of clients in the market (TAM-ish) | 0.10 | | | |
| 4 | Data readiness (access + quality + lineage) | 0.15 | | | |
| 5 | AI capability fit (green zone on F1 matrix) | 0.10 | | | |
| 6 | Delivery effort (low effort = high score) | 0.10 | | | |
| 7 | Recurring-revenue shape (retainer-natural = high) | 0.10 | | | |
| 8 | Risk profile (low risk = high score) | 0.05 | | | |
| 9 | Pricing model clarity (effort shape fits a model) | 0.05 | | | |
| 10 | Competitive position (differentiation + defensibility) | 0.05 | | | |
| **Total** | | **1.00** | | **/10** | |

**Interpretation:**
- 7.5+ weighted → strong candidate, proceed to brief.
- 6.0–7.4 → iterate scope; low-scoring criteria need a fix.
- <6.0 → kill or park.

**Hard kill rules (any one):**
- Score ≤ 3 on Data readiness → no data, no service.
- Score ≤ 3 on AI capability fit → red-zone task without HITL design.
- Score ≤ 3 on Risk profile → regulated domain without accountability.

---

## Template 2 — Service brief

Draft one per candidate that passes Template 1. Keep it to one page.

```
SERVICE BRIEF

Service name: __________________________
One-line outcome: ________________________________

Target client profile:
  Industry:
  Size (headcount, revenue):
  Maturity level (L1–L5):
  Typical problem/trigger:

Scope summary (3–5 bullets):
  -
  -
  -
  -
  -

What we deliver (outputs + artefacts):
  -
  -
  -

What we do NOT deliver (explicit exclusions):
  -
  -

Tech stack (capability -> vendor/approach):
  Capability 1: __________ -> buy/build/partner, vendor ____
  Capability 2: __________ -> buy/build/partner, vendor ____
  Capability 3: __________ -> buy/build/partner, vendor ____

HITL pattern: review-before-send / sample-audit / escalation-on-uncertainty
HITL owner: (us / client / both)

Per-unit cost estimate (LLM calls, seats, storage): $______ / month / client

Pricing:
  Setup fee: $______
  Monthly: $______
  Per-unit overage (if any): $______

Gross margin at target price: _____%

Offer ladder placement: rung ___ (name: __________)
Natural next rung: rung ___ (name: __________)

Key risks (top 3):
  1.
  2.
  3.

Quick win for first engagement:
```

---

## Template 3 — Client discovery questionnaire

Use in discovery calls (F10). Send questions 1–5 in advance; leave 6–10 for the call.

**Before the call (written):**

1. Describe the workflow you want to change, step by step, in your own words.
2. Who does this today? How many hours per week do they spend on it?
3. Where does the work live right now? (spreadsheets, email, CRM, phone, paper — list the systems)
4. What data is involved? (documents, calls, emails, records — list the types)
5. What's the single outcome that would make this engagement a success?

**On the call (verbal):**

6. If we did nothing, what happens in 6 months?
7. Walk me through a recent example where this went badly. What did it cost?
8. What's your budget band for solving this? (Ask them to name a band before you name yours.)
9. Who else has to say yes for us to start?
10. When do you need this live, and what's driving the deadline?

**Call 2 probes (only if Call 1 passed the fit test):**

11. Who on your side will be the primary point of contact?
12. Who will handle exceptions / escalations when the system flags something?
13. What's your tolerance for errors in the first 30 days? (set expectations early)
14. Are there any compliance or privacy requirements I should know about?
15. What's the first outcome that would make you say "this is working" in 60 days?

---

## Template 4 — Scope of work (SOW)

Use as the basis for any signed engagement. Fill every section.

```
SCOPE OF WORK

Between: [Your business name, ABN]
And:     [Client name, ABN]
Date:    [YYYY-MM-DD]

1. OUTCOME
   The measurable business outcome this engagement achieves:
   [One sentence, measurable, time-bound]

2. DELIVERABLES
   -
   -
   -

3. ASSUMPTIONS
   This scope and price assume:
   - Client provides [data / access / named point of contact] by [date]
   - Existing systems: [list]
   - Data volume: [approximate]
   - Compliance scope: [e.g. GDPR, CCPA, HIPAA, the applicable national privacy law, none, etc.]

4. EXCLUSIONS
   Explicitly out of scope:
   -
   -
   -

5. TIMELINE + MILESTONES
   Week 1-2: Discovery + design sign-off
   Week 3-5: Build + internal test
   Week 6: Client pilot
   Week 7: Go-live + handover
   [Adjust as appropriate]

6. PRICING
   Setup fee:    $______ [invoiced: 50% on sign, 50% on go-live]
   Monthly fee:  $______ [invoiced: monthly, from go-live]
   Per-unit:     $______ [if applicable, with free allowance of ______]
   Total Year 1: $______

7. RISK REGISTER
   See attached (Template 6).

8. HITL DESIGN
   Pattern: ______
   Reviewer: ______
   SLA: ______
   Escalation path: ______

9. SUCCESS CRITERIA
   This engagement is successful when:
   - [Measurable outcome #1 by date]
   - [Measurable outcome #2 by date]

10. CHANGE MANAGEMENT
   Any change to scope requires a written change order.
   Change orders are quoted and signed before work begins.

11. TERMINATION
   Either party may terminate with [30] days' notice.
   On termination, client receives [data + deliverables completed to date].

12. INTELLECTUAL PROPERTY
   Client owns: their data, deliverables on go-live.
   We own: underlying tools, prompts, workflows, IP.
   Reuse: we may reuse non-client-specific components in other engagements.

Signed:
  Us:     _________________________ Date: _______
  Client: _________________________ Date: _______
```

---

## Template 5 — Pricing-model selector

Answer each question in order. The first line that fits is the recommended model.

```
PRICING MODEL SELECTOR

1. Is the scope fully known at sign-off?
   No  -> Time-and-materials, with a cap and revisit after first phase.
   Yes -> continue.

2. Is there a front-loaded build phase followed by ongoing operations?
   Yes -> Project fee + monthly retainer (DEFAULT for new AI services).
   No  -> continue.

3. Is the effort steady and recurring with no big build?
   Yes -> Retainer only.
   No  -> continue.

4. Is the effort per client variable but tied to a measurable client outcome?
   Outcome measurable + baseline established + high trust relationship
       -> Outcome-based (% of savings or % of revenue lifted).
   Otherwise -> Retainer or per-unit with floor.

5. Does each "unit of service" have a clear cost and a clear value?
   Yes (e.g. per-doc, per-call, per-seat) -> Per-unit fee with minimum monthly floor.
   No -> fall back to retainer.

TIE-BREAKERS:
  - Solo operator + templated work -> fixed fee + retainer beats hourly.
  - Regulated industry + variable scope -> retainer + capped overage.
  - New relationship + unknown scope -> small fixed-fee discovery engagement first.

MARGIN CHECK:
  Tech stack cost per client: $______ / month
  Delivery hours per client:  ______ hours / month at $____/hour = $______
  Total variable cost:        $______
  Target gross margin:        _____%
  Minimum fee needed:         $______
  Your quoted fee:            $______
  Margin at quoted fee:       _____%

If margin at quoted fee < 50%: re-price or re-scope.
If margin at quoted fee > 70%: you may be under-scoped or over-priced.
```

---

## Template 6 — Risk register

Attach to every SOW. Expand rows as needed.

```
RISK REGISTER — [Engagement name]

Date: [YYYY-MM-DD]
Owner: [Your name]

Format per row:
  ID  | Risk                     | Likelihood | Impact | Mitigation                    | Owner | Review date

R1  | Model produces hallucinated output on high-stakes record
    | Medium | High
    | HITL review-before-send on all client-facing outputs; sample audit 10% weekly
    | Us
    | Weekly for first 4 weeks, then monthly

R2  | Data leakage via third-party LLM API
    | Low | High
    | Zero-retention endpoint; encrypted transit; DPA signed with vendor; no PII in prompts beyond necessary
    | Us
    | At sign, at go-live, quarterly

R3  | Vendor changes pricing or deprecates model
    | Medium | Medium
    | Abstraction layer so we can switch LLM provider within 1 week; fallback vendor tested quarterly
    | Us
    | Quarterly

R4  | Client stakeholder changes during engagement
    | Medium | Medium
    | Named primary + secondary contact in SOW; weekly status email; monthly steering call
    | Client
    | At milestone gates

R5  | Scope drift — client asks for features beyond scope
    | High | Medium
    | Written change-order process; minor changes included up to 2 hours/month; beyond that, quoted
    | Us
    | Every status meeting

R6  | Error rate on extracted fields exceeds threshold
    | Medium | High
    | Threshold agreed in SOW (e.g. <3% error); sampling audit in first 4 weeks; retraining plan if breached
    | Us
    | Weekly for first 4 weeks

R7  | Compliance exposure — regulated content produced without review
    | Low | High
    | Domain-specific content flagged for named subject-matter reviewer; refuse scope if reviewer absent
    | Client + us
    | At sign and if scope changes

R8  | [Add domain-specific risk]
    |
    |
```

---

## Template 7 — Ops runbook

Every packaged service needs a runbook. Fill this out before go-live.

```
OPS RUNBOOK — [Service name]

Client: [name]
Go-live date: [YYYY-MM-DD]
Primary contact (us): [name, email, phone]
Primary contact (client): [name, email, phone]

1. SYSTEM OVERVIEW
   What it does (plain language, 2 sentences):
   Data flow (mermaid or text):
     Source -> ingest -> model -> HITL -> output -> destination

2. VENDOR STACK
   LLM: [vendor, model, API endpoint, retention policy]
   Workflow: [tool]
   Storage: [database, encryption state]
   Auth: [how access is managed]
   Monitoring: [tool, dashboards, alert channel]

3. DAILY / WEEKLY OPS
   Daily checks (2 minutes):
     - [ ] Alert channel clear
     - [ ] Volume within expected band
     - [ ] Error log reviewed
   Weekly tasks (30 minutes):
     - [ ] Sample audit of ___ outputs
     - [ ] Review any flagged items
     - [ ] Check margin tracking (LLM costs vs fee)
     - [ ] Send weekly status email

4. HITL WORKFLOW
   Pattern: ______
   Who reviews: ______
   Where: ______
   SLA: ______
   Escalation path:
     Level 1: [contact + expected response]
     Level 2: [contact + expected response]
     Level 3: [contact + expected response]

5. FAILURE MODES + RECOVERY
   Model API down:
     Fallback vendor: ______
     Manual failover: ______ (time to switch: _____ min)
   Error rate spike:
     Threshold: _____
     Action: pause automated output, engage review, root-cause investigation
   Data source unavailable:
     Cache policy: ______
     Customer-facing message: ______

6. CLIENT COMMUNICATIONS
   Weekly status email — Friday, 3pm, to [name]
   Monthly review call — [day of month]
   Outage notice — within 30 min of detection, to [name + channel]

7. CHANGE LOG
   All changes to prompts, workflows, vendor settings are logged here:
   [link to change log]

8. OFFBOARDING
   If client terminates:
     1. Export their data within 7 days.
     2. Transfer credentials.
     3. Revoke our access.
     4. Archive internal artefacts.
     5. Write internal retro.
```

---

## Template 8 — Handoff checklist

Use at the end of every engagement to confirm the service is ready for steady-state operation.

```
HANDOFF CHECKLIST — [Service name] — [Client]

Engineering
  [ ] All integrations passing health checks
  [ ] Error handling + logging in place
  [ ] Secrets in vault, not code
  [ ] Backup + restore tested
  [ ] Monitoring dashboard shared with client

Documentation
  [ ] Ops runbook complete (Template 7)
  [ ] Client-facing user guide written
  [ ] Architecture diagram current
  [ ] Change log started

Governance
  [ ] Risk register reviewed + accepted by client
  [ ] DPA / privacy policy signed
  [ ] HITL reviewer named + trained
  [ ] Escalation path tested (simulated escalation)

Commercial
  [ ] SOW countersigned
  [ ] First invoice issued + paid (setup fee)
  [ ] Monthly billing set up
  [ ] Success criteria recorded with baseline metric

Relational
  [ ] Weekly status cadence agreed
  [ ] Monthly review call scheduled
  [ ] Offer-ladder next-rung identified + noted
  [ ] Reference/case-study consent discussed (optional for later)

Team
  [ ] Internal retro scheduled
  [ ] Tech stack decisions documented
  [ ] Lessons folded into service brief template (if graduating custom -> templated)
```
