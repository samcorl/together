# together

A collection of communication and collaboration skills for Claude Code.

## Skills in this plugin

- **comms** — draft replies and outgoing messages in the user's authentic voice; review recent communications for patterns and improvement. Triggers on "draft a reply", "help me respond", "review my comms", and similar.
- **ai-scrubber** — post-processes AI-assisted text to remove training artifacts (em-dashes, en-dashes, list syntax in casual contexts, unnecessary sentence-ending quips). Triggers on "scrub this", "remove AI tells", "make this sound less like an LLM". Also invoked automatically by `comms` after drafting.

## Releasing updates

Bump the version in `.claude-plugin/plugin.json` before every commit that makes functional changes to skills. The marketplace uses the version field to detect updates — users who installed this plugin only receive changes when the version increments.
