# Market Pain — Scoring Rubric

Anchored descriptions for every dimension in Phase 2 (problem scoring) and Phase 4 (post-call validation). Use this file when you're scoring, and keep it open.

The point of anchored scoring is consistency. If you score "urgency: 4" on a Monday and "urgency: 3" on a Friday for the same complaint, you've introduced drift. The anchors below remove that drift by tying each score to a specific evidence signature.

**Rule of thumb**: if you can't cleanly pick between two adjacent values, pick the lower one. "Assume worst case if no evidence."

---

## Phase 2 — Problem scoring (6 dimensions, 1–5 each, max 30/30)

### Dimension 1: Frequency
How often does the complaint appear across your Phase 1 sources?

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | Barely mentioned | 1–2 total mentions across all sources. Could be one grumpy user. |
| 2 | Occasional | 3–5 mentions across 2+ sources. Real but not widespread. |
| 3 | Common | 6–10 mentions across 3+ sources. Clear recurring theme. |
| 4 | Widespread | 11–15 mentions across 4+ sources. Appears in multiple Reddit threads, review sites, forum posts. |
| 5 | Dominant | 15+ mentions across 5+ sources. The complaint shows up in almost every thread in the space. |

**Worked case — high**: A plumbing subreddit thread on "biggest business headaches" has 47 comments; 22 of them mention missed after-hours calls losing emergency work. Software review sites for trade CRMs show 60+ user reviews complaining about the same thing. **Frequency = 5**.

**Worked case — low**: In researching accounting firms, you find one Reddit post where someone complains about "client portal UX" with 4 upvotes and no replies. No other source mentions it. **Frequency = 1**.

