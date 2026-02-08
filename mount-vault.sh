#!/bin/bash
# 🧟 MERCURY: OPTIONAL VAULT MOUNTER

echo "🔍 Searching for External Drive UUID..."
# Filtered to show only things with UUIDs to make it easier to read
lsblk -f | grep -v "loop"

echo ""
echo "⚠️ Copy the UUID for your Expansion drive (e.g., 1234-ABCD)."
read -p "Enter the UUID: " UUID

# THE FIX: Ensure the mount point actually exists
sudo mkdir -p /media/linux/Expansion
sudo chown -R $USER:$USER /media/linux/Expansion

# Backup fstab
sudo cp /etc/fstab /etc/fstab.bak

# THE FIX: Optimized Mount Options
# 'defaults' is safer, 'nofail' prevents boot hangs if drive is unplugged
echo "UUID=$UUID /media/linux/Expansion auto defaults,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab

echo "🚀 Attempting to mount..."
sudo mount -a

# Final Check
if mountpoint -q /media/linux/Expansion; then
    echo "✅ Expansion Drive integrated as internal storage."
else
    echo "❌ ERROR: Drive failed to mount. Check your UUID and try again."
fi
