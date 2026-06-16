#!/usr/bin/env bash
# Integration tests for the comms skill
# Verifies actual draft behavior across real-world scenarios
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: comms skill — integration ==="
echo ""

# ── DRAFT MODE SCENARIOS ──────────────────────────────────────────────────────

# Test 1: Wrong channel — Slack post about a Jira story
# The skill should push back on the channel before drafting
echo "Test 1: Wrong channel — Slack about a Jira ticket..."
output=$(run_claude "Draft a Slack message to #engineering asking whether the authentication bug fix in JIRA-789 has been deployed to staging." 90)
assert_contains "$output" "Jira\|ticket\|story comment\|comment on" "Suggests Jira over Slack"
assert_contains "$output" "JIRA-789\|ticket\|story" "References the specific ticket"
echo ""

# Test 2: Wrong channel — Slack post when only one person can answer
echo "Test 2: Wrong channel — group Slack when a DM is better..."
output=$(run_claude "Draft a Slack message to #team-backend asking Maya specifically to review my authentication PR before her 3pm meeting." 90)
assert_contains "$output" "DM\|direct message\|@Maya\|narrow" "Suggests DM or direct @-tag"
echo ""

# Test 3: Draft includes acknowledgment of ask (please rule)
echo "Test 3: Draft includes please when requesting effort..."
output=$(run_claude "Draft a Slack DM to Jordan asking him to review my pull request before end of day." 90)
assert_contains "$output" "please\|if you.re willing\|when you have a moment\|no rush\|if you have time" "Draft acknowledges the ask"
echo ""

# Test 4: Draft stays short (attention ask rule)
echo "Test 4: Reschedule request stays brief..."
output=$(run_claude "Draft a Slack DM to my manager asking to move our 1:1 from Tuesday to Wednesday this week." 90)
# Extract just the quoted draft block (between > markers) if present; otherwise use full output
draft=$(echo "$output" | grep "^>" | sed 's/^> *//' || echo "$output")
wc=$(echo "$draft" | wc -w | tr -d ' ')
if [ "$wc" -lt 80 ]; then
    echo "  [PASS] Draft is appropriately short ($wc words)"
else
    echo "  [WARN] Draft may be longer than needed ($wc words — expected under 80)"
fi
echo ""

# Test 5: Draft doesn't lecture — scope pushback scenario
echo "Test 5: Scope pushback — no lecturing, deferential..."
output=$(run_claude "My PM just added three new requirements to a ticket I told her was almost done. I disagree but want to stay collaborative. Draft a Jira comment pushing back gently." 90)
assert_not_contains "$output" "well actually\|the way this works\|as I mentioned\|to be clear" "No lecturing phrases"
assert_contains "$output" "please\|your call\|let me know\|happy to\|if you.re willing\|your direction" "Deferential framing"
echo ""

# Test 6: Draft ends on the recipient's action
echo "Test 6: Draft ends on recipient's action, not the user's reasoning..."
output=$(run_claude "Draft a reply to a PR reviewer who left a comment saying my approach is overly complex. I think the complexity is justified but want to invite further discussion." 90)
assert_contains "$output" "let me know\|your call\|happy to\|thoughts\|what do you think\|any direction" "Ends on recipient's action"
echo ""

# Test 7: Mixed context — ambiguous draft vs review trigger
echo "Test 7: Ambiguous trigger handled gracefully..."
output=$(run_claude "comms — I want to look at how I responded to that PR thread yesterday." 60)
assert_contains "$output" "review\|retrospective\|look back\|draft\|which mode\|clarif" "Handles ambiguity — asks or picks a mode"
echo ""

# Test 8: Draft in correct channel — Slack DM, no channel objection
echo "Test 8: Correct channel — no channel pushback when channel is right..."
output=$(run_claude "Draft a Slack DM to my teammate Priya saying I'll be 10 minutes late to our pairing session." 90)
assert_not_contains "$output" "suggest\|recommend.*channel\|better suited\|Jira\|GitHub" "No channel objection for appropriate Slack DM"
assert_contains "$output" "late\|10 minutes\|pairing\|session" "Draft addresses the substance"
echo ""

# Test 9: Draft doesn't include AI tells after scrubbing
echo "Test 9: Final draft contains no em-dashes..."
output=$(run_claude "Draft a Slack message to #product thanking the design team for their fast turnaround on the new onboarding mockups. Keep it warm and genuine." 90)
assert_not_contains "$output" "—" "No em-dashes in final draft"
echo ""

# ── REVIEW MODE SCENARIOS ─────────────────────────────────────────────────────

# Test 10: Review mode setup dialog fires
echo "Test 10: Review mode runs setup dialog before collecting data..."
output=$(run_claude "Review my comms from today." 60)
assert_contains "$output" "Sources\|sources\|Slack\|scope\|depth\|window" "Setup dialog runs first"
echo ""

# Test 11: Review mode identifies directive to peer as tone risk
echo "Test 11: Tone risk — directive to peer flagged..."
output=$(run_claude "In comms review mode, analyze this message for patterns: 'next time can we please loop in QA before merging to main'" 90)
assert_contains "$output" "tone\|directive\|⚠️\|next time" "Directive to peer flagged as tone risk"
echo ""

# Test 12: Review mode identifies missing please as tone risk
echo "Test 12: Tone risk — missing acknowledgment of ask flagged..."
output=$(run_claude "In comms review mode, analyze this message for patterns: 'Can you take a look at this PR and approve it today'" 90)
assert_contains "$output" "tone\|please\|acknowledge\|ask\|⚠️\|autonomy" "Missing please flagged as tone risk"
echo ""

# Test 13: Review mode identifies em-dash as AI-tell
echo "Test 13: AI-tell — em-dash in sent message flagged..."
output=$(run_claude "In comms review mode, analyze this message for patterns: 'I looked at the deploy — everything seems fine — staging is green — ready for prod'" 90)
assert_contains "$output" "em.dash\|AI.tell\|🤖\|training artifact\|LLM" "Em-dash flagged as AI-tell"
echo ""

# Test 14: Review mode identifies long message as self-signal
echo "Test 14: Self-signal — unnecessarily long message flagged..."
output=$(run_claude "In comms review mode, analyze this message for patterns: 'Hey, I just wanted to reach out to let you know that I had a chance to take a look at the ticket you mentioned in our last sync, and I wanted to make sure we were aligned on the approach before I started any actual implementation work on it, since I know these things can sometimes go in a different direction than initially expected.'" 90)
assert_contains "$output" "self.signal\|long\|shorter\|attention\|🪞" "Long message flagged as self-signal"
echo ""

# Test 15: Review mode recognizes a win
echo "Test 15: Review mode recognizes clean accountability as a win..."
output=$(run_claude "In comms review mode, analyze this message for patterns: 'yeah you were right, that was the wrong call. fixing it now.'" 90)
assert_contains "$output" "win\|🟢\|well.applied\|accountability\|clean\|good" "Clean accountability recognized as win"
echo ""

echo "=== All comms integration tests passed ==="
