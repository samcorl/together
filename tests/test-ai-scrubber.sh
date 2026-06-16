#!/usr/bin/env bash
# Content tests for the ai-scrubber skill
# Verifies the skill is loaded and the agent understands its requirements
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: ai-scrubber skill — content ==="
echo ""

# Test 1: Skill recognized and describes its purpose
echo "Test 1: Skill recognized..."
output=$(run_claude "What does the ai-scrubber skill do?" 45)
assert_contains "$output" "training artifact\|LLM\|AI.generated\|AI.assisted" "Describes training artifact problem"
assert_contains "$output" "em.dash\|en.dash\|em dash\|en dash" "Mentions em/en dashes"
echo ""

# Test 2: Three target patterns identified
echo "Test 2: Three patterns known..."
output=$(run_claude "What three patterns does the ai-scrubber skill remove? List them." 45)
assert_contains "$output" "em.dash\|en.dash\|—\|–" "Pattern 1: dashes"
assert_contains "$output" "list\|bullet\|- X\|casual" "Pattern 2: list syntax"
assert_contains "$output" "quip\|flourish\|sentence.ending\|tacked on" "Pattern 3: sentence-ending quips"
echo ""

# Test 3: Haiku subagent mentioned
echo "Test 3: Haiku subagent used for processing..."
output=$(run_claude "How does the ai-scrubber skill process text? What model does it use?" 45)
assert_contains "$output" "Haiku\|subagent\|haiku" "Haiku subagent mentioned"
echo ""

# Test 4: Returns only corrected text — no commentary
echo "Test 4: Output is corrected text only, no commentary..."
output=$(run_claude "In the ai-scrubber skill, does the subagent return a summary of changes along with the corrected text, or just the corrected text?" 45)
assert_contains "$output" "only\|just the\|no commentary\|no explanation\|no summary" "Returns text only"
echo ""

# Test 5: Casual vs formal context distinction
echo "Test 5: Casual vs formal distinction for list syntax..."
output=$(run_claude "In the ai-scrubber skill, does it always convert bullet lists to prose, or does it preserve some lists?" 45)
assert_contains "$output" "formal\|preserve\|keep\|leave.*alone\|Jira\|GitHub\|enumerated" "Formal lists preserved"
assert_contains "$output" "casual\|Slack\|chat\|convert\|prose" "Casual lists converted"
echo ""

# Test 6: Invocable standalone
echo "Test 6: Can be invoked standalone..."
output=$(run_claude "Can a user invoke the ai-scrubber skill directly, or only through other skills?" 45)
assert_contains "$output" "standalone\|directly\|scrub this\|user can\|yes" "Standalone invocation supported"
echo ""

# Test 7: Invoked by comms
echo "Test 7: comms skill invokes ai-scrubber..."
output=$(run_claude "Does the comms skill automatically use the ai-scrubber skill? When?" 45)
assert_contains "$output" "after draft\|post.process\|before handing back\|step 5\|automatically" "comms invokes scrubber after drafting"
echo ""

# Test 8: Self-policing doesn't work — that's why scrubber exists
echo "Test 8: Explains why self-policing fails..."
output=$(run_claude "Why does the ai-scrubber skill use a separate Haiku subagent instead of just telling the drafting agent to avoid em-dashes?" 45)
assert_contains "$output" "training\|baked in\|can.t avoid\|regardless\|despite\|self.polic\|learned prior\|slip through\|reliably stick\|don.t reliably\|instruction.*miss" "Explains training artifact problem"
echo ""

echo "=== All ai-scrubber content tests passed ==="
