---
name: comms
description: Two modes. Draft mode produces replies, comments, and outgoing messages in the user's voice with a yielding, curious, deferential tone that respects the recipient's Autonomy, Mastery, and Purpose; output is paste-ready text the user sends. Review mode audits the user's recent Slack / Gmail / Jira / GitHub PR communications, mirrors back messages where principles drifted, surfaces suggested rewrites and positive examples, and tracks improvement over time.
when_to_use: Use when the user asks for a draft of any reply or outgoing message to someone other than themselves — Slack, Jira, GitHub PR, email, doc comment. Triggers include "draft a reply", "help me respond", "write a Slack message", "comment on this PR", "respond to this Jira comment", "draft an email", or pasting a thread and asking for a response. ALSO use when the user asks to review their own recent communications — "review my comms", "review my slack today", "audit my recent posts", "feedback on this week's comms", "how did I communicate yesterday?", or `/comms review [window]`.
contributed-by: samcorl
status: contributed
user-invocable: false
---

# Comms — Drafting replies and reviewing your own communication

This skill has two modes. **Draft mode** produces text the user will send — replies, comments, outgoing messages in any channel a person will read words from them (Slack DM/channel, Jira, GitHub PR, email, doc comment). The draft sounds like the user — authentic voice, phrasing, habits. Authenticity is what builds trust with the recipient.

**Review mode** is the mirror. The user asks the agent to look back at messages they already sent and surface opportunities to communicate better — alongside the moments they nailed it. Same principles apply both directions: draft mode produces text that respects them; review mode flags messages where they slipped, and recognizes where they didn't.

## Two modes

The skill picks a mode at invocation:

- **Draft mode** — the user wants help writing something now. Triggers: "draft", "help me reply", "respond to", a pasted thread asking for a response.
- **Review mode** — the user wants to look back at messages they sent. Triggers: "review", "audit", "feedback on", "how did I communicate", or explicit `/comms review …`.

If genuinely ambiguous, ask once: *"Are you wanting a draft or a retrospective review?"*

## Why this skill exists

Cross-functional teams are made up of people with different communication styles, different cultural backgrounds, different sensitivities, and different ways of receiving feedback. That diversity is a strength. It's also why the same words can land really differently depending on who's reading them.

This skill encourages authenticity. It's a tool for genuinely improving how the user communicates with their team, practicing patterns that respect each individual's autonomy, expertise, and dignity. Think of it as Duolingo for team comms: every draft is a chance to reinforce a way of writing that builds real collaborative relationships across varied styles.

The rules and patterns below are precepts for fostering that collaboration. They work because they reflect real respect for the recipient. The user's authentic voice, expressed in patterns that build trust, is the goal.

## The North Star: AMP / Agency

The recipient has Autonomy, Mastery, and Purpose. Many people are sensitive about encroachments on these. The draft must respect them:

- **Autonomy** — the recipient gets to decide. The draft surfaces information and asks; it does not direct, conclude for them, or close the loop on their behalf.
- **Mastery** — the recipient is the domain expert in their lane. The draft does not explain to them how to do their job, does not over-define terms they already know, and does not lecture.
- **Purpose** — the recipient's framing of the work matters. The draft acknowledges what they were trying to do, even if the user's reply gently notes a different scope or approach.

When in doubt about tone: shorter, more deferential, less polished, more curious. The recipient should feel respected and in charge after reading.

## The YES CHEF stance

The recipient is the chef. The draft is from a cook responding to the chef. Deferential, action-ready, no defensiveness. "Yes chef, on it" is the energy, even when the substance is "actually that wasn't in scope".

This applies even when the user has the technical high ground. Especially then.

## Core rules

1. **Hand them agency.** Phrases that work: "just say the word", "let me know", "I'll write it up", "easy add", "happy to take another pass", "want me to dig in?". Treat their observation as valid on its face. Take their feedback as given, not as something they have to defend or classify ("was this a bug report or a status update?" puts the burden back on them).

2. **Say please — or acknowledge the ask explicitly — when requesting time, attention, or effort.** Asking someone to review something, answer a question, take a look, or weigh in is a request on their finite resources. Acknowledge it. "please" is the minimum; "if you're willing", "when you have a moment", or "no rush on this" make the ask visible rather than invisible. The draft never frames a request as a notification or an expectation.

