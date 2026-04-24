# AI Service Designer — Knowledge Base

Conceptual foundations for designing AI services. Not a how-to — this is the "why" layer. Read this when a design decision feels arbitrary or you need to explain a trade-off to a client.

---

## 1. Where AI creates economic surplus

Three distinct value pools. Services concentrate in one; the best services combine two.

### 1.1 Labour-cost disruption

AI reduces the cost of producing an output that used to require a human. The surplus shows up as labour-cost savings or freed capacity.

**Examples:**
- A bookkeeper's 20 hours of data entry → 2 hours of review.
- A consultant's 12 hours of proposal drafting → 5 hours.
- A property manager's 40 hours of after-hours standby → passive monitoring.

**Service design implication:** the client's internal cost of the current process is your ceiling for pricing. If they spend $40K/year on the task, a $25K/year service with a clear payback is defensible.

**Trap:** the value isn't in the hours saved, it's in what those hours become. If freed hours go back into more of the same work, your service produces cost savings. If they go into higher-value work (client-facing, strategic, creative), your service produces capacity and revenue gain — and commands a much higher price.

### 1.2 Personalisation at scale

AI produces individually-tailored outputs at near-zero marginal cost. The surplus is the gap between "generic content" and "personalised-feeling content" × volume.

**Examples:**
- Product descriptions varied by audience segment, tested by LLM.
- Outreach messages referencing a specific recipient's recent activity.
- Support responses that use the customer's name, history, and tone.

**Service design implication:** pricing follows perceived personalisation × conversion lift. If personalisation raises conversion by 10% on a $1M revenue line, the service can capture $10–30K/year of that lift.

**Trap:** personalisation that feels formulaic erodes trust faster than generic content. Aim for "thoughtful" not "stuffed with tokens".

### 1.3 Error reduction + detection

AI catches mistakes and anomalies that humans miss because of volume or fatigue. The surplus is the avoided cost of undetected errors.

**Examples:**
- Duplicate invoice detection saves a manufacturer $60K/year in double-payments.
- Quality-control vision model catches defects before packaging.
- Call triage catches a real emergency that voicemail would have buried.

**Service design implication:** the client cares about the worst-case avoided cost, not the average. Frame in downside terms ("what one missed incident costs you") not throughput terms.

**Trap:** false-positive rate destroys value faster than false-negative rate in detection services. A 98% accuracy service that cries wolf once per week gets switched off within a month.

---

## 2. Where AI falls over

Design decisions that assume AI can do something it can't reliably do.

### 2.1 Hallucination

LLMs produce confident-sounding text that is factually wrong. This is a feature of the model architecture, not a bug that will be fixed next year.

**Implications for service design:**
- Never design a service where an unverified LLM output reaches a counterparty or a regulated record.
- HITL is not optional in high-stakes outputs — it's the load-bearing wall.
- Grounding reduces hallucination but doesn't eliminate it. RAG answers hallucinate when retrieval fails.
- Evaluation sets must include adversarial prompts, not just happy-path examples.

**Practical heuristic:** "If an error cost more than 10× the per-output fee, humans review."

### 2.2 Data dependence

Model quality is a direct function of input data quality. Garbage in, confidently wrong garbage out.

**Implications:**
- Always audit data before pricing. Access, quality, lineage.
- "We have data" from a client usually means "we have some data somewhere, formats unknown".
- Data-engineering work is often phase 1 of a service engagement, priced separately.
- Drift is real. Data that worked at launch can drift within months.

### 2.3 Context-window limits + cost

Models have finite context. Long contexts are expensive.

**Implications:**
- Retrieval-augmented generation (RAG) is how you handle knowledge too big to fit in context.
- Chunking strategy matters — poor chunking breaks meaning.
- Per-call cost scales with tokens; services with long inputs become unprofitable fast.
- Caching (especially prompt caching) is a margin lever — build it in.

### 2.4 Multi-step reasoning

