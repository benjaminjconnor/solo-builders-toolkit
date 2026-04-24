# AI Service Designer — Decision Trees

Given a client problem, a data profile, and a risk tolerance, this file maps to a recommended service type. Use when a prospect describes a pain point and you need to quickly shape a response.

Format: each tree starts with a problem statement, asks a small number of filter questions, and lands on one of the 10 opportunity categories from SKILL.md (or a refuse / re-scope outcome).

---

## Tree 1 — "We spend hours keying data off PDFs into our system"

**Opportunity category:** 1 — Document intake & extraction.

```
Q1. What's the volume? (per week)
  < 20 docs/week   -> not worth automation; recommend workflow/template change only
  20–200 docs/week -> Templated document-extraction service (typical fit)
  200+ docs/week   -> Packaged doc-extraction with volume pricing

Q2. What's the document shape?
  Same template every time (forms, invoices of one supplier)
    -> Classical OCR + rule-based parse; LLM only for edge cases
  Varied structure (multiple suppliers, different formats)
    -> LLM-based extraction with schema; classical OCR for scans

Q3. What's the cost of a wrong extraction?
  Contaminates a regulated record -> HITL review-before-send
  Mis-routes a document           -> Sample audit at 10% with escalation
  Minor inconvenience              -> Sample audit at 1–5%

Q4. Where does extracted data land?
  Existing system with API       -> direct write-back
  Existing system no API         -> CSV handoff + browser-automation helper
  No existing system             -> add a structured store before pricing
```

**Service shape:** Setup + monthly managed, per-doc overage beyond a cap.
**Risk flags:** Invoice fraud exposure if extracted fields drive payments. Build a verification step.

---

## Tree 2 — "Our customer-support inbox is drowning"

**Opportunity category:** 2 — Customer-support chat (text).

```
Q1. What percentage of tickets are repetitive / low-complexity?
  < 30%   -> Don't automate responses; automate triage + routing only
  30–60%  -> LLM first-line responder with HITL escalation for anything else
  60%+    -> Packaged support-automation with confidence-based escalation

Q2. Do you have a knowledge base?
  Yes, reasonably current -> RAG setup on existing KB
  Partial / out of date   -> KB refresh is a pre-requisite project (sell separately)
  No                      -> Do NOT scope automated responses without a KB

Q3. What's the brand voice requirement?
  Generic-friendly OK       -> Default prompt
  Strict branded voice     -> Brand-voice prompt + sample-audit HITL
  Regulated (health/legal) -> Refuse fully-automated; use draft-for-human-send instead

Q4. Integration shape?
  Existing helpdesk (Zendesk, Intercom, etc.) -> API integration
  Email only                                   -> Email-first design, harder to measure
  Multiple channels                            -> Omnichannel orchestration (bigger scope)
```

**Service shape:** Setup + monthly per-seat + per-conversation overage.
**HITL:** Escalation-on-uncertainty based on model confidence + category.

---

## Tree 3 — "Missed calls are costing us jobs"

**Opportunity category:** 3 — Call triage & receptionist.

```
Q1. What's the call profile?
  Mostly booking / appointment requests -> Voice AI with calendar integration
  Mostly pricing + info questions        -> Voice AI with KB integration
  Mostly emergencies (trades, health)    -> Triage + escalation design required
  Mostly admin / existing customers      -> Route to ticket system, don't answer

Q2. Is there an emergency / escalation tier?
  Yes -> Named human on-call backup MUST be in scope. No fully-autonomous.
  No  -> Voice AI handles all

Q3. What's the call volume + hours?
  < 20 calls/week after hours -> Overkill; answering service is cheaper
  20–200/week                  -> Voice AI fit
  200+/week                    -> Voice AI + queue management + analytics

Q4. Regulated domain?
  Health / telehealth -> Refuse without clinician accountability + named advice scope
  Legal               -> Refuse without legal-professional supervision
  Trades / services   -> Green
  Finance             -> Advisory scope only (no transactional decisions)
```

**Service shape:** Setup ($3K–$10K) + monthly per-line + minutes overage.
**Risk flags:** Missed emergencies. Document escalation SLA explicitly. Test the path before go-live.

