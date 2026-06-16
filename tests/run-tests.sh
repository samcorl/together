#!/usr/bin/env bash
# Test runner for together plugin skills
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "========================================"
echo " together — Skills Test Suite"
echo "========================================"
echo ""
echo "Repository: $(cd .. && pwd)"
echo "Test time: $(date)"
echo "Claude version: $(claude --version 2>/dev/null || echo 'not found')"
echo ""

if ! command -v claude &> /dev/null; then
    echo "ERROR: Claude Code CLI not found"
    exit 1
fi

VERBOSE=false
SPECIFIC_TEST=""
TIMEOUT=300
RUN_INTEGRATION=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --verbose|-v)
            VERBOSE=true
            shift
            ;;
        --test|-t)
            SPECIFIC_TEST="$2"
            shift 2
            ;;
        --timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        --integration|-i)
            RUN_INTEGRATION=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [options]"
            echo ""
            echo "Options:"
            echo "  --verbose, -v        Show verbose output"
            echo "  --test, -t NAME      Run only the specified test file"
            echo "  --timeout SECONDS    Set timeout per test (default: 300)"
            echo "  --integration, -i    Run integration tests (slow, 5-20 min)"
            echo "  --help, -h           Show this help"
            echo ""
            echo "Content tests (fast, ~2 min each):"
            echo "  test-comms.sh              comms skill requirements"
            echo "  test-ai-scrubber.sh        ai-scrubber skill requirements"
            echo ""
            echo "Integration tests (use --integration, ~5-15 min each):"
            echo "  test-comms-integration.sh          comms draft and review behavior"
            echo "  test-ai-scrubber-integration.sh    scrubbing behavior on seeded inputs"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

# Fast content tests
tests=(
    "test-comms.sh"
    "test-ai-scrubber.sh"
)

# Integration tests
integration_tests=(
    "test-comms-integration.sh"
    "test-ai-scrubber-integration.sh"
)

if [ "$RUN_INTEGRATION" = true ]; then
    tests+=("${integration_tests[@]}")
fi

if [ -n "$SPECIFIC_TEST" ]; then
    tests=("$SPECIFIC_TEST")
fi

passed=0
failed=0
skipped=0

for test in "${tests[@]}"; do
    echo "----------------------------------------"
    echo "Running: $test"
    echo "----------------------------------------"

    test_path="$SCRIPT_DIR/$test"

    if [ ! -f "$test_path" ]; then
        echo "  [SKIP] Test file not found: $test"
        skipped=$((skipped + 1))
        continue
    fi

    chmod +x "$test_path"

    start_time=$(date +%s)

    if [ "$VERBOSE" = true ]; then
        if timeout "$TIMEOUT" bash "$test_path"; then
            end_time=$(date +%s)
            echo ""
            echo "  [PASS] $test ($((end_time - start_time))s)"
            passed=$((passed + 1))
        else
            exit_code=$?
            end_time=$(date +%s)
            echo ""
            if [ $exit_code -eq 124 ]; then
                echo "  [FAIL] $test (timeout after ${TIMEOUT}s)"
            else
                echo "  [FAIL] $test ($((end_time - start_time))s)"
            fi
            failed=$((failed + 1))
        fi
    else
        if output=$(timeout "$TIMEOUT" bash "$test_path" 2>&1); then
            end_time=$(date +%s)
            echo "$output"
            echo ""
            echo "  [PASS] ($((end_time - start_time))s)"
            passed=$((passed + 1))
        else
            exit_code=$?
            end_time=$(date +%s)
            if [ $exit_code -eq 124 ]; then
                echo "  [FAIL] (timeout after ${TIMEOUT}s)"
            else
                echo "  [FAIL] ($((end_time - start_time))s)"
            fi
            echo ""
            echo "$output"
            failed=$((failed + 1))
        fi
    fi

    echo ""
done

echo "========================================"
echo " Test Results Summary"
echo "========================================"
echo ""
echo "  Passed:  $passed"
echo "  Failed:  $failed"
echo "  Skipped: $skipped"
echo ""

if [ "$RUN_INTEGRATION" = false ]; then
    echo "Note: Integration tests not run. Use --integration to run full behavioral tests."
    echo ""
fi

if [ $failed -gt 0 ]; then
    echo "STATUS: FAILED"
    exit 1
else
    echo "STATUS: PASSED"
    exit 0
fi
