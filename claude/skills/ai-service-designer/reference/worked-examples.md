# AI Service Designer — Worked Examples

Three full composite engagements showing the skill applied end-to-end: client context, opportunity analysis, service scope, pricing, risks, expected outcome. Each is ~200 lines.

All examples are fictional composites built to illustrate the method.

---

## Example 1 — Ashworth & Keane Accountants (document-intake automation)

### Client context

Ashworth & Keane is a 14-person mid-size accounting firm in a regional area. Partners are Jon Ashworth and Priya Keane. They serve 240 small-business clients across trades, hospitality, and allied health. Revenue ~$2.4M/year, EBITDA ~22%.

Their problem: quarterly tax-filing crunch weeks require three juniors to manually key receipts and invoices from client emails, Dropbox folders, and physical folders into their accounting platform. Each junior spends 20+ hours/week on data entry during crunch weeks (roughly 9 weeks/year). That's ~540 junior-hours/year burned on keystrokes that add zero billable value. Junior turnover has been rising and Priya suspects the boredom is a factor.

Maturity: Level 2–3 (they use a cloud accounting platform, Microsoft 365, Dropbox; Zapier for a couple of simple flows).

Urgency driver: one junior just resigned citing "soul-crushing admin". Partners don't want to replace her — they want to kill the work.

### Opportunity analysis

**Tree check** (`reference/decision-tree.md` Tree 1): high volume, varied document structure, contaminates regulated records (tax returns). Recommends LLM-based extraction with schema, HITL review-before-send on high-stakes entries.

**F1 capability matrix:** extraction = green zone. Narrative reason for flagged items = green. Automated tax-filing submission = red zone — do not scope.

**Opportunity score (Template 1):**
- Time saved: 9 (~540 hours/year × $75/hr internal cost = ~$40K cost base)
- Revenue impact: 6 (reclaimed time converts to ~$60K additional billable capacity at 0.5 utilisation)
- TAM: 8 (every accounting firm has this problem)
- Data readiness: 7 (docs exist but live in multiple places — lineage needs work)
- AI capability fit: 9 (green-zone with HITL)
- Delivery effort: 6 (moderate — needs integrations + UI)
- Recurring-revenue shape: 9 (classic retainer)
- Risk profile: 6 (regulated financial records; HITL mandatory)
- Pricing model clarity: 8 (setup + monthly fits perfectly)
- Competitive position: 6 (some tools exist — Dext, Hubdoc — but firm wants bespoke integration)

Weighted: 7.6/10 → strong candidate.

### Service scope

**Service name:** Document Automation — Accounting (named service).

**Outcome:** reduce monthly data-entry effort from 60 junior-hours to under 10 junior-hours within 90 days of go-live, with error rate under 2%.

**What we deliver:**
- Email ingest pipeline: dedicated inbox that auto-ingests forwarded receipts/invoices.
- OCR + LLM extraction with a supplier-aware schema (20+ common supplier templates pre-loaded, LLM handles novel ones).
- Review queue in a lightweight web UI: junior reviews items with low confidence scores; rest push through.
- Write-back to the accounting platform via its public API.
- Weekly quality report: volume processed, error rate, time saved, flagged items.