---

## Tree 4 — "Our sales follow-up is inconsistent"

**Opportunity category:** 4 — Sales follow-up.

```
Q1. What CRM / list system is in place?
  Active CRM with pipeline stages -> Integration-based sequence triggering
  Spreadsheet list                 -> Fix CRM first; do not bolt AI onto chaos
  None                             -> Pre-requisite discovery project

Q2. Is the data quality usable?
  Names + emails + company + context field   -> Green
  Just emails                                 -> Personalisation will be generic
  Dirty / outdated                            -> Data-cleanse is phase 1

Q3. Brand voice + compliance?
  Standard B2B                     -> Green; templated with personalisation slots
  Strict compliance (regulated)    -> Review-before-send required
  Partner / co-brand restrictions  -> Check with partner's approval process

Q4. Follow-up vs cold-outreach?
  Follow-up on existing conversations     -> High-trust task, LLM fits
  Cold outreach                           -> See `/linkedin-optimizer` or similar;
                                             avoid mass automated cold email —
                                             deliverability + ethics both collapse
```

**Service shape:** Setup + monthly managed + per-send fee beyond a cap.
**HITL:** Review-before-send on first 30 days, sample-audit after.

---

## Tree 5 — "We need content but can't keep up"

**Opportunity category:** 5 — Content generation.

```
Q1. Content type?
  Social posts (short-form)                  -> LLM + brand prompt + sample audit
  Blog articles                               -> LLM drafts + mandatory human edit
  Product descriptions (e-commerce)          -> LLM from structured data, human QA
  Thought leadership / expert content        -> Refuse fully-automated; drafts only

Q2. Brand voice inputs?
  Past content + voice guide available       -> Strong voice prompt possible
  Founder willing to record / review         -> Voice capture possible
  Neither                                     -> Generic output; warn client

Q3. Distribution?
  Just drafts, client posts manually          -> Simple
  Auto-publishing                              -> Add scheduling + approval gate
  Multi-channel syndication                    -> Bigger scope; add orchestration layer

Q4. Evaluation cadence?
  Client reviews weekly                        -> Sample audit + weekly report
  Client reviews monthly                       -> Auto-publish with monthly report
  Client never reviews                         -> Refuse; client review is required
```

**Service shape:** Setup + monthly managed. Packaged tier by post volume.
**Risk flags:** Factual errors, brand drift, over-reliance. Weekly sample-audit mandatory in month 1.

---

## Tree 6 — "Our email marketing is flat"

**Opportunity category:** 6 — Email sequences.

**Cross-link:** `/email-sequence` skill owns this. ai-service-designer maps it to a service shape; `/email-sequence` designs the content.

```
Q1. What's missing?
  No welcome sequence                 -> Build welcome arc (cross-link to email-sequence)
  Broadcasts but no automation        -> Add nurture + segmentation
  Automation exists but not working   -> Audit before rebuild (cross-link to email-sequence audit)

Q2. Platform?
  Brevo / Mailchimp / Klaviyo         -> Any major platform fits
  Custom SMTP                         -> Deliverability + sender reputation is phase 1
  HubSpot / salesforce-marketing      -> Bigger platform scope; partner if needed

Q3. List size + hygiene?
  < 1,000 + clean                     -> Template-based approach
  1,000–10,000                        -> Full nurture + segmentation
  10,000+                             -> Segmentation + send-time optimisation
  Dirty list                          -> Hygiene + re-engagement is phase 1
```

**Service shape:** Mid setup + low monthly.
**Delivery overlap:** `/email-sequence` for content and architecture, ai-service-designer for the service package + pricing + runbook.

---

## Tree 7 — "We write proposals from scratch every time"

**Opportunity category:** 7 — Proposal & quote generation.

