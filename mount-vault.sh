#!/bin/bash
# 🧟 MERCURY: OPTIONAL VAULT MOUNTER

echo "🔍 Searching for External Drives..."
lsblk -f

echo ""
echo "⚠️ IMPORTANT: Copy the UUID for your Expansion drive from the list above."
read -p "Enter the UUID: " UUID

# 1. Ensure the mount point exists
sudo mkdir -p /media/linux/Expansion
sudo chown -R 1000:1000 /media/linux/Expansion

# 2. Backup fstab before editing
sudo cp /etc/fstab /etc/fstab.bak

# 3. Add the 'Internal Trick' logic to fstab
# nofail = PC boots even if drive is unplugged
# x-gvfs-show = Shows up in file manager like a local drive
echo "UUID=$UUID /media/linux/Expansion auto nosuid,nodev,nofail,x-gvfs-show 0 0" | sudo tee -a /etc/fstab

# 4. Mount everything
sudo mount -a

echo "✅ Expansion Drive integrated as internal storage."
echo "🧟 Type 'm mount' anytime to refresh the Vault."
