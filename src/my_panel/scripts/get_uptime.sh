#! /usr/bin/env bash

# Uptime (int)
uptime_seconds=$(awk '{print int($1)}' /proc/uptime)

days=$(( uptime_seconds / 86400 ))
hours=$(( (uptime_seconds % 86400) / 3600 ))
minutes=$(( (uptime_seconds % 3600) / 60 ))
seconds=$(( uptime_seconds % 60 ))

if (( days > 0 )); then
    echo "${days}d ${hours}h"

elif (( hours > 0 )); then
    echo "${hours}h ${minutes}m"

elif (( minutes > 0 )); then
    echo "${minutes}m ${seconds}s"

else
    echo "${seconds}s"
fi

