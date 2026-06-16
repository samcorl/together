#!/usr/bin/env bash
# Content tests for the comms skill
# Verifies the skill is loaded and the agent understands its requirements
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: comms skill — content ==="
echo ""

# Test 1: Skill exists and describes two modes
echo "Test 1: Two modes described..."
output=$(run_claude "What are the two modes of the comms skill? Describe each briefly." 45)
assert_contains "$output" "draft" "Draft mode mentioned"
assert_contains "$output" "review" "Review mode mentioned"
echo ""

# Test 2: Draft mode trigger phrases
echo "Test 2: Draft mode trigger recognition..."
output=$(run_claude "Does the comms skill fire when a user says 'help me respond to this Jira comment'? Which mode?" 45)
assert_contains "$output" "draft" "Identifies draft mode trigger"
echo ""

# Test 3: Review mode trigger phrases
echo "Test 3: Review mode trigger recognition..."
output=$(run_claude "Does the comms skill fire when a user says 'review my comms this week'? Which mode?" 45)
assert_contains "$output" "review" "Identifies review mode trigger"
echo ""

# Test 4: AMP principle
echo "Test 4: AMP principle known..."
output=$(run_claude "What does AMP stand for in the comms skill and how does it guide drafts?" 45)
assert_contains "$output" "Autonomy" "AMP — Autonomy"
assert_contains "$output" "Mastery" "AMP — Mastery"
assert_contains "$output" "Purpose" "AMP — Purpose"
echo ""

# Test 5: YES CHEF stance
echo "Test 5: YES CHEF stance known..."
output=$(run_claude "What is the YES CHEF stance in the comms skill?" 45)
assert_contains "$output" "deferential\|defer\|chef\|cook" "YES CHEF means deferential"
assert_contains "$output" "defensive\|not defensive\|no defensiveness" "YES CHEF means no defensiveness"
echo ""

# Test 6: Please rule (core rule 2)
echo "Test 6: Please rule understood..."
output=$(run_claude "In the comms skill, what should a draft include when asking someone for their time, attention, or effort?" 45)
assert_contains "$output" "please\|if you.re willing\|when you have a moment\|acknowledge" "Please rule"
echo ""

# Test 7: Attention ask rule (core rule 3)
echo "Test 7: Attention ask rule understood..."
output=$(run_claude "In the comms skill, what does 'minimize the attention ask' mean?" 45)
assert_contains "$output" "short\|brief\|concise\|fewer words\|cut" "Keep it short"
assert_contains "$output" "time\|finite\|attention" "Respects recipient time"
echo ""

# Test 8: Channel fit check fires before drafting
echo "Test 8: Channel fit check before drafting..."
output=$(run_claude "In the comms skill draft process, list the steps in order. Does the channel fit check happen before or after drafting the message?" 45)
assert_contains "$output" "before\|prior\|first.*channel\|channel.*first\|step.*2.*channel\|channel.*step.*2\|channel.*then.*draft\|check.*before.*draft" "Channel check before drafting"
echo ""

# Test 9: ai-scrubber invoked after drafting
echo "Test 9: ai-scrubber post-processing step..."
output=$(run_claude "In the comms skill draft process, what happens after the message is drafted and before it is handed back to the user?" 45)
assert_contains "$output" "ai-scrubber\|scrubber\|scrub\|post-process" "ai-scrubber step mentioned"
echo ""

# Test 10: Review mode flags four categories
echo "Test 10: Four review categories..."
output=$(run_claude "What four categories does comms review mode flag? Name and describe each." 60)
assert_contains "$output" "tone risk\|tone-risk\|⚠️" "Tone risk category"
assert_contains "$output" "self-signal\|self signal\|🪞" "Self-signal category"
assert_contains "$output" "channel fit\|channel-fit\|🧭" "Channel fit category"
assert_contains "$output" "ai.tell\|AI tell\|🤖" "AI-tells category"
echo ""

# Test 11: Missing please flagged in review
echo "Test 11: Missing please flagged as tone risk in review..."
output=$(run_claude "In comms review mode, is a message that asks someone to do something without saying 'please' or acknowledging the ask flagged? Under which category?" 45)
assert_contains "$output" "tone risk\|tone-risk\|⚠️" "Missing please is tone risk"
echo ""

# Test 12: Long message flagged as self-signal in review
echo "Test 12: Unnecessarily long message flagged in review..."
output=$(run_claude "In comms review mode, if a message is longer than its substance requires, is that flagged? Under which category?" 45)
assert_contains "$output" "self-signal\|self signal\|🪞\|attention" "Length is a self-signal"
echo ""

echo "=== All comms content tests passed ==="
