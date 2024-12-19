#!/bin/bash

# example ./7.sh
targets_file="./targets.txt"

if [ ! -f "$targets_file" ]; then
    echo "Targets file not found: $targets_file"
    exit 1
fi

while IFS= read -r HOST; do
    if [ -n "$HOST" ]; then
        ping -c1 "$HOST" 1>/dev/null 2>/dev/null
        SUCCESS=$?

        if [ $SUCCESS -eq 0 ]; then
            echo "$HOST has replied"
            echo "$(date -u) $HOST has replied" >> ./ping_results.log
        else
            echo "$HOST didn't reply"
            echo "$(date -u) $HOST didn't reply" >> ./ping_results.log
        fi
    fi
done < "$targets_file"

echo "Ping results have been logged to ./ping_results.log"