3. **Minimize the attention ask.** Time is the one thing everyone has a finite supply of. Every word in the message is a draw on the recipient's attention. Keep the draft as short as it can be while still conveying what's needed. If a sentence can be cut without losing meaning, cut it. Don't pad, don't over-explain, don't restate what the recipient already knows. Shorter is not just more considerate — it's more likely to get a response.

4. **Brief context if relevant, never lecture.** One short sentence is usually enough. Skip "well actually". Skip symmetric two-bullet "or" constructions ("Did you mean X, or did you want Y?") that frame the recipient as needing to pick a justification.

5. **End on the action the recipient can take, not on the rationale or scope.** They close the loop, not the agent. Last sentence is usually a soft handoff: "let me know", "your call", "happy to spin up a follow-up".

6. **Sound like the user, not an LLM.** The draft is the user's authentic voice. Several AI-tell patterns are baked into LLM training and cannot be self-policed by the drafting agent — the draft will contain them regardless of intent. A Haiku subagent post-processes the draft to remove them (see step 5 of the draft process below). Patterns the post-processor targets:
   - **Em-dashes and en-dashes** (`—`, `–`) — replaced with commas, parentheses, or hyphens as context warrants
   - **`- X - Y - Z` list syntax in casual contexts** — converted to flowing prose
   - **Unnecessary sentence-ending quips** — the small rhetorical flourish tacked onto the end of a sentence that adds nothing; removed
   Other patterns the drafting agent can still self-police (not training artifacts):
   - "Quick sanity check from my side" / "Just to double-check" with perfect punctuation
   - Transitional perfection ("Furthermore", "Additionally", "That said,")
   - Symmetric "Does that match X, or did you want Y?" framing
   - Closing summaries ("In short:", "TL;DR:")

7. **Write in the user's first-person singular voice.** "I checked", "my read", "I'll write it up". The agent is a tool, not a collaborator, so "we" and "the user and I" don't appear in drafts the user will send.

8. **Trust the recipient as the domain expert.** Designers know design, QA knows QA, PMs know product. Share the finding and the evidence; let them interpret. Skip the "the way this works is…" preamble.

9. **Match the channel register:**
   - **Slack DM / channel** — most casual. Lowercase chat-style, short paragraphs, emoji OK if the user typically uses them in that channel
   - **Jira comment** — semi-formal but still conversational. Slightly more punctuation discipline
   - **GitHub PR top-level comment** — casual technical, like to a fellow dev. Code formatting OK
   - **GitHub PR inline review reply** — very short, focused on the specific thread. One or two sentences usually
   - **Email** — most formal. Greeting + signoff. Still keep YES CHEF tone
   - **Doc comment** — match the existing comment thread's tone

## Openers and softeners (example vocabulary)

Different users have different go-to phrases for cross-functional asks (PM, designer, manager, group chat). Each user's vocabulary is part of their voice; the agent should learn it over time. The set below is one collaborative voice — keep it as exemplar, replace with the user's actual phrasing where they differ.

**Openers that hand decision-making back:**
- "quick question on…" when raising a decision or surfacing an ambiguity
- "wanted your input on…" / "looking for guidance on…" / "wanted to align on…" / "before going this direction…"

**Openers worth replacing (one-directional or performative):**
- "Heads up that…" → reframe as a question; an invitation reads more collaborative than a notification
- "FYI" / "Just FYI" → same shift; if a response would help, ask for one
- "Quick sanity check" → an LLM-polish tell; "quick question on…" is the natural variant

**Softener words to reach for:**
- "input", "alignment", "direction", "guidance" — these reframe a statement-of-fact as an invitation to weigh in
- "your call" / "any direction here?" / "what's the right call?" as endings

**Why these work:** they're corporate but genuinely deferential. They signal: *the recipient owns the decision, the user is bringing them what they need to make it*. Stay away from the heavier corporate-tells (`circle back`, `scope a follow-up`, `low-hanging fruit`, `swag at it`) — those tend to read as performance.

**Pattern shift to internalize:** when the draft would say "Heads up that X is true", reframe as "quick question on X" or "wanted your input on X" — even if the body still contains the same fact, the framing now invites a response rather than dropping a notification.

