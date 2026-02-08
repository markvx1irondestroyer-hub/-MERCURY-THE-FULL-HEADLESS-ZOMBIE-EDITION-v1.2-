#!/bin/bash
# 🧟 MERCURY: Status Check

echo "--- 📦 STORAGE ---"
# Added 'Mounted' to the grep so you can see where they are
df -h | grep -E 'Filesystem|DVD_Storage|Expansion|Mounted'

echo ""
echo "--- 🏎️ GPU (Name, Temp, Load) ---"
nvidia-smi --query-gpu=name,temperature.gpu,utilization.gpu --format=csv,noheader

echo ""
echo "--- 🧬 DOCKER STACK ---"
# Using sudo here ensures the 'm status' alias never fails
sudo docker ps --format "table {{.Names}}\t{{.Status}}"
