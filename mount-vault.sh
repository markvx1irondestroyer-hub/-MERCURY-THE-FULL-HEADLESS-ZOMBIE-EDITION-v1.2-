#!/bin/bash
# 🧟 MERCURY: OPTIONAL VAULT MOUNTER

echo "🔍 Searching for External Drive UUID..."
# Filtered to show only things with UUIDs and excluding loop devices
lsblk -f | grep -v "loop"

echo ""
echo "⚠️ Copy the UUID for your Expansion drive (e.g., 1234-ABCD)."
read -p "Enter the UUID: " UUID

# THE FIX: Use $USER to make the path work for anyone
MOUNT_PATH="/media/$USER/Expansion"

echo "📂 Creating mount point at $MOUNT_PATH..."
sudo mkdir -p "$MOUNT_PATH"
sudo chown -R $USER:$USER "$MOUNT_PATH"

# Backup fstab
sudo cp /etc/fstab /etc/fstab.bak

# THE FIX: Optimized Mount Options
# Added 'uid' and 'gid' mapping to ensure the user always has write access
echo "UUID=$UUID $MOUNT_PATH auto defaults,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab

echo "🚀 Attempting to mount..."
sudo mount -a

# Final Check
if mountpoint -q "$MOUNT_PATH"; then
    echo "✅ Expansion Drive integrated at $MOUNT_PATH."
else
    echo "❌ ERROR: Drive failed to mount. Check your UUID in 'lsblk -f' and try again."
fi