**Customizing the vocabulary:** users have their own collaborative voice. Watch for and adapt to the specific phrases the user habitually uses (or explicitly tells the agent they use). The principles (deferential, invite a response, hand agency back) are universal; the specific words are the user's.

## Channel fit (push back when wrong)

The user identifies the intended channel when invoking the skill ("draft a Slack message", "Jira comment", "PR reply"). The agent evaluates whether the substance fits that channel before drafting. If a different channel would serve the recipient and the conversation better, **STOP AND TELL THE USER** — surface the alternative openly, so the user can choose with full context.

**Suggest a different channel when:**

- **Slack post about a specific Jira story** → recommend a story comment. Non-urgent, story-specific clarifications belong on the ticket where they're traceable, attached to the artifact, and land in the assignee/reporter's notification stream.
- **Slack post about a specific PR** → recommend a PR comment (top-level or inline). Code and review discussion belongs attached to the diff so reviewers find it in context.
- **Group chat post when only one or two people can answer** → recommend a DM or a narrower channel with a direct @-tag. Direct the question to the person who can answer; respect the rest of the group's attention.
- **Cross-channel duplication** → pick one channel so the discussion stays in one place and the answer lives where future readers will look.

**Why:** respect for people's time and focus. The right channel directs the question to whoever can answer, keeps the canonical conversation near the artifact it's about, and lets uninvolved people stay in flow.

**How to surface the alternative:** before drafting, share the recommendation and the reasoning in chat. Then wait for the user to confirm or pick a different channel. Example: *"Before I draft this for Slack, this reads like a [TICKET]-specific clarification. A Jira comment would put the question on the assignee's notification stream and keep the answer attached to the story. Slack still works if the ask is broader or time-sensitive, your call."*

**Context matters more than channel-name.** "Is anyone using [shared resource] tomorrow at 3pm?" is genuine group-chat material. "Should the modal copy say X or Y for [TICKET]?" is story-specific even if the user says "draft for Slack". The same words land very differently depending on whether the response should come from one person or twenty.

# ────── DRAFT MODE ──────

## Process when drafting a reply

1. **Read the source material in full.** Whatever the user shares (Slack thread screenshot, Jira comment, PR comment URL, email forward, or just a description), read all of it before drafting. Catch the prior turns, who said what, the social/political context, and the unstated stakes. Don't respond to the last message in isolation — context of the reply matters as much as the words.

2. **Identify the recipient and the channel** if it's not obvious. Ask if needed. **Then run the channel-fit check above** — if a different channel would serve the conversation better, surface that before drafting. Confirm the channel with the user rather than assuming it just because they named one.

3. **Identify the substance the user wants to convey.** Often it's: "I think this is out of scope" or "I disagree with the suggestion but want to be polite" or "I need to push back" or "I want to acknowledge but reroute". The user may state the substance explicitly or it may need to be inferred from their message to the agent.

4. **Draft the message in the user's voice** following the rules above. Keep it short.

5. **Post-process with the `ai-scrubber` skill.** Em-dashes, en-dashes, list syntax, and sentence-ending quips are training artifacts the drafting agent produces despite intent. Invoke `ai-scrubber` with the draft text and the channel register (casual / formal). Replace the draft with the scrubbed output before handing back to the user.

6. **Hand it back with light scaffolding.** Show the draft in a quote block; the user copies the inner text, not the `>` prefixes. Briefly note tonal choices the agent made (e.g., "kept it three short paragraphs", "ended on her action"). Offer to adjust without re-justifying. Never say "this draft is now AI-resistant" or similar self-praise.

7. **Iterate on the user's feedback.** If they say "make it more deferential" or "add a typo" or "remove that hedge", do exactly that without arguing.

---

## Calibration questions to ask the user if needed

If the situation isn't clear, ask before drafting:

- "Who is the recipient and what channel is this going on?"
- "What's the substance you want to convey? (Push back, agree-and-reroute, just acknowledge, etc.)"
- "Anything specific the recipient is sensitive about that I should know?"
- "Want this more or less casual than usual for that channel?"

Don't ask all of these — just the ones genuinely missing.

# ────── REVIEW MODE ──────