**Ambiguous case**: The complaint appears in 8 reviews of one product but nowhere else across the industry. Is it frequency 3 (common) or 1 (one product's users)? Apply the lower-bound rule: **Frequency = 2** (occasional — evidence is real but not diverse).

---

### Dimension 2: Urgency
How much pain is the complaint causing right now?

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | Mild annoyance | "Kind of wish it worked better." No emotional charge. |
| 2 | Frustration | "This is really annoying." Complaint exists but the person is coping. |
| 3 | Active pain | "I hate this. Costs me X hours a week / $Y a month." Specific cost cited. |
| 4 | Hunting for solutions | "Has anyone found a better way? I've tried X, Y, Z." Person is actively searching. |
| 5 | Crisis | "If I don't fix this, [business consequence]." Job/revenue/reputation on the line. |

**Worked case — high**: Hotel/HVAC business in 40°C summer heat has missed 3 after-hours emergency calls this week; owner posts "I'm losing $5K in jobs weekly because we can't answer the phone overnight. Need a solution NOW." **Urgency = 5**.

**Worked case — medium**: Accountant posts "document chasing is painful but we just accept it as part of the job." Confirms the problem, no active hunting. **Urgency = 2**.

**Ambiguous case**: Person complains with emotional charge but doesn't cite a cost. "I'm so sick of this thing, it's ridiculous." Score down: **Urgency = 2**. No cost = no crisis.

---

### Dimension 3: Spending (current willingness to pay)
Are they ALREADY paying to solve this problem?

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | No spend, no intent | Problem exists; nobody pays to fix it; nobody is even asking about solutions. |
| 2 | Cheap DIY | Manual workarounds only. Spreadsheets, sticky notes, free tools. |
| 3 | Small paid tool | People pay $20–$50/mo for a partial solution (often an incomplete SaaS tool). |
| 4 | Meaningful spend | People pay $100–$500/mo for solutions (VAs, answering services, mid-tier software). |
| 5 | Large spend | People pay $500+/mo, sometimes thousands (hire staff, enterprise tools, agencies). |

**Worked case — high**: Plumbing businesses routinely spend $300–$600/mo on answering services or dedicated receptionists. Industry forum threads reference VA platforms costing $1,500/mo for 24/7 coverage. **Spending = 4**.

**Worked case — low**: Independent contractors "want" an AI assistant to write proposals. Nobody is paying for this today; nobody has mentioned current spend in any Phase 1 source. **Spending = 1**.

**Ambiguous case**: Replacement spend exists but it's specific to a sub-segment. E.g., large accounting firms pay for practice management software; solo bookkeepers don't. If your addressable segment is the solos: **Spending = 2**. If it's the large firms: **Spending = 5**. Score for your segment, not the vertical.

---

### Dimension 4: Switch (switching cost)
How hard is it to move the target from current state to your solution?

**Inverted scale** — lower score = harder to switch = less opportunity.

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | Locked in | Target is on a multi-year contract, data is hostage, switching = migration project. |
| 2 | Sticky | Integrated into daily workflow; switching takes weeks; team would need retraining. |
| 3 | Possible | Would take effort but feasible. Switching cost measured in days, not weeks. |
| 4 | Easy | Target uses the current tool lightly; switching = a weekend afternoon. |
| 5 | Eager to switch | Target actively hates current solution and is openly looking to leave. Switching = today. |

**Worked case — high**: HVAC business owner posts: "I've been on [Software X] for 4 years and I'd leave tomorrow if I could find something that actually worked." They haven't left because they haven't found a good alternative. **Switch = 5** (score the opportunity, not the inertia — they're motivated).

**Worked case — low**: Large accounting firm has 40 staff trained on a proprietary PMS with years of client data inside. Switching means retraining staff, migrating data, and renegotiating compliance workflows. **Switch = 1**.

**Key insight**: Switching cost is INVERTED for opportunity. High switching cost = hard sell = low opportunity score. Don't confuse "sticky market" with "good market." Sticky markets reward incumbents.

---

### Dimension 5: Market (size of vertical)
How many businesses in this vertical could plausibly buy?

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | Tiny | <1K businesses in target geography. Niche-within-niche. |
| 2 | Small | 1K–5K businesses. Plausible solo-builder play, narrow TAM. |
| 3 | Moderate | 5K–20K businesses. Comfortable size for solo with room to grow. |
| 4 | Large | 20K–100K businesses. Strong TAM; will attract competitors. |
| 5 | Very large | 100K+ businesses. National or cross-vertical scale. |

**Worked case — high**: Plumbing in a mid-size country, ~28K businesses. **Market = 4**.

**Worked case — low**: Licensed ski-lift inspectors in one country: <200 nationwide. **Market = 1**.

**Note**: This score is a proxy for VERTICAL size, not ADDRESSABLE SEGMENT size. Phase 2.5 does the deeper segmentation. A "Market = 4" vertical can still fail Phase 2.5 if the addressable segment (those who can afford your price) is under 1K.

---

### Dimension 6: Build (buildability on your stack)
Can you, personally, ship a solution to this problem with the tools and skills you currently have?

| Score | Anchor | Evidence signature |
|-|-|-|
| 1 | Can't build | Requires tech, data, or integrations you don't have access to. |
| 2 | Stretch | Possible but requires learning new frameworks/APIs; risky for a solo. |
| 3 | Doable | Within your skill set; some new integrations but nothing outside your comfort zone. |
| 4 | Easy | You've built things like this before. Clear technical path. |
| 5 | Trivial | Plug-together existing components; no net-new technical challenges. |

**Worked case — high**: A "missed calls → SMS auto-reply" tool for trades uses Twilio, standard webhooks, and a small chat UI. You've built three Twilio integrations before. **Build = 5**.

**Worked case — low**: A tool that does real-time compliance checking against a gated industry's proprietary database, which requires: regulatory approval, encrypted data handling, and an integration that only approved partners get. **Build = 1**.

**Key rule**: A real problem you can't build for is NOT your problem to solve. Don't rationalize a Build = 2 to Build = 4 because you like the opportunity. Honest self-assessment here saves months later.

---

### Scoring totals & kill switch

Add all 6 dimensions. Max = 30/30.

- **25–30**: Exceptional opportunity. Run Phase 2.5 immediately.
- **20–24**: Viable. Run Phase 2.5 and expect some kills on economics.
- **15–19**: Weak. Likely not worth pursuing; kill unless multiple problems in this vertical all score 15–19 and the overall pattern is compelling.
- **Below 15**: Kill.

Kill switch #2: **at least one problem must score 20+/30** for the vertical to proceed to Phase 2.5. If all problems in your Phase 1 output score <20, stop.

---

## Phase 4 — Post-call validation rubric

After each discovery call, score the conversation on 4 dimensions.

### Dimension 1: Problem confirmed

| Score | Anchor |
|-|-|
| YES | Prospect described the problem in their own words, with specific examples from their own business. |
| PARTIAL | Prospect agreed the problem exists but couldn't cite their own experience. |
| NO | Prospect didn't recognize the problem or said "that's not really an issue for us." |

**YES requires**: their own words + their own example. If you described the problem and they said "yeah, that's a thing" — that's PARTIAL, not YES.

### Dimension 2: Urgency (1–5)

| Score | Anchor |
|-|-|
| 1 | "Yeah, it's annoying." Never thought about solving it. |
| 2 | "We've talked about fixing it but haven't prioritized it." |
| 3 | "We lose [specific amount of time or money] because of this." |
| 4 | "We've tried [X, Y, Z solutions]. Looking for something better." |
| 5 | "If we don't fix this in the next 90 days, [consequence]." |

**Vignette — urgency 3**: Prospect says: "We lose maybe 10 hours a week on this. I know it's costing us." They've quantified pain but aren't actively hunting. **Score = 3.**

**Vignette — urgency 4**: Prospect says: "We're using [Tool A] and [Tool B] and a VA to patch it together. Still not working. I spend every Sunday wondering if there's a better way." They're actively searching. **Score = 4.**

**Vignette — ambiguous**: Prospect says: "It's fine. I mean, it's not fine, but it's fine." Emotional intensity says more than the words. Down-score: **Score = 2**.

### Dimension 3: Current spend

| Score | Anchor |
|-|-|
| YES + amount | Specific monthly dollar figure cited. Note the figure. |
| YES no amount | Confirmed they pay something but didn't say how much. Ask: "Roughly what does that cost you monthly?" |
| NO | They're not currently paying to solve this problem. |

**Rule**: If they say "YES" but can't cite a rough amount within 30 seconds, treat as "NO" for math purposes. Real spending gets remembered.

### Dimension 4: Willingness to pay

| Score | Anchor |
|-|-|
| YES @ target | They said "yes" to your tested price and could articulate why it's worth it. |
| YES below target | "Yes, but I'd pay $X" where $X is below your target. Note the gap. |
| NO @ any | "No, I wouldn't pay for this." |
| Ambiguous | "Maybe? I'd need to see it." This is usually a soft NO. Score as NO for math, but keep in follow-up list. |

**Vignette — ambiguous handling**: Prospect says "I'd definitely pay something. Maybe $50/mo? I'd need to see it work first." Your target is $149/mo. Score: **YES below target @ $50**. Note the $99 gap — your price or their willingness has to move.

---

### Go/no-go after 10 calls

Tally:
- Count of problem-confirmed (YES) ≥ 7 → problem is real
- Average urgency across all 10 calls ≥ 3 → problem has pull
- Current-spend (YES + amount) ≥ 5 → replacement budget exists
- Willingness-to-pay (YES @ target) ≥ 4 → price holds

**GO**: All four criteria met.
**NO-GO**: Any single criterion fails.
**AMBIGUOUS**: Marginal failures (e.g., 4 willingness-to-pay but 3 of them specified a price close to yours). Run 5 more calls before deciding.

Pre-commit this threshold before making any calls. Rewriting the rubric after 3 disappointing calls is motivated reasoning.

---

## Sanity checks after scoring

Before you trust your Phase 2 scores:

1. **Would a stranger score this the same?** If your rubric application depends on context only you have, tighten the anchor or add evidence.
2. **Are any dimensions all 5s?** Rare. If three dimensions score 5, re-examine — you may be excited and over-scoring. The lower-bound rule applies.
3. **Does the score feel right?** Score bias works both ways. If a 22/30 feels "disappointing," you're probably biased toward the vertical; check against a colder vertical you have no interest in.

A good test: show your scored table to someone who hasn't read the Phase 1 complaints. Ask them what they think the vertical is. If they can't tell, your scoring is probably too generic and isn't capturing what's specific about this vertical's pain.
