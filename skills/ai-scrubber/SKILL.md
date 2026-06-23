---
name: ai-scrubber
description: Post-processes AI-assisted text to remove training artifacts that make it read as LLM-generated. Targets em-dashes, en-dashes, list syntax in casual contexts, and unnecessary sentence-ending quips. Use when the user asks to "scrub this", "clean up this draft", "remove AI tells", "make this sound less like an LLM", or when another skill needs to post-process a draft before handing it to the user.
contributed-by: samcorl
status: contributed
user-invocable: true
---

# AI Scrubber

Em-dashes, en-dashes, polished list syntax, and sentence-ending quips are training artifacts. LLMs produce them even when instructed not to — they're baked in at a level that self-policing can't reach. This skill runs a Haiku subagent as a dedicated post-processor to find and remove them.

## What it fixes

**Em-dashes and en-dashes** (`—`, `–`)
LLMs default to these for rhythm and subordination. Human writers in casual contexts reach for a comma, a hyphen, or parentheses instead. The scrubber replaces each one with whichever reads most naturally in context.

**`- X - Y - Z` list syntax in casual registers**
In Slack messages, short emails, and chat, humans write prose. Bullet lists in these contexts are an AI tell. The scrubber converts them to flowing sentences. It leaves formal lists alone — enumerated steps in a Jira comment or GitHub PR description are appropriate there.

**Parallel gerund series ("Driving X, shaping Y, owning Z")**
Stacked participial phrases in a comma-separated series are a strong LLM tell, especially in cover letters, bios, and performance reviews. The pattern: three or more gerund or past-participial phrases used in place of a direct declarative statement. LLMs use this to sound comprehensive; humans pick the most important thing and say it plainly. The scrubber collapses these to a single direct clause with a real subject and verb. Example: "Driving technical direction, shaping how the team thinks about systems, owning the problem end-to-end" → "I own technical direction end-to-end."

**Unnecessary sentence-ending quips**
The small rhetorical flourish at the end of a sentence that adds no information — the little aside, the softening parenthetical, the "just wanted to flag that" type of tag. If removing it leaves the sentence complete and clear, it goes. If it carries real information, it stays.

## What it does not fix

This skill makes only the three changes above. It does not:
- Rephrase, restructure, or shorten
- Change tone or register
- Fix grammar or punctuation beyond the targeted patterns
- Remove content the user put there intentionally

The goal is invisible surgery. A scrubbed draft should read exactly like the original except that it no longer reads like an LLM wrote it.

## How to invoke

**Standalone** — paste text and ask:
> "scrub this"
> "clean up this draft"
> "remove the AI tells from this"
> "make this sound less like an LLM"

**From another skill** — skills that produce text for the user to send (like `comms`) invoke this as a post-processing step before handing the draft back.

## Process

1. **Receive the text.** Either from the user directly or passed in from another skill.

2. **Identify the register.** Is this casual (Slack, short email, DM, chat) or formal (Jira steps, GitHub PR with enumerated items, structured doc)? This determines whether list syntax gets converted.

3. **Spawn a Haiku subagent** with the text and these instructions:

   > You are a copy editor removing AI signature patterns from a text. Make only the following changes — no other edits:
   >
   > 1. Replace every em-dash (—) and en-dash (–) with a natural alternative: a comma, a hyphen (-), or parentheses, whichever reads most naturally in context.
   > 2. If the text is in a casual register (Slack message, short email, chat reply) and uses "- X - Y - Z" list syntax, rewrite those items as flowing prose. Leave formal bullet lists (Jira steps, GitHub PR enumerated items, structured documentation) alone.
   > 3. Collapse parallel gerund series. When you see three or more participial phrases stacked in a comma-separated series ("Driving X, shaping Y, owning Z"), replace the whole construction with a single direct clause using a real subject and verb. Pick the most substantive phrase and rewrite it directly. Example: "Driving technical direction, shaping how the team thinks about systems, owning the problem end-to-end" → "I own technical direction end-to-end."
   > 4. Remove unnecessary sentence-ending quips — the small rhetorical flourish tacked onto the end of a sentence that adds no information. If removing it leaves the sentence complete and clear, remove it. If the quip carries real information, leave it.
   >
   > Return only the corrected text. No commentary, no explanation, no summary of changes.

4. **Return the scrubbed text.** If invoked standalone, show the result in a quote block so the user can copy the inner text. If invoked from another skill, pass the result back to that skill's next step.

## Notes for callers

When another skill invokes `ai-scrubber` as a post-processing step, it should pass:
- The draft text
- The register (casual / formal) if already known — this saves the subagent from inferring it

The scrubber returns only the corrected text, no metadata.
