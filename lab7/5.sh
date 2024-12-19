#!/bin/bash

#./5.sh service1 service2 service3

# Define the log file
LOG_FILE="service_status.log"

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "No service names provided."
    exit 1
fi

# Function to check if a service is running
check_service() {
    service=$1
    # Check if the service is running using launchctl
    if launchctl list | grep -q "$service"; then
        echo "$(date): Service '$service' is running." >> "$LOG_FILE"
    else
        echo "$(date): Service '$service' is not running. Attempting to restart." >> "$LOG_FILE"
        restart_service "$service"
    fi
}

# Function to restart a service
restart_service() {
    service=$1
    # Restart the service using launchctl
    if sudo launchctl bootout system /System/Library/LaunchDaemons/$service.plist; then
        sudo launchctl bootload system /System/Library/LaunchDaemons/$service.plist
        echo "$(date): Service '$service' restarted successfully." >> "$LOG_FILE"
    else
        echo "$(date): Failed to restart service '$service'." >> "$LOG_FILE"
    fi
}

# Loop through all arguments (services)
for service in "$@"; do
    check_service "$service"
done