Chained reasoning degrades with depth. A model that answers single questions reliably at 95% precision can produce 5-step chains at 70% precision (compounding).

**Implications:**
- Decompose complex tasks into discrete verifiable steps.
- Test each step's output before chaining.
- If a service requires 4+ reasoning hops, prefer a pipeline of narrower models (or classical + LLM hybrid) over a single "think about it" prompt.

### 2.5 Real-time truth

LLMs don't know today's date, today's prices, or what just happened. Base models are frozen at training.

**Implications:**
- Any time-sensitive task needs tool use (web search, API lookup) or explicit retrieval.
- Never let a client-facing service claim real-time knowledge unless it verifiably has it.

---

## 3. Why HITL matters

Three reasons, in order of importance.

### 3.1 Legal + compliance defensibility

When something goes wrong — and eventually something will — you need a named human accountable for each material output. "The AI did it" does not stand up in regulatory proceedings or insurance claims.

**Design implication:** design HITL around regulatory requirements first, error-reduction second. Health, finance, legal, and other regulated domains require named accountability that can't be delegated to a model.

### 3.2 Quality calibration

Models drift. Data distributions shift. What worked at launch may not work in 3 months. HITL isn't just about catching errors — it's the mechanism that detects drift.

**Design implication:** even in low-stakes services, sample-audit 5–10% of outputs. The audit produces your quality signal over time.

### 3.3 Client confidence

Clients who see a human in the loop trust the service longer. Clients who learn later that "it's all AI" start second-guessing everything.

**Design implication:** transparency. Put the HITL design in the SOW, show it in reports, don't hide it.

---

## 4. Pricing novel work

AI services often sit in "no one has priced this before" territory. Rules of thumb:

### 4.1 Value-anchored, not cost-anchored

Price against the client's current cost of the problem, not your cost of delivering the solution. If their current solution costs $40K/year and yours saves 80% of that with better quality, you can capture $15–25K/year.

### 4.2 Effort shape determines the model (not "hours")

See Frameworks § F4. Hourly billing for AI services punishes efficiency. If you get fast at something, hourly billing reduces your fee. Fixed + retainer rewards efficiency.

### 4.3 Include the drift tax

Every LLM-based service has a drift tax: prompts degrade, models get deprecated, vendor pricing shifts. Bake ~10% of monthly fee into "ongoing maintenance" — not as a line item, but as margin that covers inevitable re-work.

### 4.4 Beware the "cheap AI" race

