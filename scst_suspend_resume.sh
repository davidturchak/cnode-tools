#!/bin/bash

# Function to monitor /var/log/messages for the specific string
monitor_log() {
        tail -Fn0 /var/log/messages | while read LINE; do
        if echo "$LINE" | grep -q "All active commands completed"; then
            echo "All active commands completed"
            break
        fi
    done
}

# Enable maintenance mode
echo 1 > /sys/kernel/scst_tgt/maintenance_mode

# Start monitoring the log in the background
monitor_log

# Exit maintenance mode
echo 0 > /sys/kernel/scst_tgt/maintenance_mode
