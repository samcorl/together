# AI Scrubber

Removes LLM training artifacts from text — the patterns that make AI-assisted writing recognizable as AI-assisted even when the content is good.

## The problem

Em-dashes, en-dashes, polished list syntax, and sentence-ending quips aren't stylistic choices an LLM makes consciously. They're training artifacts. Telling the model not to use them doesn't work reliably — they surface anyway. The fix is a dedicated post-processing pass, not a rule.

## What it removes

- **Em-dashes and en-dashes** (`—`, `–`) — replaced with commas, hyphens, or parentheses as context warrants
- **`- X - Y - Z` list syntax in casual contexts** — converted to flowing prose (formal bullet lists are left alone)
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

`ai-scrubber` is intentionally narrower: three mechanical patterns, Haiku model, text-only output, no report. That makes it suitable for short team messages and embeddable as a silent step inside other skills. For anything where you want a full audit or are editing published content, reach for one of the above instead.