```
Q1. What percentage of each proposal is reused vs bespoke?
  > 70% reused -> Templated proposal-generation is a strong fit
  40–70%       -> LLM-assisted drafting
  < 40%        -> Too bespoke; improve template library first (not an AI service)

Q2. Input shape?
  Structured brief (RFP, standard form) -> Strong fit; auto-generate from form
  Email thread with partial info         -> LLM extracts + asks clarifying questions
  Free-text conversation                  -> LLM + HITL for each section

Q3. Pricing logic embedded?
  Yes, rule-based                         -> Tool-based calculation + LLM narrative
  Discretionary per deal                  -> LLM drafts price options + human decides
  Complex (dependent on multiple inputs)  -> Hybrid; classical model for pricing, LLM for narrative

Q4. Sensitive clauses?
  Standard T&Cs                           -> Safe to auto-generate
  Negotiated legal                        -> Always HITL review-before-send
  Regulatory (construction, health)       -> Named subject-matter-expert review
```

**Service shape:** Setup + monthly + per-doc fee beyond a cap.
**HITL:** Review-before-send mandatory on any priced proposal. No exceptions.

---

## Tree 8 — "We need to forecast demand / cash / staffing"

**Opportunity category:** 8 — Forecasting & planning.

```
Q1. How stable is the environment?
  Stable, repeatable pattern (retail seasonality, subscription)
    -> Classical time-series forecasting
  Volatile or event-driven
    -> Scenario modelling + classical, not pure forecasting
  Novel (new product, no history)
    -> Cannot forecast reliably; advise waiting or running pilots

Q2. Data available?
  2+ years of clean historical records -> Classical ML fit
  < 2 years                            -> Limited; widen confidence intervals
  No clean historical data              -> Data-engineering is pre-requisite phase

Q3. Who consumes the output?
  Operations team (planning)           -> Recurring report + LLM narrative summary
  Finance team (cash flow)             -> Dashboard + email digest
  Executive (strategy)                 -> Quarterly deep-dive, not weekly

Q4. Acceptable error band?
  Wide (±20%)                          -> Simple forecast fits
  Narrow (±5%)                         -> Requires strong data + probably a specialist partner
```

**Service shape:** Mid setup + quarterly refresh retainer.
**AI fit:** Classical ML primary; LLM for the narrative layer only.

---

## Tree 9 — "We want to catch problems early (fraud / quality / errors)"

**Opportunity category:** 9 — Anomaly detection.

```
Q1. What's being watched?
  Transactions (fraud, duplicates)    -> Classical model + rule hybrid
  Operations data (quality, defects)  -> Classical anomaly detection
  Text streams (reviews, complaints)  -> LLM classification + sentiment
  Time-series (sensor data)           -> Classical time-series anomaly

Q2. What's the response path when anomaly detected?
  Automated block / stop              -> Requires near-perfect precision; hard
  Alert + human decision              -> Standard pattern; feasible
  Log only, review later              -> Low-risk; simpler

Q3. Volume + base rate?
  High volume, rare anomalies         -> Classical fits; precision challenge
  Low volume, frequent anomalies      -> LLM classification fits
  Mixed                               -> Hybrid; segment upfront

Q4. Explainability required?
  Regulated / auditable               -> Classical models preferred; or LLM-narrated classical
  Internal use only                   -> LLM end-to-end acceptable
```

**Service shape:** Setup + monthly monitoring. Overage on high-alert periods.
**Risk flags:** False-positive fatigue destroys value fast. Spend effort on precision, not recall.

---

## Tree 10 — "We have data but no insights"

**Opportunity category:** 10 — Reporting & insights.

```
Q1. Where does data live?
  Single warehouse / BI tool    -> LLM-over-SQL or LLM-over-BI fit
  Multiple sources, no warehouse -> Data-integration is pre-requisite phase
  Spreadsheets                   -> Sheet-based reporting with LLM narrative only
  No consolidated data           -> Data platform is phase 1

Q2. What kind of insights?
  Daily operational metrics      -> Automated dashboard + email narrative
  Periodic performance reviews   -> Monthly/quarterly report with LLM synthesis
  Exploratory / ad-hoc           -> Chat-with-your-data interface

Q3. Who's the audience?
  Non-technical leadership       -> Strong narrative layer; minimal numbers
  Operational managers           -> Dashboard-first with drill-downs
  Analysts                       -> Self-serve + chat interface
```

