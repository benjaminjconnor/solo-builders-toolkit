# AI Service Designer — Audit Checklist

Two layers. Run the 10-point quick diagnostic first. Any red flag triggers the full 8-section / 60-item audit.

---

## Layer 1 — 10-point quick diagnostic

Use when evaluating whether to pursue a service, or as a 15-minute sanity check on an existing one. Score each as PASS / FAIL / UNKNOWN.

| # | Check | PASS state | FAIL state |
|-|-|-|-|
| 1 | Outcome is defined in one sentence, measurable, time-bound | "Reduce overdue invoices from 30 days to 10 days within 90 days" | "Improve accounts receivable" |
| 2 | Automation scope is bounded — the service has a clear start and stop | Service starts at event X, produces output Y, stops when Z | Open-ended "AI help across the business" |
| 3 | Data access is confirmed — we've seen sample data or have a path to it | Sample docs, API access, or test dataset in hand | "We'll figure out data later" |
| 4 | AI capability fit is green-zone (or amber with HITL) | On the F1 matrix, task sits in green zone OR HITL is designed | Task is red-zone and no HITL |
| 5 | HITL pattern is chosen and documented | Review-before-send / sample audit / escalation-on-uncertainty — one is picked | "We'll add review if issues come up" |
| 6 | Pricing model fits effort shape | Front-loaded -> project + retainer; steady -> retainer; variable -> per-unit | Time-and-materials for templated work, or retainer for one-shot |
| 7 | Exit criteria are defined | Service ends / renews / upgrades at known milestones | No defined endpoint |
| 8 | Risk register has at minimum 5 entries | Hallucination, data leakage, compliance, vendor continuity, scope drift covered | Fewer than 5, or missing a category |
| 9 | Offer-ladder placement is explicit | Rung named + next rung identified | "It's a service, I dunno where it fits" |
| 10 | Gross margin at target price ≥ 50% | Tech costs + labour costs + overhead < 50% of fee | Margin unknown or under 50% |

**Interpretation:**
- 9–10 PASS → proceed.
- 7–8 PASS with specific UNKNOWNs → clarify in next discovery call.
- Any FAIL on 1, 3, 4, or 6 → do not proceed without fixing. These are load-bearing.
- 5 or fewer PASS → service is not ready; start again from the service brief.

---

## Layer 2 — Full 60-item audit

Eight sections, each scored on a 0/1/2 rubric. Run on any service before launch, and on any existing service quarterly.

**Scoring:** 0 = not present / broken, 1 = partial, 2 = complete / production-ready.
**Max score:** 120.

---

### Section 1 — Outcome + problem fit (10 items)

- [ ] 1.1 Outcome stated in one sentence
- [ ] 1.2 Outcome is measurable
- [ ] 1.3 Outcome has a time horizon
- [ ] 1.4 Client's current pain quantified (hours, dollars, error rate)
- [ ] 1.5 Counterfactual stated ("if we do nothing, X happens")
- [ ] 1.6 Problem shape matches a decision tree in `reference/decision-tree.md`
- [ ] 1.7 Market evidence that others want the same outcome (not just this one client)
- [ ] 1.8 Named stakeholder owns the outcome on the client side
- [ ] 1.9 Urgency driver documented (why now?)
- [ ] 1.10 Service won't be obsoleted by next quarter's platform update

**Section 1 score:** ___ / 20

---

### Section 2 — AI capability + data fit (8 items)

- [ ] 2.1 Each sub-capability mapped to F1 capability matrix
- [ ] 2.2 Red-zone capabilities either removed from scope or covered by HITL
- [ ] 2.3 LLM vs classical-ML decision documented per component (F7)
- [ ] 2.4 Data access is confirmed and documented (format, location, refresh cadence)
- [ ] 2.5 Data volume is within target model's context / cost range
- [ ] 2.6 Data quality assessed — sample reviewed for errors, inconsistencies, gaps
- [ ] 2.7 Data lineage documented — who owns it, where it's sourced, how it's refreshed
- [ ] 2.8 Evaluation plan exists — how we'll measure output quality (held-out set, sample audit, etc.)

**Section 2 score:** ___ / 16

---

### Section 3 — Scope + boundary (6 items)

