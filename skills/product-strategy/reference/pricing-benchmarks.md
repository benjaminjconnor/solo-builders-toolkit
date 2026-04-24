# Pricing Benchmarks — Reference for Phase 5

This file extends Phase 5 "Bundle Strategy" in SKILL.md. The core rule is simple: no price point ships without at least two competitor benchmarks pulled directly from the source. Perplexity finds candidate URLs; WebFetch reads verbatim tier and price data; AI-generated summaries are never a valid source. One benchmark is a weak signal. Zero is a guess. The sections below cover how to run the research, what to record, how to design tiers and guarantees, and how to validate that the numbers survive contact with reality.

---

## 1. Competitor Pricing Research Protocol

Run this for every direct substitute and for two to three adjacent alternatives. Budget 20–30 minutes per competitor.

1. **Find the pricing page via search.** Queries that work: `"[competitor name]" pricing`, `"[competitor name]" plans`, `"[competitor name]" site:/pricing`, `[competitor name] pricing 2026`. Perplexity is good for URL discovery — ignore its summary, grab the source link.
2. **WebFetch the URL directly.** Do not paraphrase the AI summary. If WebFetch returns a login wall or paywall, use one of the hidden-pricing techniques in Section 3.
3. **Extract verbatim** — tier names, monthly price, annual price, per-seat price, usage caps, seat minimums, add-on prices, trial length.
4. **Capture what's INCLUDED** at each tier, not only the dollar figure. Feature gates determine positioning; price alone misleads.
5. **Flag "Contact sales" tiers.** Any enterprise or custom-priced tier is a hidden-pricing problem — apply Section 3.
6. **Document 2–5 competitors per category.** Direct substitutes (same category) plus adjacent alternatives (the things buyers consider before settling on your category) — e.g., for a voice-triage service, direct = other voice-AI vendors, adjacent = answering-service agencies and hiring an in-house receptionist.
7. **Date-stamp every benchmark.** Pricing pages change; a six-month-old screenshot is not current evidence.

---

## 2. Reading a Pricing Page Accurately

Capture per competitor:

| Field | What to record | Skip |
|-|-|-|
| Tier name | Exact wording ("Starter", "Growth", "Enterprise") | Marketing adjectives |
| Monthly price | Exact figure; note currency | Rounded estimates |
| Annual discount | % off vs monthly; annualised price | "Save money with annual" claims |
| Seat minimum | Smallest buyable unit | "Starts at" vagueness |
| Usage cap | Calls, docs, tokens, messages included | "Generous limits" language |
| Overage cost | Price per unit beyond cap | N/A if none |
| Feature gate | What unlocks at this tier vs the one below | Full feature list |
| Enterprise path | "Contact sales" / "Custom" flag + evidence of tier floor | Assumed figures |

**Annual vs monthly.** If the competitor only displays annual prices, divide by 12 to get the comparable monthly figure. If they only display monthly, note it — buyers on annual commit to higher ACV, which changes your positioning.

**Seat-based vs usage-based vs flat.** A $49/mo flat-fee tool is not comparable to a $49/seat tool for a 10-person team. Normalise to either per-seat or total-organisation cost before comparing. For usage-based vendors, compute the cost at three usage tiers (low / expected / high) — the stated price rarely matches what the customer actually pays.

**"Contact sales" / "Custom" tiers** almost always indicate a seat minimum and a negotiated floor. Treat them as unknowns until Section 3 closes the gap.

---

## 3. Hidden-Pricing Discovery

Use these when the public pricing page stops short.

**1. Review-site transcripts.** G2, Capterra, TrustRadius, Trustpilot. Search the competitor's review page for `$`, `per month`, `per user`, `annual contract`, `ACV`, `seat minimum`. Paying customers frequently cite exact dollar figures in reviews. Scan 20–30 reviews; cluster the numbers to find the real tier.

**2. Team-size proxies.** Visit the competitor's careers / LinkedIn / company page. A 50-person SaaS with a 12-person sales team is not selling at $49/month — it's selling at five-figure ACVs. A 3-person team with no sales reps is selling self-serve. Headcount filters the plausible price range before you do any other research.

