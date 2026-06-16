# Comms — drafting and reviewing thoughtful team communication

Same words, different recipient, different outcome. Cross-functional teams are made up of people with different communication styles, sensitivities, and ways of receiving feedback. This skill helps you draft messages, comments, and replies that hold up across that variety.

This is a deliberate practice of writing that respects each recipient's autonomy, expertise, and dignity. Every draft is a chance to reinforce a pattern of communication that builds collaborative relationships across varied styles. Think of it as Duolingo for team comms: the focus is on authenticity and genuine connection, not corporate veneer or LLM polish.

## What it does

The skill has two modes.

### Draft mode

When you ask your agent (Claude Code, or any agent that loads the same skill format) to "draft a reply", "comment on this PR", "respond to this Jira note", etc., the skill walks the agent through:

1. **Reading the full context** of what's being replied to — the thread, the social dynamics, the unstated stakes.
2. **Sanity-checking the channel** you picked, and pushing back if the substance is better suited elsewhere (e.g., a PR comment instead of a Slack post).
3. **Drafting in your voice**, with the AMP framing (Autonomy, Mastery, Purpose) and the YES CHEF posture (deferential, action-ready, no defensiveness).
4. **Avoiding AI tells** so the message reads like you wrote it.
5. **Handing it back for review** — the agent doesn't send anything; you paste.

### Review mode

When you ask "review my comms", "audit my slack today", or invoke `/comms review [window]`, the skill walks the agent through:

1. **Asking what scope you want** for this run — sources, depth, GitHub repo filter, window confirmation. Run every time.
2. **Collecting your authored messages** from Slack (channels + DMs), Gmail (sent), Jira comments, and GitHub PRs in the window.
3. **Flagging four pattern categories** — tone risk (⚠️), self-signals (🪞), channel fit (🧭), AI-tells (🤖) — with a severity heatmap (🔴🟠🟡) plus positive examples (🟢) of the principles applied well.
4. **Suggesting rewrites** for growth findings, in your voice.
5. **Tracking improvement over time** by reading prior reports in `tmp/comms-review/` and rendering trend lines and a sparkline of the last 5 comparable runs.
6. **Saving to `tmp/comms-review/YYYY-MM-DD-HHMM-<window-slug>.md`** so the archive becomes a personal coaching dataset.

Triggers:

```
/comms review            → today
/comms review yesterday
/comms review this week
/comms review last 3 days
/comms review since 2026-05-01
```

Or natural language: "review my comms", "feedback on this week's slack", "how did I communicate yesterday?".

## How to Use

**Draft mode** — paste a thread, comment, or context and ask for a reply:

> "draft a reply to this Slack thread"

> "help me respond to this Jira comment"

> "write a Slack message to @priya about the deploy"

**Review mode** — ask the skill to look back at recent communications:

> "/comms review yesterday"

> "review my slack today"

> "feedback on this week's comms"

## Why these rules?

The recipient is a real person with real preferences. The patterns this skill encourages — short, deferential, inviting a response, ending on the recipient's decision rather than the writer's reasoning — work because they reflect real respect. The genuineness is what people respond to.

Every team has people who prefer concise feedback, people who want to be looped in early, people who appreciate trust over hand-holding. This skill leans toward defaults that work well across that diversity, and asks for clarification when context isn't clear.

## Research backing

The principles above synthesize work from several research traditions, not personal preference. Each cluster below names primary sources with verifiable URLs (publisher pages, DOIs, or author institutional pages). If a principle in the skill feels like opinion, follow it back to its lineage here.

### Autonomy, mastery, and purpose