**Service shape:** Low monthly managed. Setup depends on data state.
**AI fit:** LLM over structured data. Must cite underlying rows; no unsupported claims.

---

## Tree 11 — "We want to build our own chatbot"

Refuses commodity-chatbot scope; redirects to higher-value shapes.

```
Q1. What's the real goal?
  Support deflection         -> Tree 2 (customer-support)
  Lead qualification         -> Funnel skill + qualified-lead-capture design
  Internal knowledge         -> Internal RAG assistant
  "Just want AI on our site" -> Push back; no outcome = no service

Q2. If "internal RAG":
  Knowledge source stable?              -> Green
  Knowledge changes weekly+?            -> Add refresh cadence + ownership
  Sensitive / restricted content?       -> Access-control design required
  No existing KB structure?             -> KB build is phase 1
```

**Service shape:** Setup + monthly. Price based on integration + KB complexity, not "it's a chatbot".

---

## Tree 12 — "We want to use AI for sales outreach / cold email"

Cautious tree. Easy to get wrong.

```
Q1. Target audience + scale?
  Small named top-100 outreach list    -> Cross-link `/linkedin-optimizer`; manual-assisted
  Existing inbound contacts            -> Follow-up (Tree 4)
  Cold mass-email                       -> Refuse or re-shape; deliverability + ethics collapse

Q2. If top-100 outreach approach:
  Service shape = research + drafting assistant, not automated sender.
  Human writes/sends final message.
  Tool saves research and drafting time, not sending time.
```

**Refusal rule:** if the ask is "send thousands of personalised cold emails automatically", re-scope or refuse. The regulatory and deliverability risk isn't worth the margin.

---

## Tree 13 — "We want to automate our bookkeeping"

```
Q1. What's the boundary?
  Data entry from receipts / invoices     -> Tree 1 (doc extraction)
  Reconciliation                           -> Rule-based + LLM edge cases
  Tax advice / filings                     -> REFUSE; named accountant required
  Reporting from accounting software       -> Tree 10 (reporting + insights)

Q2. Regulated professional involved?
  Yes (client has a bookkeeper / accountant) -> Service augments their work
  No                                           -> Refuse anything beyond data-entry automation
```

**Refuse:** tax advice, filing decisions, compliance sign-off. Those need a named professional.

---

## Tree 14 — "We want to use AI to write legal documents"

Short tree.

```
Q1. Who's the end-reader?
  Client will sign without legal review -> REFUSE
  Lawyer will review and edit           -> Drafting-assistant scope acceptable
  Internal-only document                -> Green, with caveats
```

**Refusal rule:** no AI-generated legal output goes to a counterparty without a named lawyer's review. Scope accordingly.

---

## Tree 15 — "We want AI to help with HR / recruitment"

```
Q1. What's the task?
  JD drafting, job-ad copy                       -> Content generation (Tree 5)
  Resume screening                                -> High-risk bias area; refuse automation
  Interview note-taking / summarisation           -> Green with candidate consent
  Onboarding content                              -> Green
  Performance review generation                   -> Refuse fully-automated; drafting only

Q2. Bias + discrimination assessment?
  Any automated ranking / scoring of candidates  -> REFUSE or involve specialist + audit
  Drafting + summarisation only                   -> Green with consent + transparency
```

**Refusal rule:** automated scoring of candidates without a formal bias-audit process is out of scope for a solo-operator AI service.

---

## Meta-tree — How to use these trees

1. Identify which tree matches the client's stated problem.
2. Walk the tree questions during discovery Call 1 (F10).
3. If the tree lands on "refuse" or "re-scope", use the language in the tree to redirect.
4. If the tree lands on a service type, proceed to Template 2 (service brief) and Template 4 (SOW).
5. If the problem doesn't fit any tree, that's a signal: is the opportunity worth designing from scratch, or is the client asking for something AI can't reliably do?

**When to refuse:**
- Any tree that ends in REFUSE.
- Any client who won't name an accountable human for HITL.
- Any regulated domain without named professional oversight.
- Any outcome that requires AI to be right 100% of the time without human review.
