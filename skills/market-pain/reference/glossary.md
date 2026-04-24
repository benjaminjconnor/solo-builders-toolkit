# Market Pain — Glossary

Terms used throughout the skill, in the order you'll first encounter them. Keep this file open alongside your first run.

---

## Core concepts

### Kill switch
A gate between two phases. If the gate fails, the research STOPS. You don't keep going to "see what happens." A failed kill switch is a valid, valuable output — it means don't build here.

There are three kill switches:
1. **Phase 1 → Phase 2**: Did you find 5+ distinct complaints? If no, stop.
2. **Phase 2 → Phase 2.5**: Did any problem score 20+/30? If no, stop.
3. **Phase 2.5 → Phase 3**: Is there a viable segment ≥1K businesses able to pay ≥$75/mo? If no, stop.

Kill switches exist because the most expensive mistake in vertical selection is ignoring early "no" signals and continuing to invest.

### Verified Research Protocol
The enforcement that every claim in the report must be traceable to a source (URL, Reddit post, software review page, government dataset). No "I believe" or "industry says." If you can't cite it, you can't claim it. See main SKILL.md for full protocol.

### Industry tracker
A Markdown file (typically `industry-tracker.md` in your working directory) that records: what's been researched, current status of each, scores, top problems, recommendations, and rankings. Optional for a single industry run; essential for any multi-industry comparison. See `industry-tracker-template.md` for the schema.

---

## Scoring terms (Phase 2)

Each problem is scored across 6 dimensions, 1–5 each, max 30/30. See `scoring-rubric.md` for anchored descriptions of every value.

### Frequency
How often the complaint shows up across sources. More mentions = more widespread = more likely to be a real demand signal, not an edge case.

### Urgency
How much pain the complaint is causing right now. Frustrated venting ≠ actively hunting for a solution.

### Spending (current willingness to pay)
Are people already paying to solve this problem (with tools, agencies, VAs, in-house staff)? "Spending" evidence is the strongest demand signal — it proves replacement budget exists.

### Switch (switching cost)
How hard is it for the target to switch to your solution? Inverted for opportunity: HIGH switching cost = hard sell; LOW switching cost = easier to win. If users hate their current tool, "switching cost" is actually LOW because they're motivated to leave.

### Market
How many businesses in the vertical could plausibly buy? This is a proxy for TAM at the vertical level, not the addressable segment level — Phase 2.5 goes deeper.

### Build (buildability on your stack)
Can you actually ship a solution with the tools and skills you have? A real problem you can't build for is not your problem to solve.

---

## Economic terms (Phase 2.5)

### TAM (Total Addressable Market)
Every business in the vertical, regardless of whether they could or would buy. For plumbing in a country with 28K plumbing businesses, TAM = 28K. TAM is the upper bound; real revenue math lives in the addressable segment, not TAM.

### Addressable segment
The subset of TAM that can AND would pay at your price point. If 28K businesses exist but only 9K can afford $150/mo, your addressable segment is 9K, not 28K.

### MRR (Monthly Recurring Revenue)
Revenue recognized on a per-month recurring basis. If 30 customers pay $99/mo each, MRR = $2,970. The skill uses "MRR at 1% penetration" as a sanity check: if 1% of your addressable segment gives you less than $5K/mo, the economics don't work for a solo builder.

