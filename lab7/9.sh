#!/bin/bash

USER=${1:-$USER}

CRON_FAILURES_LOG="./cron_failures.log"

CRON_JOBS=$(crontab -l 2>/dev/null)
if [ $? -ne 0 ]; then
    echo "No crontab found for user $USER."
    exit 1
fi

echo "Listing active cron jobs for user: $USER"
echo "$CRON_JOBS"

echo "Checking system logs for the past 24 hours..."

LOG_ENTRIES=$(grep CRON /var/log/syslog | grep "$(date +"%b %e" -d "yesterday")")

if [ -z "$LOG_ENTRIES" ]; then
    echo "No cron activity found in the logs."
    exit 0
fi

echo "Found the following cron activities in the past 24 hours:"
echo "$LOG_ENTRIES"

echo "Checking for failures..."

FAILED_JOBS=$(echo "$LOG_ENTRIES" | grep -i "failed\|error")

if [ -n "$FAILED_JOBS" ]; then
    echo "The following cron jobs failed to execute in the past 24 hours:"
    echo "$FAILED_JOBS"
    echo "$FAILED_JOBS" > "$CRON_FAILURES_LOG"
    echo "Failures logged to $CRON_FAILURES_LOG"
else
    echo "No cron job failures found in the past 24 hours."
fi