Clients will see headlines about AI getting cheaper. Some of that is real (API prices drop), most is not (prompt engineering + evaluation + integration costs don't drop). Don't compete on price against tools; compete on outcomes.

### 4.5 First engagement is the anchor

Whatever you charge your first client sets the anchor for your second. First-client pricing is a strategic decision, not "charge as little as possible to get started". A too-low first price traps you in a low-price corridor for years.

---

## 5. Vendor lock-in trade-offs

Every tech-stack decision is a bet on vendor stability. Four rules:

### 5.1 Abstract the model layer

Always. LLM APIs are commodities; the underlying models change every quarter. Your service should be able to switch primary vendor within a week.

### 5.2 Don't abstract everything

Abstraction is a cost. Fully abstracting every vendor produces a service you can't ship. Abstract the model layer; accept lock-in on orchestration tools (n8n / Zapier / Make) if switching cost is weeks.

### 5.3 Know the switching path before you need it

For every critical vendor, know: what's the replacement, how long does it take to switch, what's the regression risk. Document this.

### 5.4 Partner vs vendor vs buy matters for continuity

- Buy (mass SaaS): vendor can change terms at will; you have little bargaining power.
- Partner (contractual relationship): you have a voice; their incentive is to keep you.
- Build: full control, full maintenance cost.

---

## 6. Regulatory exposure

By domain, rough risk rating and what to do about it. This is not legal advice; consult your jurisdiction's regulator.

| Domain | Risk | Default stance |
|-|-|-|
| General B2B services | Low | Standard DPA + privacy policy |
| E-commerce, retail | Low-medium | Standard DPA + customer consent language |
| Financial services | High | Country-specific financial-services licensing applies (AFS in AU, FCA in UK, SEC/FINRA in US, etc.); refuse transactional scope unless client holds the relevant license |
| Health / allied health | High | Medical device regulations + health-privacy rules (HIPAA in US, GDPR-health in EU, TGA in AU, MHRA in UK, etc.); refuse clinical-decision scope without clinician |
| Legal | High | Refuse advice-generation scope without named lawyer |
| Education (esp. children) | High | Parental consent; refuse profiling scope |
| HR / recruitment | High | Bias-audit; refuse automated candidate scoring without specialist + audit |
| Government / public sector | Medium-high | Procurement + accreditation hurdles; budget for slow sales cycle |
| Property / real-estate | Low-medium | State/country rules vary; consent for recordings (two-party-consent jurisdictions need explicit notice); no legal advice |

**General rule:** if a regulator would look at the service and ask "who's accountable for this output?" — you need to have an answer before you sign a SOW.

---

## 7. The "AI-native client" myth

Myth: clients who've "gone AI" are easier to sell to.

Reality: clients at Level 4–5 (see Frameworks § F2) often have strong opinions, existing tools, and internal teams. They buy specialist depth, not "AI help". Level 2–3 clients buy outcome-shaped services with less friction.

**Design implication:** most solo-operator AI services are best sold to Level 2–3 clients. Level 4–5 clients are available but demand deep specialisation (agentic systems, fine-tuning, evaluation pipelines) that usually exceeds a generalist's scope.

---

## 8. Why naming matters

Every concrete service needs a named offer. Compare:

- "AI tools for your business" — describes nothing, closes nothing.
- "Document Automation" — describes an outcome, closes quickly.
- "Receptionist — After Hours" — describes a specific replacement for a specific role, closes fastest.

**Naming heuristics:**
- Two-word cap in most cases. "Document Automation" beats "Automated Document Intake Service".
- Use role replacement language when possible. "Receptionist" > "Call answering system".
- Named service has a subject-matter domain attached. "Document Automation — Accounting" > "Document Automation".
- Avoid tech jargon in names. "LLM-based ticket classifier" is not a sellable name.

---

## 9. The "solo-operator" constraint

This skill is designed for a solo operator or very small team. That shapes design decisions:

### 9.1 No heroics

A service that requires the operator's personal attention during business hours only works at very low client counts. Design services that run themselves most of the time.

### 9.2 Lean ops

Target ops overhead of 2–5 hours/month per client. Above that, margin breaks.

### 9.3 Knowledge concentration risk

Only the operator knows how everything works. Mitigate with runbooks (Template 7), not with "I'll remember it". If you're hit by a bus, the client should be able to pick up the phone with another operator and be running within a week.

### 9.4 Client count ceiling

Without templates and packaged services, a solo operator tops out around 8–12 concurrent clients. With productisation, 25–40 is achievable. Beyond that, you're hiring.

---

## 10. When to refuse

A shortlist of refuse-or-re-scope signals. Any single one should trigger a serious conversation, not an eager yes.

1. Client wants fully-automated output in a regulated domain.
2. Client can't name a human reviewer.
3. Client has no data or can't show you any.
4. Client's problem shape doesn't match any decision tree in `reference/decision-tree.md` and you can't design one that fits.
5. Client wants outcome-based pricing but has no baseline measurement.
6. Client wants a custom build when an off-the-shelf solution would cost less and work better.
7. Client expects a L1 → L5 maturity jump in a single engagement.
8. Client is pressuring on timeline in a way that precludes discovery or pilot.
9. Client is pressuring on price in a way that breaks margin below 50%.
10. Your gut says no. The engagements that go bad often had an early warning you ignored.

Refusing a bad engagement is the fastest way to free up capacity for a good one.