*Used by:* The North Star (AMP / Agency); core rule 1 (Hand them agency); core rule 3 (End on the recipient's action).

1. **Pink, D. H. (2009). *Drive: The Surprising Truth About What Motivates Us*. Riverhead Hardcover.** ([danpink.com/books/drive](https://www.danpink.com/books/drive/))
   *Agent Summary:* Synthesizes the autonomy/mastery/purpose framework for a general audience. The direct source of "AMP" as the skill uses it.

2. **Ryan, R. M., & Deci, E. L. (2000). "Self-Determination Theory and the Facilitation of Intrinsic Motivation, Social Development, and Well-Being." *American Psychologist*, 55(1), 68–78.** ([doi.org/10.1037/0003-066X.55.1.68](https://doi.org/10.1037/0003-066X.55.1.68))
   *Agent Summary:* The foundational psychology paper behind Pink's synthesis, postulating autonomy, competence, and relatedness as innate psychological needs whose support drives well-being and self-motivation.

### Politeness, face, and deferential framing

*Used by:* The YES CHEF stance; core rule 1 (Hand them agency); core rule 2 (no "well actually"); review-mode pattern 1 (Tone risk).

3. **Brown, P., & Levinson, S. C. (1987). *Politeness: Some Universals in Language Usage*. Cambridge University Press.** ([cambridge.org](https://www.cambridge.org/highereducation/books/politeness/89113EE2FB4A1D254D4A8D2011E542E4))
   *Agent Summary:* The canonical text on positive vs. negative face and face-threatening acts. The skill's instinct that directives to peers ("next time…", "please remember to…") read as face-threats traces here.

4. **Goffman, E. (1955). "On Face-Work: An Analysis of Ritual Elements in Social Interaction." *Psychiatry*, 18(3), 213–231.** ([doi.org/10.1080/00332747.1955.11023008](https://doi.org/10.1080/00332747.1955.11023008))
   *Agent Summary:* The original "face" essay that Brown & Levinson built on. Establishes the social-ritual basis for what the skill calls handing back agency.

5. **Rosenberg, M. B. (2015). *Nonviolent Communication: A Language of Life* (3rd ed.). PuddleDancer Press.** ([nonviolentcommunication.com](https://nonviolentcommunication.com/product/nvc/))
   *Agent Summary:* Offers the observation/feelings/needs/requests structure as an alternative to blame language. The skill's "treat their feedback as given, not as something they have to defend" comes directly from this tradition.

6. **Patterson, K., Grenny, J., McMillan, R., & Switzler, A. (2011). *Crucial Conversations: Tools for Talking When Stakes Are High* (2nd ed.). McGraw-Hill.** ([oreilly.com](https://www.oreilly.com/library/view/crucial-conversations-tools/9780071771320/))
   *Agent Summary:* Practitioner synthesis of "Make It Safe" and "Mutual Purpose". What the skill operationalizes when it pushes for short, deferential, decision-handing-back framings.

### Channel fit and attention cost

*Used by:* Channel fit (push back when wrong); review-mode pattern 3 (Channel fit violations).

7. **Daft, R. L., & Lengel, R. H. (1986). "Organizational Information Requirements, Media Richness and Structural Design." *Management Science*, 32(5), 554–571.** ([doi.org/10.1287/mnsc.32.5.554](https://doi.org/10.1287/mnsc.32.5.554))
   *Agent Summary:* The foundational Media Richness Theory paper. Different channels suit different message types based on uncertainty and equivocality. The research basis for "Slack post about TPD-XXXX should be a Jira comment."

8. **Mark, G., Gudith, D., & Klocke, U. (2008). "The cost of interrupted work: more speed and stress." *Proceedings of CHI '08*, 107–110.** ([doi.org/10.1145/1357054.1357072](https://doi.org/10.1145/1357054.1357072))
   *Agent Summary:* Empirical study showing interruption causes faster work but at the cost of higher stress and effort. Directly supports the skill's stance that group-channel posts when only one or two people can answer have a real attention-cost externality.

9. **Kraut, R. E., Fish, R. S., Root, R. W., & Chalfonte, B. L. (1990). "Informal communication in organizations: Form, function, and technology." In S. Oskamp & S. Spacapan (Eds.), *Human Reactions to Technology: The Claremont Symposium on Applied Social Psychology*, 145–199. Sage.** ([kraut.hciresearch.info (PDF)](https://kraut.hciresearch.info/wp-content/uploads/kraut90-InformalCommInOrgs.pdf))
   *Agent Summary:* Coordination-cost research showing proximity (or the right channel) reduces it. Why "narrower channel with a direct @-tag" beats a group-channel broadcast for a one-or-two-person question.

10. **Newport, C. (2016). *Deep Work: Rules for Focused Success in a Distracted World*. Grand Central Publishing.** ([calnewport.com](https://calnewport.com/deep-work-rules-for-focused-success-in-a-distracted-world/))
    *Agent Summary:* Popular-press synthesis of the attention-residue and context-switching literature. The accessible read; pair with Mark et al. for the empirical claim.

### Linguistic hedging and self-signals

*Used by:* core rule 4 (LLM-polish patterns to replace); review-mode pattern 2 (Self-signals).

11. **Lakoff, G. (1973). "Hedges: A Study in Meaning Criteria and the Logic of Fuzzy Concepts." *Journal of Philosophical Logic*, 2(4), 458–508.** ([doi.org/10.1007/BF00262952](https://doi.org/10.1007/BF00262952))
    *Agent Summary:* The foundational paper coining "hedges" as a linguistic-semantic category. Establishes hedging as a real, analyzable phenomenon, not a stylistic accident.

12. **Hyland, K. (1998). *Hedging in Scientific Research Articles*. John Benjamins Publishing.** ([benjamins.com](https://benjamins.com/catalog/pbns.54))
    *Agent Summary:* Treats hedging as an interpersonal/social strategy intimately tied to community practice, not just epistemic uncertainty. The research basis for reading "softening emoji on edgy content" as a self-signal: the writer is doing social work the substance didn't need.

13. **Brown & Levinson (1987).** Already cited under "Politeness, face, and deferential framing"; their negative-politeness markers cover the softening-as-deference angle directly.

### AI tells and authentic voice

*Used by:* core rule 4 ("Sound like the user, not an LLM"); review-mode pattern 4 (AI-tells & performative polish).

14. **Juzek, T. S., & Ward, Z. B. (2025). "Why Does ChatGPT 'Delve' So Much? Exploring the Sources of Lexical Overrepresentation in Large Language Models." *COLING 2025*, 6397–6411.** ([aclanthology.org/2025.coling-main.426](https://aclanthology.org/2025.coling-main.426/))
    *Agent Summary:* Identifies 21 specific words ("delve", "intricate", "underscore") significantly overrepresented in LLM output and traces RLHF as the likely mechanism. The peer-reviewed evidence behind the AI-tells category.

15. **Gehrmann, S., Strobelt, H., & Rush, A. M. (2019). "GLTR: Statistical Detection and Visualization of Generated Text." *ACL 2019 System Demonstrations*, 111–116.** ([aclanthology.org/P19-3019](https://aclanthology.org/P19-3019/))
    *Agent Summary:* Statistical features (token rank, top-k entropy) reliably distinguish human and machine-generated text, raising human detection from 54% to 72%. AI tells aren't just vibes; they're measurable.

16. **Mitchell, E., Lee, Y., Khazatsky, A., Manning, C. D., & Finn, C. (2023). "DetectGPT: Zero-Shot Machine-Generated Text Detection using Probability Curvature." *ICML 2023*, PMLR 202:24950–24962.** ([proceedings.mlr.press/v202/mitchell23a](https://proceedings.mlr.press/v202/mitchell23a.html))
    *Agent Summary:* Zero-shot detection method using probability curvature. Supports the broader claim that LLM output has stylistic regularities a reader can detect without training a custom model.

17. **Crothers, E., Japkowicz, N., & Viktor, H. L. (2023). "Machine-Generated Text: A Comprehensive Survey of Threat Models and Detection Methods." *IEEE Access*, 11, 70977–71002.** ([doi.org/10.1109/ACCESS.2023.3294090](https://doi.org/10.1109/ACCESS.2023.3294090))
    *Agent Summary:* Survey of the detection literature covering both threat models and methods. The map of the field for a reader who wants to go deeper.

### Psychological safety and receiving feedback

*Used by:* The YES CHEF stance (especially "even when the user has the technical high ground"); core rule 6 (Trust the recipient as the domain expert); review-mode pattern 1 (Tone risk).

18. **Edmondson, A. C. (1999). "Psychological Safety and Learning Behavior in Work Teams." *Administrative Science Quarterly*, 44(2), 350–383.** ([doi.org/10.2307/2666999](https://doi.org/10.2307/2666999))
    *Agent Summary:* The foundational paper introducing team psychological safety as a shared belief that the team is safe for interpersonal risk-taking. The skill's bias toward inviting questions over dropping notifications traces here.

19. **Edmondson, A. C. (2018). *The Fearless Organization: Creating Psychological Safety in the Workplace for Learning, Innovation, and Growth*. Wiley.** ([wiley.com](https://www.wiley.com/en-us/The+Fearless+Organization%3A+Creating+Psychological+Safety+in+the+Workplace+for+Learning%2C+Innovation%2C+and+Growth-p-9781119477266))
    *Agent Summary:* Practitioner synthesis of the 1999 construct. The accessible read for the same idea, with concrete organizational applications.

20. **Dweck, C. S. (2006). *Mindset: The New Psychology of Success*. Random House.** ([books.google.com/Mindset](https://books.google.com/books/about/Mindset.html?id=fdjqz0TPL2wC))
    *Agent Summary:* Fixed-vs-growth-mindset framework. Why "treating their observation as valid on its face" matters: the alternative ("classify your bug report") triggers a fixed-mindset defense rather than learning.

21. **Argyris, C. (1991). "Teaching Smart People How to Learn." *Harvard Business Review*, 69(3), 99–109.** ([hbr.org](https://hbr.org/1991/05/teaching-smart-people-how-to-learn))
    *Agent Summary:* Defensive reasoning as the obstacle to learning, particularly in high-status professionals. Why the skill's no-"well actually" rule matters most exactly when the user has the technical high ground.

## Install

Install the `together` plugin from the official Claude Code marketplace:

```
/plugin install together
```

## Customize for your voice

The principles in `SKILL.md` (AMP, YES CHEF, channel-fit, no AI tells) are universal. The user-specific layer is the **openers and softeners** vocabulary. The example phrases ("quick question on…", "wanted your input on…", "any direction here?") work for one collaborative voice. Edit them in place to match the phrases you actually use, or keep the examples as exemplars and let the agent learn over time.

You can also keep your personal-tone notes in a separate file (e.g., your agent's global instructions or a memory system) that the skill can reference.

## Shape the skill as you use it

The skill expects feedback on its drafts. If a draft sounds wrong, name what's off:

- "more deferential"
- "drop the bullets"
- "swap that opener for something more inviting"
- "add a typo, this reads too clean"
- "wrong channel, this would be better as a Jira comment"

The agent adopts the change immediately. Over time, your patterns become its defaults.

## Where to reach for other tools

This skill is built for collaborative communication. A few contexts call for different conventions: adversarial communication, formal/legal correspondence, and content where you're the published author (PR descriptions, public docs, blog posts) each have their own playbooks.

## Contribute

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for how to suggest improvements.