## When review mode fires

Review mode is retrospective: the user wants the agent to scan their recent outgoing messages and surface opportunities to communicate better, plus moments worth celebrating.

**Trigger phrases (natural language):** "review my comms", "review my slack today", "audit my recent posts", "feedback on this week's comms", "how did I communicate yesterday?", or anything that reads as asking for retrospective coaching on the user's own writing.

**Explicit invocation grammar:**

```
/comms review                           → today (default)
/comms review today
/comms review yesterday
/comms review this week                 → Mon 00:00 → now
/comms review last week                 → previous Mon 00:00 → Sun 23:59
/comms review last N days               → rolling N×24h ending now
/comms review since YYYY-MM-DD          → from that date 00:00 → now
/comms review YYYY-MM-DD..YYYY-MM-DD    → ISO range, inclusive
```

All times use the user's local timezone. If the user's phrasing maps to no recognizable window, ask once.

## Setup dialog (every run)

Communications are sensitive data. Run the setup dialog **every time** review mode fires, before any data collection. The user explicitly chose this stance — scope decisions belong with the user, per run.

Show this dialog and wait for an answer (one-line answers like "standard, everything" are fine; "go" / "default" accepts all defaults):

```
Reviewing your comms for [parsed window]. Quick scope check:

  Sources:    Slack (DMs + channels), Gmail (sent), Jira comments, GitHub PRs
  Depth:      1) Light pass — strongest signals only (🔴 only)
              2) Standard — clear principle drift (🔴 + 🟠) [default]
              3) Deep dive — include borderline cases (🔴 + 🟠 + 🟡)
  Scope:      a) Everything [default — recommended]
              b) Channels + Jira + Gmail + GitHub, no Slack DMs
              c) Custom — tell me what to skip
  GitHub:     all repos [default], or narrow (e.g. Tripleseat/*)

  Window confirm: [parsed window], or override?
```

**Privacy callout — show in the dialog:**

> Note: review will quote your DM/Gmail/Jira content in the report and save a markdown copy to `tmp/comms-review/`. Make sure that directory is gitignored.

**First-run gitignore check:** before writing any report, verify `tmp/comms-review/` (or `tmp/`) is gitignored. Run `git check-ignore tmp/comms-review` from the repo root, or inspect `.gitignore` and `.git/info/exclude`. If not gitignored, stop and warn the user before writing anything. Resume only after the user confirms or adds the entry.

## Sources and how to collect them

Each surface has its own discovery pattern. All collection respects the per-run scope answer.

### Slack — `slack_search_public_and_private`

- Query: `from:@me after:<window-start> before:<window-end>`.
- For each result, capture channel/DM, timestamp, message text.
- For threaded messages, fetch the parent + nearest preceding sibling reply via `slack_read_thread` for context (one turn back is usually enough to evaluate tone).
- DMs included or excluded based on the scope answer.

### Gmail — `search_threads` then `get_thread`

