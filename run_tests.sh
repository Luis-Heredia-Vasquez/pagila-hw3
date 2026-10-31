#!/bin/bash

failed=false

mkdir -p results

if command -v docker >/dev/null 2>&1; then
    PSQL_CMD=(docker compose exec -T pg psql -v ON_ERROR_STOP=1)
else
    PSQL_CMD=(psql -v ON_ERROR_STOP=1)
fi

for problem in sql/*; do
    printf '%s ' "$problem"

    problem_id=$(basename "${problem%.sql}")
    result="results/$problem_id.out"
    expected="expected/$problem_id.out"
    error_file="results/$problem_id.err"

    if ! "${PSQL_CMD[@]}" < "$problem" > "$result" 2> "$error_file"; then
        echo fail
        cat "$error_file"
        failed=true
        continue
    fi

    DIFF=$(diff -u -B "$expected" "$result")

    if [ -z "$DIFF" ]; then
        echo pass
    else
        echo fail
        printf '%s\n' "$DIFF"
        failed=true
    fi
done

if [ "$failed" = "true" ]; then
    exit 2
fi
