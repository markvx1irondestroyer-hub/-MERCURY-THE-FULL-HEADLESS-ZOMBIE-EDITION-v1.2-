#!/bin/bash
# 🧟 MERCURY: OPTIONAL VAULT MOUNTER
echo "🔍 Searching for External Drive UUID..."
lsblk -f
echo "⚠️ Copy the UUID for your Expansion drive."
read -p "Enter the UUID: " UUID
sudo cp /etc/fstab /etc/fstab.bak
echo "UUID=$UUID /media/linux/Expansion auto nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab
sudo mount -a
echo "✅ Expansion Drive integrated as internal storage."