**What we do NOT deliver:**
- Tax-filing submission decisions (firm's responsibility).
- Handling of physical paper (client must scan or photograph).
- Legal or tax advice.

**HITL pattern:** escalation-on-uncertainty. Confidence threshold tuned in first 4 weeks; anything below threshold lands in the review queue. Fortnightly sample-audit of 10% of pushed-through items.

**Tech stack:**
- OCR: Amazon Textract or equivalent (buy; pick a region with appropriate data-residency).
- LLM: Claude / GPT-4 via API with zero-retention endpoint (buy; abstracted so we can switch).
- Workflow: n8n self-hosted (own infra — keeps sensitive data in the client's data-residency region).
- Review UI: lightweight Next.js app on Cloudflare (build — this is our IP).
- Write-back: accounting-platform API (buy; standard).

### Pricing

**Setup fee:** $8,500 (covers discovery, 4 weeks build, integration testing, junior training).

**Monthly fee:** $1,200/month (covers ops, drift monitoring, minor enhancements, weekly QA review).

**Per-unit overage:** 2,000 docs/month included. $0.12/doc beyond.

**Year 1 total** (at typical volume): $8,500 + ($1,200 × 12) = $22,900.

**Margin check:**
- Per-client LLM cost: ~$90/month at 1,500-doc volume.
- OCR cost: ~$60/month.
- Infra + monitoring: ~$40/month.
- Delivery hours: ~6 hours/month @ $150/hr = $900.
- Total variable: ~$1,090.
- Margin on $1,200 monthly: ~9% — too thin.

**Re-priced:** monthly fee raised to $1,650. Margin ~34%. Still below 50% target — so we shift model to more setup-heavy ($12,000 setup, $1,650 monthly) after explaining the client saves ~$36K/year in junior cost regardless.

### Risk register (abbreviated)

| # | Risk | Mitigation |
|-|-|-|
| R1 | Hallucinated line items on invoices (wrong supplier, wrong amount) | Confidence threshold + review queue; sample audit 10% |
| R2 | Regulated data exposure (client financial records) | Data-residency-compliant infra; zero-retention LLM; signed DPAs |
| R3 | Vendor continuity (Textract or LLM deprecation) | Abstraction layer; secondary vendor tested quarterly |
| R4 | Scope drift — partners want automated tax-filing submission next | Written change-order process; filing submission explicitly excluded |
| R5 | Junior review bottleneck | SLA on review turnaround; partners notified if queue > 4 hours |
| R6 | Supplier adds novel document format | LLM handles via prompt; flagged for schema update monthly |

### Expected outcome (90-day post-go-live)

- Junior hours on data entry: 60/month → 7/month (steady state month 3).
- Junior retention: qualitative improvement — less boredom work.
- Firm's additional billable capacity: ~40 hours/month freed for billable work. At $220/hr client rate, ~$8,800/month of latent revenue.
- Error rate: target <2%. Actual first-month typically 4–5%, stabilising to <2% by week 8.
- Client ROI: payback within month 3 — $22,900 annual spend vs ~$40K saved junior cost + ~$60K latent revenue.

### Productisation note

After three similar accounting engagements, template the supplier schema library and the onboarding flow. After six, launch a packaged "Document Automation for Accountants" with published pricing at $9,500 / $1,650. Retain the custom tier for larger firms (30+ staff) who need deeper integration.

---

## Example 2 — Harbourview Property (call triage after-hours)

### Client context

Harbourview Property is a residential property management agency in a mid-sized coastal city. 6 property managers, 3 admin, 2 principals (Amelia Voss, Dieter Schoeman). ~480 properties under management across the surrounding region.

Their problem: after-hours emergency calls from tenants. Each property manager rotates on-call. Two specific pain points:
1. Non-emergencies wake them up (tenant locked out, noise complaint, "the toilet's a bit slow").
2. Real emergencies (burst pipe, ceiling leak, smoke alarm) sometimes get missed because the on-call PM is asleep or the message goes to voicemail.

Maturity: Level 2. They use a property-management SaaS, a shared spreadsheet for after-hours roster, voicemail inbox. No automation.

Urgency driver: the state/regional property-trading regulator is scrutinising a complaint about a missed ceiling leak that damaged a downstairs unit. Insurance covered the damage but the principals want evidence of systematic after-hours cover for future incidents.

### Opportunity analysis

**Tree check** (`reference/decision-tree.md` Tree 3): mix of booking-style and emergency calls. Named human on-call backup MUST be in scope. No fully-autonomous.

**F1 capability matrix:** voice LLM = green for triage. Urgency classification = green. Booking integration = green. Emergency dispatch decision = red (needs human).

**Opportunity score (Template 1):** weighted 7.9/10.

### Service scope

**Service name:** Receptionist — After-Hours Property (named).

**Outcome:** answer 100% of after-hours calls within 3 rings, classify urgency correctly 95%+, escalate real emergencies to on-call PM within 2 minutes, send non-emergencies to email queue for next business morning.

**What we deliver:**
- Dedicated after-hours phone number.
- Voice AI answers, captures tenant + property, classifies urgency.
- Three-level routing:
  - **Emergency** (life safety, major damage): SMS + voice call to on-call PM with 2-minute re-try loop until acknowledged.
  - **Urgent** (no hot water, no heat in winter): email to on-call inbox; SMS notification.
  - **Non-urgent**: captured in next-day queue; tenant gets SMS confirmation.
- Compliance log: every call recorded, transcribed, archived for 3 years (insurance + regulatory).
- Weekly report: volume, classification accuracy, escalation response times.

**What we do NOT deliver:**
- Business-hours reception (separate scope).
- Maintenance dispatch to tradies (PM still owns).
- Legal or financial tenant advice.

**HITL pattern:** escalation-on-uncertainty. Any call the model isn't 80% confident about → routes to emergency path by default (safer to over-escalate early).

**Tech stack:**
- Voice platform: Twilio Voice + Retell/Vapi-equivalent voice LLM (buy).
- LLM: a frontier model for classification (Claude, GPT-4-class, or equivalent — buy, abstracted so we can switch).
- SMS + retry loop: Twilio (buy).
- Email queue: SMTP into the property-management SaaS inbox (buy).
- Transcription + archive: Whisper + S3 (buy; region selected for data residency).
- Orchestration: n8n self-hosted (build — our IP).

### Pricing

**Setup fee:** $6,500 (discovery, script design, PM on-call workflow integration, 4 weeks build + test, staff training).

**Monthly fee:** $950/month (covers line, minutes, ops, weekly QA).

**Per-minute overage:** 300 call minutes/month included. $0.35/minute beyond.

**Year 1 total** (typical volume): $6,500 + ($950 × 12) = $17,900.

**Margin check:** steady-state variable cost ~$280/month. Margin on $950 ≈ 70% — healthy.

### Risk register (abbreviated)

| # | Risk | Mitigation |
|-|-|-|
| R1 | Missed emergency — classification fails or escalation breaks | Over-classify by default; 2-minute re-try loop; named backup PM; weekly simulation test |
| R2 | Wrong information given to tenant | Voice prompt restricts the model to triage and routing — no advice; transcripts audited |
| R3 | Recording compliance (two-party-consent jurisdictions) | Greeting includes consent notice; recording log archived + encrypted |
| R4 | Voice model misclassifies accents or dialects | Test matrix in onboarding; sample audit weekly first month |
| R5 | Phone-line outage | Twilio's uptime SLA + failover number (our mobile rings if Twilio down) |
| R6 | PM doesn't acknowledge escalation | Secondary + tertiary escalation contacts required in SOW |

### Expected outcome (90-day post-go-live)

- After-hours calls answered: voicemail rate 0% (previously ~40%).
- Emergency classification accuracy: 95%+ target; 98% actual by week 8 in typical case.
- Time-to-PM on real emergency: median 90 seconds (previously ~40 minutes if voicemail picked up).
- PM after-hours call load: ~70% of calls deflected from PM phone (non-emergencies handled without waking them).
- Insurance + regulatory posture: complete compliance log available on request; significant de-risk vs the previous voicemail-and-hope model.
- Client ROI: primary ROI is operational sanity + compliance, not revenue. Principal interviews describe "sleeping through the night for the first time in years" — that's the emotional hook for case-study content.

### Productisation note

Template the voice prompt for property management specifically. After three property management engagements, publish packaged pricing at $7K / $950. Adjacent verticals (real-estate sales, holiday rental) can reuse 70% of the setup — a useful adjacency.

---

## Example 3 — Copperline Consulting Group (proposal generation)

### Client context

Copperline is a 9-person management consulting firm specialising in supply-chain transformation for mid-market manufacturers. Founders are Harriet Ferro-Bell and Vikram Oduya. ~$4.2M/year revenue, 68% gross margin.

Their problem: every new engagement proposal takes 12–20 hours of senior consultant time. 60–70% of each proposal is reused content (firm background, methodology, past case studies, standard pricing tables). The remaining 30–40% is bespoke (diagnosis of the client's specific situation, recommended scope). They lose an average of 8 hours per proposal to formatting, updating outdated sections, chasing the right case studies, and reformatting pricing tables.

Maturity: Level 3. They use SharePoint for content libraries, Notion for internal wikis, DocuSign for sign-off, HubSpot CRM.

Urgency driver: proposal win rate has dropped from 41% to 28% over 18 months. Founders suspect proposal quality is slipping because senior consultants rush the bespoke sections after burning time on the reused parts.

### Opportunity analysis

**Tree check** (`reference/decision-tree.md` Tree 7): 65% reused, structured brief input, pricing logic partly rule-based, standard T&Cs. Strong fit for templated proposal-generation with LLM-assisted drafting + HITL review-before-send mandatory.

**F1 capability matrix:** template filling = green. Pricing draw-down = green (tool-based calculation). Narrative generation from client brief = green. Final legal / pricing decisions = red (HITL mandatory).

**Opportunity score (Template 1):**
- Time saved: 8 (4–6 hours per proposal × 40 proposals/year = 200 hours/year at $300/hr internal = $60K)
- Revenue impact: 9 (win-rate recovery of even 5% = ~$350K additional annual revenue on pipeline)
- Data readiness: 9 (content already organised in SharePoint + Notion)
- AI capability fit: 9 (green-zone, HITL mandatory)
- Delivery effort: 7 (moderate — content refactor + UI)
- Recurring-revenue shape: 8 (retainer-natural for content updates + prompt tuning)
- Risk profile: 8 (low — outputs always reviewed)
- Pricing model clarity: 9 (setup + monthly + per-proposal fits)
- Competitive position: 7 (generic proposal tools exist but none consulting-specific)

Weighted: 8.3/10 → strong candidate.

### Service scope

**Service name:** Proposal Generation — Consulting (named).

**Outcome:** reduce proposal-drafting time from 16 hours to under 6 hours per proposal within 60 days, maintain quality (measured via win rate + senior consultant satisfaction survey).

**What we deliver:**
- Web-based proposal builder interface.
- Input: structured brief form (client, problem, scope inputs, timeline, pricing tier).
- LLM-assisted draft generation: assembles reused sections + drafts bespoke sections from the brief.
- Content library integration: pulls current firm bio, methodology, case studies from SharePoint (no stale sections).
- Pricing draw-down tool: applies standard rate card based on scope inputs, flags anomalies.
- Review workflow: draft → senior review → partner sign-off → PDF export + DocuSign send.
- Version history + search: all past proposals searchable; similar-engagement suggestions.

**What we do NOT deliver:**
- Final proposal sign-off (partners own).
- Pricing approval outside rate-card range (requires partner).
- Legal clauses beyond the standard library (legal counsel involvement required).
- CRM / project-management updates post-sign (out of scope).

**HITL pattern:** review-before-send is mandatory and non-negotiable. No proposal leaves the system without senior + partner sign-off.

**Tech stack:**
- Frontend: Next.js on Vercel (build — our IP).
- LLM: Claude / GPT-4 via API (buy, abstracted).
- Content retrieval: Microsoft Graph API → SharePoint (buy).
- CRM integration: HubSpot API (buy).
- DocuSign integration (buy).
- Hosting: data-residency-compliant infra; firm owns their tenant.

### Pricing

**Setup fee:** $18,500 (discovery, content-library refactor, 6 weeks build, 2 weeks piloting, consultant training).

**Monthly fee:** $1,800/month (covers ops, content refresh, prompt tuning, minor enhancements, quarterly review).

**Per-unit overage:** 12 proposals/month included. $45/proposal beyond.

**Year 1 total** (typical volume): $18,500 + ($1,800 × 12) = $40,100.

**Margin check:**
- Per-client LLM cost: ~$120/month at 15-proposal volume.
- SharePoint/HubSpot API calls: ~$30/month.
- Hosting: ~$80/month.
- Delivery hours: ~7 hours/month @ $175/hr = $1,225.
- Total variable: ~$1,455.
- Margin on $1,800: ~19% — too thin.

**Re-priced:** monthly raised to $2,500 after discovery demonstrates $60K annual time savings + $350K potential revenue recovery. Margin ~42% — close to target; accepted with understanding that some months (heavy content updates) will run closer to break-even.

### Risk register (abbreviated)

| # | Risk | Mitigation |
|-|-|-|
| R1 | Generic / off-brand draft reaches a client | Mandatory senior + partner review; no auto-send; voice prompt tuned to firm tone |
| R2 | Wrong pricing in draft proposal | Rule-based draw-down + visible pricing summary + partner approval gate |
| R3 | Outdated case study used | Content library has expiry dates + flagging for case studies older than 18 months |
| R4 | Data leakage (client info in prompts) | Zero-retention API + no cross-client data pooling |
| R5 | Vendor LLM deprecated mid-quarter | Abstraction layer; secondary vendor test monthly |
| R6 | Consultant over-reliance, quality slips | Quarterly draft-quality sample audit by partners |
| R7 | Scope drift — firm wants marketing content, case-study generation | Written change-order process; both explicitly out of scope |

### Expected outcome (60-day post-go-live)

- Proposal drafting time: 16 hrs → 5.5 hrs (target); typical week-4 result 7 hrs dropping to 5 by week 8.
- Win rate: measure at month 4 and 8; target return to 35%+ within 8 months. Primary levers are more senior-time on the bespoke diagnosis sections and less fatigue.
- Consultant sentiment: measured via quarterly survey. Target shift from "rushed and resentful" to "focused on what matters".
- Content library hygiene: as a side-effect, content gets refreshed and indexed — measurable reduction in "where's the latest version of X" slack searches.
- Client ROI: setup pays back in ~3 months on time savings alone. Win-rate recovery is the bigger prize but takes longer to demonstrate.

### Productisation note

After three consulting-firm engagements, the content-library refactor becomes a templated sub-engagement ($5K fixed fee). After five, package the whole thing at $19K setup / $2,500 monthly with published pricing. Adjacent verticals (agencies, accounting firms, legal) can reuse 60% of the core system.