### Price ceiling
The highest price the target segment will pay for your solution. Two rules of thumb set it:
1. **Margin-based**: If industry gross margin is 10%, and your tool touches revenue, the price ceiling is bounded by how much value you can measurably create.
2. **Replacement-based**: If they currently spend $500/mo solving this with people or tools, price ceiling is usually somewhere between $150–$500/mo (cheaper than current, but not so cheap you can't run a business).

Take the higher of the two. If both are under $50/mo, the segment is probably not viable for a solo builder.

### Replacement spend
Money the target is ALREADY spending on this problem — on VAs, answering services, existing software, manual labor. Replacement spend is a SWAP opportunity; net-new budget lines are a NEW LINE ITEM opportunity.

### SWAP vs NEW LINE ITEM
- **SWAP sell**: Your solution replaces something they're already paying for. Easier sell — the budget already exists. Example: "Replaces your $300/mo answering service."
- **NEW LINE ITEM**: You're asking them to create a new budget line. Harder sell — they need to justify new spend. Example: "Add seasonal maintenance automation for $199/mo."

SWAP opportunities have the highest close rates; NEW LINE ITEM opportunities need a much stronger ROI story to close.

### Platform risk
How exposed you'd be if a single platform (Apple, Google, Meta, Shopify, LinkedIn, or any vertical-specific PMS) decided to ban your app, change their API, or build the feature themselves.
- **GREEN**: No platform dependency. Email, SMS, phone, web scraping.
- **YELLOW**: One platform dependency with viable alternatives. E.g., OpenAI API — you could swap to Anthropic or local models.
- **RED**: Single platform with no alternative. E.g., a Shopify-only app that can't exist outside Shopify.

GREEN is not mandatory. YELLOW is acceptable. RED needs a plan.

### Industry classification codes
When you need to verify market size from government data, use the right code system:
- **ANZSIC** — Australian and New Zealand Standard Industrial Classification
- **NAICS** — North American Industry Classification System (US, Canada, Mexico)
- **SIC** — Standard Industrial Classification (UK, historically global)

Every national statistics office publishes business-count data by these codes. Look up the code for your target industry before you trust any "number of businesses" claim.

---

## Gap analysis terms (Phase 3)

### Greenfield
No meaningful competition. Nobody is selling a solution to this problem in this segment. Greenfield gaps are rare and precious. Most "greenfields" on second look turn out to be feature gaps.

### FEATURE gap
Someone sells a tool that ALMOST does what you'd build, but misses a specific feature. A feature gap is 1–2 sprints to close. You can build first, but the incumbent can copy you in weeks. Defensibility: LOW.

Example: "Leading field-service platforms offer AI receptionists, but none offer seasonal campaign automation." Seasonal campaigns are a feature — competitors can add it in 1–2 sprints.

### STRUCTURAL gap
The gap exists because of how competitors built their products — their architecture doesn't support what you'd build. Structural gaps take competitors 6–18 months to close. Defensibility: MEDIUM.

Example: "Existing PMS vendors store data per-tenant; you'd build a cross-tenant benchmarking tool that requires a different data model."

### DATA moat
You have access to or can generate data that competitors cannot easily replicate. Defensibility: HIGH, but only if the data compounds.

Example: "Running the tool collects anonymized call-pattern data across all customers. After 6 months, you can predict no-show rates better than any new entrant because they'd need years to catch up on data volume."

### Confidence rating (on a gap)
- **HIGH**: 10+ sources confirming the gap exists; clear buildable solution; no dominant competitor.
- **MEDIUM**: 5–10 sources; some partial competitors; solution path has open questions.
- **LOW**: Fewer than 5 sources; the "gap" may actually be that nobody cares.

Apply the "assume worst case if no evidence" rule: if you can't find evidence of the gap being real, it's LOW confidence, not MEDIUM.

### Gap durability test
After you identify a gap, ask: "If I build this and launch in 6 months, can the top 3 competitors close it in response?" If yes → it's a feature gap, build fast. If no → you have something more durable.

---

## Validation terms (Phase 4)

### Discovery call
A 15–30 minute conversation with a prospect in the target industry. The goal isn't to sell — it's to verify pain, urgency, current spend, and price sensitivity. If you try to sell, you'll get polite "yes" answers that won't survive first charge.

### Post-call rubric
Structured scoring of a discovery call: did they confirm the problem? How urgent is it? What are they currently spending? Would they pay your tested price? See `scoring-rubric.md` for anchored descriptions.

### Go/no-go threshold
After 10 discovery calls, the skill uses a pre-committed threshold to make the decision:
- **GO**: 7+ calls confirm problem AND urgency ≥ 3 AND willingness-to-pay ≥ target price
- **NO-GO**: Fewer than 5 calls confirm problem OR average urgency < 3 OR willingness-to-pay below floor
- **AMBIGUOUS**: Between those — run 5 more calls before deciding

Pre-committing the threshold before calls prevents "these 3 bad calls must have been outliers" motivated reasoning.

---

## House style abbreviations

Quick-reference for the shorthand you'll see in the skill's output:

| Term | Meaning |
|-|-|
| GREEN/YELLOW/RED | Platform risk rating |
| GREENFIELD | No competition detected for this exact gap |
| HIGH/MEDIUM/LOW | Used for gap confidence, urgency, competitor density |
| SWAP / NEW LINE ITEM | Sell type (see Economic terms) |
| KILL | Phase fails a kill switch; research stops |
| STOP | Same as KILL |
| VERIFIED | Claim has a citable source |
| ASSUMED | Claim lacks a source; flag for review |

If you see a term in a report you don't recognize, cmd-F this glossary before continuing.
