#!/bin/bash
echo "--- STORAGE ---"
df -h | grep -E 'Filesystem|DVD_Storage|Expansion'
echo ""
echo "--- GPU ---"
nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu --format=csv,noheader
echo ""
echo "--- DOCKER ---"
docker ps --format "table {{.Names}}\t{{.Status}}"