- [ ] 3.1 Scope sentence is ≤ 3 lines
- [ ] 3.2 Deliverables list is numbered and countable
- [ ] 3.3 Assumptions list names dependencies (client action, data, access)
- [ ] 3.4 Exclusions list is explicit (what we won't do)
- [ ] 3.5 Change-order process defined (how scope changes get priced)
- [ ] 3.6 End state defined (go-live, handoff, ongoing operation)

**Section 3 score:** ___ / 12

---

### Section 4 — Pricing + margin (8 items)

- [ ] 4.1 Effort shape classified (linear / front-loaded / recurring / variable / per-unit)
- [ ] 4.2 Pricing model matches effort shape (see F4)
- [ ] 4.3 Setup fee covers front-loaded engineering + discovery
- [ ] 4.4 Monthly fee covers ops, drift, minor enhancements
- [ ] 4.5 Per-unit overage defined if usage can spike
- [ ] 4.6 Per-client tech-stack cost calculated
- [ ] 4.7 Per-client labour cost calculated (hours × rate)
- [ ] 4.8 Gross margin at target price ≥ 50%

**Section 4 score:** ___ / 16

---

### Section 5 — Risk + compliance (8 items)

- [ ] 5.1 Risk register has all 5 standard categories (hallucination, data leakage, compliance, vendor continuity, scope drift)
- [ ] 5.2 Service-specific risks added (call triage: misclassified emergency; doc extraction: wrong-field contamination; etc.)
- [ ] 5.3 Each risk has a mitigation documented
- [ ] 5.4 Each risk has an owner assigned
- [ ] 5.5 Regulated-domain exposure evaluated (health, finance, legal)
- [ ] 5.6 If regulated, named accountability documented
- [ ] 5.7 Data protection agreement signed with vendors
- [ ] 5.8 Privacy obligations documented (GDPR, CCPA, HIPAA, the applicable national privacy law, etc.)

**Section 5 score:** ___ / 16

---

### Section 6 — HITL + operations (6 items)

- [ ] 6.1 HITL pattern chosen (review-before-send / sample audit / escalation-on-uncertainty)
- [ ] 6.2 Reviewer identified (us / client / named third party)
- [ ] 6.3 SLA for review documented
- [ ] 6.4 Escalation path has 3 levels with named contacts
- [ ] 6.5 Failure modes documented with recovery steps
- [ ] 6.6 Ops runbook complete (Template 7)

**Section 6 score:** ___ / 12

---

### Section 7 — Vendor + tech-stack (6 items)

- [ ] 7.1 Each capability mapped to buy / build / partner (F6)
- [ ] 7.2 Vendor short-list has at least 2 options per capability (switch plan)
- [ ] 7.3 Abstraction layer allows switching primary LLM within a week
- [ ] 7.4 Vendor pricing modelled against service volume
- [ ] 7.5 Vendor DPAs signed for any data-touching service
- [ ] 7.6 Deprecation risk assessed (is the model / platform likely to be deprecated? what's plan B?)

**Section 7 score:** ___ / 12

---

### Section 8 — Offer-ladder + productisation (8 items)

- [ ] 8.1 Offer-ladder rung named
- [ ] 8.2 Natural next rung identified
- [ ] 8.3 Natural previous / downgrade rung identified
- [ ] 8.4 Productisation stage documented (custom / templated / packaged / self-serve)
- [ ] 8.5 If templated+: templates for SOW, brief, runbook exist
- [ ] 8.6 If packaged+: public pricing page exists
- [ ] 8.7 Name is short, concrete, memorable (not a description)
- [ ] 8.8 One-liner passes "10-second read test" — does a skim-reader understand the outcome?

**Section 8 score:** ___ / 16

---

## Overall score card

| Section | Items | Score | Max | % |
|-|-|-|-|-|
| 1. Outcome + problem fit | 10 | _ | 20 | _ |
| 2. AI capability + data fit | 8 | _ | 16 | _ |
| 3. Scope + boundary | 6 | _ | 12 | _ |
| 4. Pricing + margin | 8 | _ | 16 | _ |
| 5. Risk + compliance | 8 | _ | 16 | _ |
| 6. HITL + operations | 6 | _ | 12 | _ |
| 7. Vendor + tech-stack | 6 | _ | 12 | _ |
| 8. Offer-ladder + productisation | 8 | _ | 16 | _ |
| **Total** | **60** | _ | **120** | _ |

**Interpretation:**
- 100–120 (83%+) — ready to launch.
- 80–99 (67–82%) — fix gaps in the lowest-scoring section first.
- 60–79 (50–66%) — significant gaps; prioritise Sections 1, 2, 4.
- <60 (<50%) — service needs a rebuild, not a patch.

---

## Priority fix order

When scores are low, fix sections in this order. Each depends on the previous.

1. **Outcome + problem fit (Section 1)** — nothing else matters if the outcome isn't clear and measurable.
2. **AI capability + data fit (Section 2)** — no data, no service; wrong capability, no outcome.
3. **Scope + boundary (Section 3)** — without a bounded scope, pricing is fiction.
4. **Pricing + margin (Section 4)** — if you can't make money at target price, don't build.
5. **Risk + compliance (Section 5)** — launch with eyes open; never post-hoc.
6. **HITL + operations (Section 6)** — design oversight before the first failure.
7. **Vendor + tech-stack (Section 7)** — de-risk vendor continuity before production volume.
8. **Offer-ladder + productisation (Section 8)** — only worth investing once the above are solid.

---

## Quarterly review schedule

For live services:

| Quarter | Focus | Depth |
|-|-|-|
| Q1 | Full audit (all 8 sections) | Deep — set baseline |
| Q2 | Sections 4, 5, 6 (margin, risk, ops) | Medium |
| Q3 | Sections 2, 7 (capability drift, vendor landscape) | Medium |
| Q4 | Full audit + annual strategy review | Deep — inform next year's plan |

**Between audits:** monthly margin check + weekly HITL sample-audit output review.
