# Contributing to together

Improvements to existing skills and new communication or collaboration skills are welcome.

## Scope

This collection focuses on communication and collaboration — how people write to each other, how they give and receive feedback, how they navigate team dynamics. It is not a general-purpose skills collection.

Good fits:
- Improvements to existing skill logic, examples, or research backing
- New skills for communication contexts (async updates, meeting follow-ups, giving feedback, receiving feedback, 1:1s)
- Edge cases or channel-specific behavior not yet covered

Not a fit:
- Technical task automation (code review, debugging, deployment) — there are already excellent collections for those

## How to contribute

1. Fork the repo
2. Create a branch: `git checkout -b skill/your-improvement`
3. Make your change
4. Open a pull request with a clear description of what changed and why

## Skill structure

Each skill lives in `skills/<skill-name>/` and requires:

```
skills/
└── skill-name/
    ├── SKILL.md      # The skill itself — loaded by the agent
    └── README.md     # Human-readable documentation for GitHub
```

`SKILL.md` frontmatter:

```yaml
---
name: skill-name
description: One or two sentences describing when this skill fires and what it does.
contributed-by: your-github-handle
status: contributed
user-invocable: false
---
```

## Voice and style

Skills in this collection share a set of principles (AMP, YES CHEF, channel-fit, no AI tells). If you're adding a new skill, read the `comms` skill first — it documents those principles in detail and is the reference for the collection's voice and values.

New skills don't need to repeat all of that preamble, but they should be consistent with it.
