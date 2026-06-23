# AI Scrubber

Removes LLM training artifacts from text — the patterns that make AI-assisted writing recognizable as AI-assisted even when the content is good.

## The problem

Em-dashes, en-dashes, polished list syntax, and sentence-ending quips aren't stylistic choices an LLM makes consciously. They're training artifacts. Telling the model not to use them doesn't work reliably — they surface anyway. The fix is a dedicated post-processing pass, not a rule.

## What it removes

- **Em-dashes and en-dashes** (`—`, `–`) — replaced with commas, hyphens, or parentheses as context warrants
- **`- X - Y - Z` list syntax in casual contexts** — converted to flowing prose (formal bullet lists are left alone)
- **Parallel gerund series** — three or more participial phrases stacked in a comma-separated series ("Driving X, shaping Y, owning Z") in place of a direct declarative statement. Collapsed to a single clause with a real subject and verb. The literature names the component patterns *Tricolon Abuse* (rule-of-three overuse) and *Gerund Fragment Litany* (verbless gerund phrases used to pad or imply breadth). Together they produce prose that sounds comprehensive while saying nothing specific.
- **Unnecessary sentence-ending quips** — the small aside or flourish that adds no information; removed if the sentence is complete without it

Nothing else changes. The scrubber does not rephrase, restructure, adjust tone, or fix grammar. Invisible surgery.

## How to use

**Standalone:**

> "scrub this"

> "clean up this draft"

> "remove the AI tells from this"

**From another skill:** the `comms` skill invokes `ai-scrubber` automatically after drafting. Other skills that produce text for the user to send can do the same.

## Install

```
/plugin install together
```

## Related tools

If you need deeper auditing on longer-form content (articles, blog posts, documentation), these skills cover a much broader pattern set:

- **[humanizer](https://github.com/blader/humanizer)** — comprehensive AI writing pattern removal based on Wikipedia's "Signs of AI writing" guide; covers inflated symbolism, promotional language, passive voice, rule of three, and more
- **[avoid-ai-writing](https://github.com/conorbronsdon/avoid-ai-writing)** — three-mode tool (rewrite, detect, edit-in-place) with voice profiles and iterate-to-convergence; available in the official Claude Code marketplace

`ai-scrubber` is intentionally narrower: four mechanical patterns, Haiku model, text-only output, no report. That makes it suitable for short team messages and embeddable as a silent step inside other skills. For anything where you want a full audit or are editing published content, reach for one of the above instead.

## Research references

The patterns targeted by this skill are documented in the following research and catalogs:

- [AI Writing Patterns: The Complete Database of Phrases, Cadences, and LLM Writing Fingerprints](https://www.bloomberry.ai/research/ai-writing-patterns) (Bloomberry) — 7,400+ catalogued patterns across ChatGPT, Claude, Gemini, and open-source LLMs; source for *Tricolon Abuse* and *Gerund Fragment Litany* naming
- [Why ChatGPT writes like that](https://www.deadlanguagesociety.com/p/rhetorical-analysis-ai) (Colin Gorrie, Dead Language Society) — rhetorical analysis of how RLHF reinforces patterns that score well (tricolon, contrast structures, motivational openers) until they become defaults
- [tropes.fyi — LLM writing tics catalog](https://agent-wars.com/news/2026-03-12-tropes-fyi-publishes-a-comprehensive-catalog-of-ai-writing-tics-as-a-single) (Agent Wars, 2026) — single Markdown file covering six categories of LLM tics: word choice, sentence structure, paragraph structure, tone, formatting, and composition
- [The Disappearing Author: Linguistic and Cognitive Markers of AI-Generated Communication](https://researchleap.com/the-disappearing-author-linguistic-and-cognitive-markers-of-ai-generated-communication/) (ResearchLeap) — academic survey covering formal parallel constructions and negative parallelism as AI markers
- [Linguistic Characteristics of AI-Generated Text: A Survey](https://arxiv.org/pdf/2510.05136) (arXiv 2510.05136) — formal analysis of vocabulary diversity, repetitive part-of-speech sequences, and structural patterns that distinguish AI from human authorship
- [Wikipedia: Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) — community-maintained reference; documents *dangling -ing clauses* specifically: AI's habit of ending factual statements with vague interpretive phrases ("reflecting the continued relevance of...", "highlighting the importance of...") that add no information but gesture at meaning; closest named analog to sentence-ending quips
- [A Field Guide to Terrible AI Writing](https://medium.com/@tdoherty_96508/a-field-guide-to-terrible-ai-writing-6a83ddb6a141) (Thomas E. Doherty, Medium) — practitioner catalog; covers closing quips and rhetorical tags: lines meant to sound sharp that instead inflate a basic point and present it as a revelation
- [The Predictable Rhetoric of AI-Generated Text: Overused Stylistic Devices](https://medium.com/@mgibson_99548/the-predictable-rhetoric-of-ai-generated-text-overused-stylistic-devices-9a6aa07ab368) (Mark Gibson, Medium, 2026) — covers AI's tendency to end content with platitude-type statements and pseudo-reflective closers that sound meaningful but carry no specific information
