# together

A Claude Code plugin for communication and collaboration skills.

There are already a lot of great skills for technical tasks. This collection focuses on the other half of the work: how you communicate with your team. How you write a Slack message, respond to a PR comment, or look back at your own communication and learn from it.

## Skills

### comms

Helps you draft messages, comments, and replies in your authentic voice — and review your own past communications for patterns.

- **Draft mode** — "draft a reply to this thread", "help me respond to this Jira comment", "write a Slack message to @priya"
- **Review mode** — "review my comms today", "audit my slack this week", `/comms review yesterday`

See [skills/comms/README.md](skills/comms/README.md) for full documentation.

### ai-scrubber

Removes LLM training artifacts from any text — em-dashes, en-dashes, list syntax in casual contexts, and unnecessary sentence-ending quips. Useful any time you use AI to help write something you'll send or publish.

- "scrub this", "remove the AI tells from this draft", "make this sound less like an LLM"
- Invoked automatically by `comms` after drafting

See [skills/ai-scrubber/README.md](skills/ai-scrubber/README.md) for full documentation.

## Install

```
/plugin install together
```

## Why communication skills?

Most agent skills automate technical work. But the things that make or break team collaboration — how you phrase a PR comment, whether you direct a question to the right person, whether your tone respects the recipient's expertise — don't get any help from an agent by default.

This collection is a deliberate practice of writing that respects each recipient's autonomy, expertise, and dignity. Every draft is a chance to reinforce communication patterns that build real collaborative relationships.

## Contributing

Improvements to existing skills and new communication or collaboration skills are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md).
