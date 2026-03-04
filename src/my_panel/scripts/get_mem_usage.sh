#! /usr/bin/env bash

mem_total_kb=$(grep MemTotal /proc/meminfo | awk '{print $2}')
mem_free_kb=$(grep MemAvailable /proc/meminfo | awk '{print $2}')

mem_used_mb=$(( (mem_total_kb - mem_free_kb) / 1024 ))
# mem_used_gb=$(( (mem_total_kb - mem_free_kb) / 1024 / 1024 ))
mem_total_gb=$(( mem_total_kb / 1024 /1024 ))

# echo "${mem_used_gb}GB/${mem_total_gb}GB"
echo "${mem_used_mb}Mi/${mem_total_gb}Gi"

