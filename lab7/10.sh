#!/bin/bash

LOG_FILE="./ram_usage.log"

DURATION=10
INTERVAL=60

log_ram_usage() {
  MEM_INFO=$(free -m | awk '/^Mem:/ {print $2, $3, $4}')
  TOTAL_RAM=$(echo "$MEM_INFO" | awk '{print $1}')
  USED_RAM=$(echo "$MEM_INFO" | awk '{print $2}')
  FREE_RAM=$(echo "$MEM_INFO" | awk '{print $3}')

  PERCENT_USED=$(( USED_RAM * 100 / TOTAL_RAM ))

  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
  echo "$TIMESTAMP - Total: ${TOTAL_RAM}MB, Used: ${USED_RAM}MB, Free: ${FREE_RAM}MB, Usage: ${PERCENT_USED}%" >> "$LOG_FILE"

  if [ $PERCENT_USED -gt 50 ]; then
    echo "Alert: Memory usage is at ${PERCENT_USED}%!" >> "$LOG_FILE"
  fi
}

echo "Starting RAM usage monitoring for $DURATION minutes..."
for ((i = 1; i <= DURATION; i++)); do
  log_ram_usage
  sleep "$INTERVAL"
done

echo "RAM usage monitoring complete. Logs saved to $LOG_FILE."