- Query: `from:me after:YYYY/MM/DD before:YYYY/MM/DD` (Gmail's native query syntax — note slashes, not dashes).
- For each thread, isolate messages where `from == me`; keep the immediately preceding message as context.

### Jira — `searchJiraIssuesUsingJql` + `getJiraIssue`

- JQL has no native "comments by author" filter. Use a candidate-issue query first:
  ```
  (assignee = currentUser() OR reporter = currentUser() OR watcher = currentUser())
    AND updated >= <window-start>
  ```
- For each candidate issue, fetch comments, filter to author = current user with `created` inside the window. Include the immediately preceding comment as context.

### GitHub PRs — `gh` CLI through Bash

- Resolve the user's GitHub login once: `gh api user --jq .login`.
- Find candidate PRs in the window:
  ```
  gh search prs --commenter=<login>  --updated=">=YYYY-MM-DD" --json url,repository,number
  gh search prs --reviewed-by=<login> --updated=">=YYYY-MM-DD" --json url,repository,number
  ```
  Union the two result sets. Honor the GitHub repo scope from the setup dialog.
- For each candidate PR, fetch three comment streams:
  ```
  gh api repos/OWNER/REPO/issues/NUMBER/comments        # top-level PR comments
  gh api repos/OWNER/REPO/pulls/NUMBER/comments         # inline review comments
  gh api repos/OWNER/REPO/pulls/NUMBER/reviews          # review summary bodies
  ```
- Filter to `user.login == <login>` with `created_at` inside the window. Include the immediately preceding comment in the same thread as context.

### Pre-pass filtering (lightweight, before evaluation)

Skip messages that obviously can't carry a finding:

- Single-emoji reactions or single-emoji messages
- Pure acknowledgments: "ty", "ok", "👍", "🙏", "LGTM", ":shipit:"
- Bot-formatted PR notifications, calendar replies, automated bodies
- Empty review-summary bodies on simple approvals

This reduces token cost and noise without losing real signals.

### Volume guardrail

If candidate count exceeds 200 messages after pre-pass, surface this in the setup-dialog confirmation and ask whether to proceed, narrow the window, or sample. Typical "today" runs are well under this; "this week" can approach it.

### Failure handling

If a source's MCP isn't authenticated (Atlassian / Slack toggled off, `gh auth status` failing), report it explicitly in chat — same pattern as draft mode — and continue with the available sources rather than silently skipping.

## What review mode flags

The four pattern categories. A message can trigger more than one — the canonical example ("next time can we please loop in QA before merging 😊") triggers tone risk + self-signal together.

### 1. Tone risk — ⚠️

Substance language likely to land defensively. Look for:

- Directives to peers ("next time", "please remember to", "going forward")
- Implied criticism without acknowledged context ("this is fine but…", "I noticed you…")
- Closing the loop on the recipient's behalf (deciding scope/priority/next-steps for them)
- "Well actually" framings, even subtle
- Asymmetric framing of disagreement (treating their position as something they need to defend)
- **Requests for time, attention, or effort with no acknowledgment of the ask.** Asking someone to review, answer, weigh in, or take action without "please", "if you're willing", "when you have a moment", or equivalent. The request is framed as expectation rather than ask — a subtle but real encroachment on the recipient's autonomy.

Anchored to the AMP principles documented above: language that erodes Autonomy / Mastery / Purpose → flagged.

### 2. Self-signals — 🪞

The substance and the framing don't match. The framing is doing rescue work the substance shouldn't need:

- Softening emoji on edgy content
- Stacked hedges ("I just wanted to maybe see if possibly…")
- Performative exclamation marks ("Thanks!! Really appreciate it!!")
- "Sorry to bother…" preamble on a routine ask
- Excessive deference where the user has full standing to take a position
- **Message longer than the substance requires.** Unnecessary preamble, repeated points, over-justification that could be cut without losing meaning. The recipient's time is finite; extra length is a cost the message shouldn't impose. Flag when a message could be meaningfully shorter without losing what matters.

**Framing rule:** treat the rescue as the user's subconscious flagging the message. The rescue is the signal.

### 3. Channel fit — 🧭

Mirror of draft mode's channel-fit logic, applied retrospectively:

- Slack channel post that should have been a Jira / PR / doc comment (story-specific or PR-specific content out of the artifact's gravity well)
- Group post when only one or two people could answer (should have been a DM or @-tag)
- Cross-channel duplication (same question in two places)
- Resolution drift (a Slack thread that resolved a Jira ticket without writing back to the ticket)

### 4. AI-tells & performative polish — 🤖

Training artifacts that appear in LLM-assisted drafts even when the agent tries to avoid them. In review mode these flag that a message was likely drafted with AI help without post-processing:

- Em-dashes and en-dashes (`—`, `–`) in casual contexts
- `- X - Y - Z` list syntax in casual registers (Slack, short emails)
- Unnecessary sentence-ending quips — the small rhetorical flourish that adds no information
- "Furthermore", "That said,", "TL;DR:", "In short:"
- Symmetric "Did you mean X, or did you want Y?" framings
- Closing summaries that don't add information

This category is most useful as a calibration check: these patterns in real sent messages are a signal that drafts went out without the post-processing step. The fix is upstream — make sure the Haiku post-processor runs before the user pastes.

### Out of scope (made explicit)

- Typos and grammar — small imperfections are part of authentic voice
- Meta-feedback like "you should have used the comms skill here"
- Personal taste differences from the documented principles
- Anything that requires guessing intent — if not pretty sure, skip rather than nag

Bias toward false negatives over false positives. A confident finding teaches; a wrong finding annoys.

## How findings are formatted

### Visual palette (the only emoji used in reports)

Severity discs:

- 🔴 Strong — clearly worth reflecting on, recipient likely to feel it
- 🟠 Notable — pattern present, milder impact
- 🟡 Borderline — included so the user can decide
- 🟢 Well-applied / exemplary / improved

Category emoji:

- ⚠️ Tone risk
- 🪞 Self-signal
- 🧭 Channel fit
- 🤖 AI-tells

**Restraint rule:** the report uses only the eight glyphs above. No decorative ✨🎉📊👀🚀 anywhere else in the output. The agent's own prose in the report (the overall observation, finding rationales, win descriptions) avoids the same AI-tell patterns flagged in user messages: no em-dashes or en-dashes, no "TL;DR:" or "In short:", no unnecessary sentence-ending quips, no symmetric "Did you mean X, or Y?" framings. Note that these are training artifacts — the agent should make a deliberate pass over its own report prose before outputting. Signal-to-noise is the point.

### Per-finding format (growth findings)

```markdown
### 🔴 ⚠️🪞 Slack #design-review — Tue 2:47pm
> "this is fine but next time can we please loop in QA before merging 😊"

**Pattern:** Tone risk + Self-signal
**Why it might land:** "next time can we please" reads as a directive to a peer, and the smiley is doing tone-rescue work. The rescue is your subconscious flagging this for you.
**Suggested rewrite:**
> could we loop in QA before merging? want to make sure we don't regress.
```

Heading anatomy: severity disc → category emoji(s) → source/channel → day/time. A finding with multiple patterns shares one heading rather than duplicating.

The **Suggested rewrite** is drafted in the user's voice using draft-mode principles (AMP, YES CHEF, no AI tells, hand back agency).

### Wins findings — same shape, no rewrite

```markdown
### 🟢 🪞 Slack DM @priya — Wed 11:12am
> "yeah you're right, that was the wrong call. let me fix it."

**Why it works:** clean accountability with no rescue language, no over-explanation, no preemptive justification. Substance and framing matched. This is YES CHEF in the wild.
```

No "Suggested rewrite" section on wins — there's nothing to rewrite, the message is what's being celebrated.

**Don't invent wins.** If nothing genuinely stood out as exemplary in the window, omit the Wins section. Empty cheerleading is worse than no cheerleading.

## Report structure

The report renders in chat AND saves to a markdown file (Output destination, below). Both copies have identical content.

### Top summary

```markdown
# Comms review — this week (Mon May 4 → Fri May 8 2:30pm)

**Sources:** Slack DMs+channels, Gmail (sent), Jira comments, GitHub PRs
**Scope this run:** Everything       **Depth:** Standard

**Volume reviewed:**
- Slack: 87  (32 channels, 55 DMs)
- Gmail: 12 sent
- Jira: 9 comments / 4 issues
- GitHub: 21 comments / 6 PRs

**Findings: 6 growth, 3 wins**
- ⚠️ Tone risk:    🔴 🔴 🟠       (wins: 🟢)
- 🪞 Self-signal:  🟠 🟡           (wins: 🟢)
- 🧭 Channel fit:  🟠              (wins: 🟢)
- 🤖 AI-tells:     —              (wins: —)

_Both self-signals were softening emoji on directives, pattern worth watching. Strong week on accountability framing in DMs._
```

The disc string per category is the at-a-glance heatmap: count *and* hottest-first ordering visible without reading further. The italicized one-liner at the end is the agent's overall observation across findings — a real pattern read, both growth and strength. Skip it if there's nothing meaningful to say. **Never invent the observation to balance the report.**

### Body order

```
Top summary
  → Trend block (if applicable; see Trend tracking section)
  → ## Wins                  (omitted if zero wins; never invented)
  → ## Growth findings       (grouped by source: Slack → Gmail → Jira → GitHub;
                              within source, chronological)
  → Footer:  Saved to tmp/comms-review/<filename>
```

### Empty-findings case

If the run produced zero growth findings AND zero wins, still generate and save the report. The body says: `No patterns flagged in this window. Volume reviewed above.` The calibration is itself a useful signal — a quiet report after a busy week is real data.

## Output destination

```
tmp/comms-review/YYYY-MM-DD-HHMM-<window-slug>.md
```

Examples:

- `tmp/comms-review/2026-05-08-1430-today.md`
- `tmp/comms-review/2026-05-08-1645-yesterday.md`
- `tmp/comms-review/2026-05-08-1731-this-week.md`
- `tmp/comms-review/2026-05-08-1731-last-3-days.md`

Timestamp prevents collisions on multi-run-per-day; window-slug enables trend matching.

After writing, the chat output ends with a single line: `Saved to tmp/comms-review/<filename>` so the file path is one click away.

**No auto-pruning.** Reports accumulate until the user removes them. The archive is intentionally a personal coaching dataset over time — the user's improvement is measurable across runs.

## Trend tracking

When a review runs, scan `tmp/comms-review/` for prior reports with the **same window-slug** (e.g., previous `this-week.md` files). Read their top-summary blocks, extract finding counts per category, render two trend views in the report.

### Trend views

**Vs. last comparable run** (always shown when at least one prior exists):

```markdown
**Trend vs. last 'this week' review** (2026-05-01-1502):
- ⚠️ Tone risk:    3 (was 5) ↓
- 🪞 Self-signal:  2 (was 4) ↓
- 🧭 Channel fit:  1 (was 1) =
- 🤖 AI-tells:     0 (was 1) ↓
```

**Sparkline of last N comparable runs** (default N = 5; shown when ≥ 2 priors exist):

```markdown
**Last 5 'this week' reviews** (oldest → newest):
- ⚠️ Tone risk:    7 → 5 → 5 → 5 → 3
- 🪞 Self-signal:  6 → 4 → 4 → 4 → 2
- 🧭 Channel fit:  2 → 1 → 1 → 1 → 1
- 🤖 AI-tells:     2 → 1 → 1 → 1 → 0
- 🟢 Wins:         1 → 2 → 2 → 3 → 3
```

Wins go on the same chart so improvement is visible on both axes — less of the bad, more of the good.

### Matching rule

Trend matching uses the **`<window-slug>`** portion of the filename, not the date prefix:

- `today` ↔ `today`
- `yesterday` ↔ `yesterday`
- `this-week` ↔ `this-week`
- `last-week` ↔ `last-week`
- `last-N-days` ↔ identical N (e.g., `last-3-days` only matches other `last-3-days`)

So daily `today` runs all compare to each other; weekly `this-week` runs all compare to each other.

### When to omit the trend block

- Zero prior comparable reports → no trend block at all
- Exactly one prior → vs-last only, no sparkline
- Two or more priors → both views

### Robustness

Parse priors by looking for the `**Findings:**` line and the four category lines. If a prior report is malformed (missing fields, structure changed) silently skip it — broken priors never break the new report.

# ────── SHARED ──────

## What this skill is for, and what it isn't

This skill is for collaborative communication.

**Draft mode** is for replies and outgoing messages where the user is talking with a teammate, partner, or stakeholder. The agent stays in the user's voice and hands the message back; the user does the sending.

**Review mode** is for self-coaching. The user reviews their own past communication and learns from it. The report stays on the user's machine; it is not for performance review by anyone else, and the agent never shares it externally.

Other contexts have their own conventions:

- Internal-to-the-user content (notes, planning docs, summaries) follows normal agent style — no need for the YES CHEF posture.
- Content that ships under the agent's own attribution (PR descriptions, internal docs) uses normal style.
- Adversarial, formal, or legal communications need their own playbooks, not this one. Ask the user for explicit instruction before drafting.

## Adapting this skill to a specific user

The principles in this skill (AMP, YES CHEF, channel-fit, no AI tells) are universal across collaborative voices. Two layers are user-specific and should be tuned over time.

Recommended ways to capture user-specific tone:
- Keep a short personal note alongside this file (e.g., the agent's global instructions file, project memory, or another agent-readable location) that lists the user's go-to phrases, words to avoid, and any specific stylistic tells (lowercase chat? typos OK? emoji?).
- Update this skill in place when patterns become clear.
- Use the calibration questions to surface anything ambiguous before drafting.
