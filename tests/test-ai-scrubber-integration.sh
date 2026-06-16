#!/usr/bin/env bash
# Integration tests for the ai-scrubber skill
# Verifies actual scrubbing behavior against seeded inputs
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/test-helpers.sh"

echo "=== Test: ai-scrubber skill — integration ==="
echo ""

# ── EM-DASH AND EN-DASH REMOVAL ───────────────────────────────────────────────

# Test 1: Em-dash replaced
echo "Test 1: Em-dashes removed from casual message..."
output=$(run_claude "Scrub this Slack message: 'I looked at the PR — there are a few issues — the main one is the auth flow — it breaks on mobile.'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "—" "No em-dashes in scrubbed text"
assert_contains "$draft" "auth flow\|auth\|mobile" "Substance preserved"
echo ""

# Test 2: En-dash replaced
echo "Test 2: En-dashes removed..."
output=$(run_claude "Scrub this: 'The review window is Monday–Wednesday and we need 3–5 approvals before we can ship.'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "–" "No en-dashes in scrubbed text"
assert_contains "$draft" "Monday\|Wednesday\|approvals\|ship" "Substance preserved"
echo ""

# Test 3: Mixed em and en dashes both removed
echo "Test 3: Mixed em-dashes and en-dashes both removed..."
output=$(run_claude "Scrub this: 'The deploy window is 2pm–4pm — after that the team is unavailable — please plan accordingly.'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "—\|–" "No dashes in scrubbed text"
echo ""

# ── LIST SYNTAX CONVERSION ────────────────────────────────────────────────────

# Test 4: Casual list syntax converted to prose
echo "Test 4: Casual list syntax (Slack) converted to prose..."
output=$(run_claude "Scrub this Slack message: 'deploy update: - build passed - tests passed - staging is green - prod deploy at 3pm - no action needed'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" " - build\| - tests\| - staging\| - prod\| - no" "List items converted to prose"
assert_contains "$draft" "staging\|prod\|3pm\|green" "Substance preserved"
echo ""

# Test 5: Formal bullet list preserved
echo "Test 5: Formal enumerated list in Jira comment preserved..."
output=$(run_claude "Scrub this Jira comment: 'Steps to reproduce:\n- Navigate to the login page\n- Enter invalid credentials\n- Click Submit\n- Observe the error message displayed'" 90)
assert_contains "$output" "Navigate\|login\|Submit\|error" "Formal list content preserved"
echo ""

# Test 6: List in email body with context marker
echo "Test 6: Casual inline list in email body converted..."
output=$(run_claude "Scrub this casual email reply: 'sounds good - I can cover Tuesday - let me know if time changes - happy to adjust'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" " - I can\| - let me\| - happy" "Inline list items converted to prose"
assert_contains "$draft" "Tuesday\|time\|adjust" "Substance preserved"
echo ""

# ── SENTENCE-ENDING QUIP REMOVAL ─────────────────────────────────────────────

# Test 7: Unnecessary quip removed
echo "Test 7: Sentence-ending quip removed..."
output=$(run_claude "Scrub this: 'I reviewed the PR. Looks good overall, which is great news for the team. Let me know if you want a second pass.'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "which is great news for the team\|great news for the team" "Quip removed"
assert_contains "$draft" "reviewed\|PR\|second pass\|let me know" "Substance preserved"
echo ""

# Test 8: Quip at end of message removed
echo "Test 8: Trailing quip removed..."
output=$(run_claude "Scrub this: 'Deploy is done. Staging looks healthy. All good on our end!'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "All good on our end\|all good on our end" "Trailing quip removed"
assert_contains "$draft" "Deploy\|Staging\|done\|healthy" "Substance preserved"
echo ""

# Test 9: Informative ending preserved (not a quip)
echo "Test 9: Meaningful sentence ending preserved..."
output=$(run_claude "Scrub this: 'The fix is live. If you see errors after this deploy, ping me directly — I will be on call until midnight.'" 90)
draft=$(extract_draft "$output")
assert_contains "$draft" "midnight\|on call\|ping" "Meaningful ending preserved"
echo ""

# ── MIXED PATTERNS ────────────────────────────────────────────────────────────

# Test 10: All three patterns removed in one pass
echo "Test 10: Mixed — em-dash, list syntax, and quip all removed..."
output=$(run_claude "Scrub this Slack message: 'deploy update — build passed - tests passed - staging is green - prod is next, which is exciting for everyone'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "—" "Em-dash removed"
assert_not_contains "$draft" " - [a-z]" "List syntax removed"
assert_not_contains "$draft" "which is exciting for everyone\|exciting for everyone" "Quip removed"
assert_contains "$draft" "staging\|green\|prod\|build" "Substance preserved"
echo ""

# Test 11: Message with em-dash and quip but no list syntax
echo "Test 11: Em-dash and quip removed, no list to convert..."
output=$(run_claude "Scrub this: 'I flagged this in the PR — the reviewer agreed — good catch on my end.'" 90)
draft=$(extract_draft "$output")
assert_not_contains "$draft" "—" "Em-dash removed"
assert_not_contains "$draft" "good catch on my end\|good catch" "Quip removed"
assert_contains "$draft" "PR\|reviewer\|agreed\|flagged" "Substance preserved"
echo ""

# ── CLEAN TEXT ────────────────────────────────────────────────────────────────

# Test 12: Already-clean text returns essentially unchanged
echo "Test 12: Clean text passes through without meaningful change..."
output=$(run_claude "Scrub this: 'the deploy is done. staging looks good. let me know when you want to push to prod.'" 90)
assert_contains "$output" "deploy\|staging\|prod" "Core content preserved"
assert_not_contains "$output" "I changed\|I removed\|I replaced\|Here is\|Here's the" "No commentary in output"
echo ""

# Test 13: No commentary in output regardless of changes made
echo "Test 13: Output is text only — no explanation of changes..."
output=$(run_claude "Scrub this: 'good news — the fix is in — everything is green — ship it'" 90)
# The output should not include meta-commentary about what was changed
draft=$(extract_draft "$output")
assert_not_contains "$draft" "I replaced\|I removed\|I changed\|I converted\|Here is the\|Here.s the corrected\|Changes made\|replaced\|Both.*dash\|dash.*replaced" "No meta-commentary in scrubbed text"
echo ""

echo "=== All ai-scrubber integration tests passed ==="