**3. Investor updates, annual reports, press leaks.** Public companies disclose ARR ranges, ACV, and customer counts in earnings calls and 10-Ks. Private companies occasionally leak in press interviews — search `[competitor name] ARR`, `[competitor name] ACV`, `[competitor name] Series [A/B/C]` and read the funding announcements.

**4. Founder interviews and podcasts.** Founders name prices live on podcasts and YouTube more often than you'd expect. Search `[competitor name] founder podcast`, `[competitor name] interview pricing`, `[competitor name] YouTube`. A 3-minute skim of a founder interview can reveal the enterprise floor.

**5. Partner and reseller channels.** If the product is sold through resellers or a partner directory, reseller markups are typically 15–30% — back-solve to the wholesale price. Reseller-only price sheets occasionally surface in search.

Any single technique is noisy. Cross-checking 2–3 of these against each other is how you stop guessing.

---

## 4. Bundle & Tier Design

### Tier spacing (exponential, not additive)

Space tiers by a 3–4× multiplier. If entry is $99/mo, mid-tier sits at $299–$499/mo, premium at $999–$1,499/mo. The gap between tiers should feel like a different buying decision — a different persona, a different approval path — not a small upgrade. Compressed tiers ($99 → $149 → $199) train buyers to shop, not to commit.

Expected distribution with exponential spacing:

| Tier | Price | Approx. take rate |
|-|-|-|
| Entry | 1× | 60–70% of customers |
| Mid | 3–4× | ~20% |
| Premium | 12–16× | ~4% |
| Enterprise / bespoke | 40×+ | <1%, high LTV |

### Setup-fee trade-offs

| Business model | Setup fee stance | Rationale |
|-|-|-|
| Pure SaaS / self-serve | None | Friction kills trial conversion; growth depends on low commitment entry |
| Productized services (onboarding-heavy) | $500–$2,500 | Anchors perceived value; funds bespoke configuration work |
| Usage-based / token-based | None, but require card-on-file | Growth comes from usage scaling, not upfront capture |
| Enterprise / 10+-seat B2B | 20–40% of annual deal value | Filters non-serious buyers; funds implementation effort |
| Managed services | ~1 month of the monthly retainer (floor) | One-time audit/migration work needs paying for |

### Guarantee design

Three postures. Pick one and commit.

**Conditional outcome guarantee.** "Hit [X measurable outcome] by [date] or we refund [Y]." Works for outcome-linked services (lead generation, paid ads, booked-call quotas). The outcome must be measurable, time-bounded, and attributable — vague promises invite disputes.

**Unconditional refund.** Only for low-ticket, short-window products (under $500, under 30 days). Above that threshold unconditional refunds invite refund-shopping and the customer who games the 29-day window.

**Anti-guarantee.** Productized done-for-you services often explicitly state no refund after delivery. Instead of a refund promise, stack bonuses that make the offer feel irreversible — but state the no-refund policy in writing before invoice.

**Core rule:** guarantee the OUTCOME, not the effort. "We'll build the funnel" is not guarantee-able. "Your funnel will produce ≥30 qualified leads in 60 days or we refund the build fee" is.

### Annual vs monthly spread

Standard annual discount: **15–20% off the monthly rate**. Less than 15% and the annual option feels like a non-offer; the take rate collapses. More than 30% and prospects assume the monthly price is inflated — which damages the anchor on the whole pricing page.

---

## 5. Price-Point Validation

**The rule:** every price point in the bundle documents ≥2 competitor benchmarks via WebFetch with verbatim URLs and tiers.

**Pass example.** You price the mid-tier bundle at $497/mo. Competitor A's "Growth" plan is $449/mo (WebFetched, dated this week). Competitor B's "Professional" plan is $599/mo (WebFetched, dated this week). Your price sits between two verified anchors — valid.

**Weak-signal example.** You price at $497/mo. Only one competitor publishes ($449/mo); every other competitor uses "Contact sales". Status: weak signal, not invalid. Apply Section 3 to close the gap before locking pricing. If you ship on one benchmark you're pricing against a single data point — a bad customer meeting can move your price more than market reality.

**Fail example.** You price at $497/mo. No competitor publishes. You assumed "around $500 feels right." Status: invalid. Do not proceed to Phase 6 until Section 3 produces at least one verified benchmark — and preferably two.

**What to do when only 1 benchmark exists.** Do all of: (1) run all five Section 3 techniques and document findings even if negative, (2) note the weak-signal status in the strategy file and the risk register (Phase 7), (3) plan a faster pricing re-evaluation at 90 days based on close-rate and churn signals, (4) tighten the Phase 11 validation ramp — more customers, smaller price steps — to discover price in-market.

---

## 6. Unit-Economics Floors

Every price point must survive a cost-of-goods check. Use these floors as the kill line; the full bill of materials lives in SKILL.md Phase 6.

| Business type | Gross margin floor | Rule of thumb |
|-|-|-|
| Retail / productized physical | ≥60% (3× COGS) | Below this the business starves at scale |
| Pure SaaS | 70–80% | Industry-standard investor expectation |
| AI-heavy service (LLM/API in delivery) | ≥50% after inference costs | Model-layer costs are real and grow with usage |
| Managed services (human labour) | ≥50% after delivery labour | Below 50% the operator can't reinvest |

**CAC payback windows** (complement the margin floor):

| Segment | CAC payback target |
|-|-|
| SMB SaaS | <12 months |
| Mid-market | <18 months |
| Enterprise | <24 months |

Back-solve to the price: if CAC is $600 and margin is 50%, a $100/mo product needs 12 months to pay back — tight. A $300/mo product pays back in 4 — comfortable. When the math doesn't work, the answer is almost always "raise price" before it is "cut cost".

---

## 7. Common Pricing Mistakes

| Mistake | Why it fails | Fix |
|-|-|-|
| Guessing a competitor's enterprise tier | No evidence; anchors the bundle to a fantasy price | Apply Section 3 hidden-pricing techniques; cross-check 2–3 sources |
| Unconditional refund on a $2,000+ productized service | Invites refund-shopping; a 29-day completion then refund kills margin | Switch to conditional outcome guarantee tied to a measurable milestone |
| Charm pricing (.99 endings) on a $4,000 service | Cheapens the premium perception; signals retail-SKU not high-touch work | Whole numbers above $1,000; charm pricing stays under $100 |
| Annual discount under 15% | Feels like a non-offer; take-rate on annual collapses | Set annual at 15–20% off monthly — the buyer-expected band |
| Skipping benchmarks because "we're unique" | No external anchor; pricing collapses to cost-plus reasoning | Every product has substitutes; find ≥2 and document them |
| Three tiers with <2× spacing | Trains buyers to shop tier-by-tier instead of committing | Space tiers at 3–4× minimum; compress to two tiers if the range can't justify three |
| Enterprise tier without a seat minimum | Leaves money on the table; one-seat "enterprise" buyers clog ops | Set an explicit seat or spend floor (e.g., 10 seats, $2K/mo minimum) |
| Publishing pricing before legal review (Phase 3) | A RED compliance blocker invalidates the offer and the price | SKILL.md Phase 3 must clear before Phase 5 locks |

---

## 8. Quick Checklist — before declaring Phase 5 complete

- [ ] Every price point has ≥2 competitor benchmarks from verbatim WebFetch (URL + date captured)
- [ ] Tier spacing is 3–4× between adjacent tiers (or documented exception with rationale)
- [ ] Setup-fee posture matches the business model per Section 4 table
- [ ] Guarantee is either conditional-outcome, unconditional (with ticket + window floor), or explicit anti-guarantee
- [ ] Annual discount sits in the 15–20% band
- [ ] Gross margin at each tier meets the Section 6 floor for the business type
- [ ] All "Contact sales" competitor tiers either resolved via Section 3 or flagged as weak-signal in the risk register
- [ ] Pricing page (if one exists) date-stamped and set to quarterly review
