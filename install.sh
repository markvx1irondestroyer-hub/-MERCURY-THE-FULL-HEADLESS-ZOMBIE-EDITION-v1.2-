#!/bin/bash
# 🧟 MERCURY: THE FULLY BEHEADED ZOMBIE INSTALLER
echo "🚀 Starting Full Mercury Beheading..."

# 1. System & NVIDIA Drivers
sudo apt update && sudo apt upgrade -y
sudo ubuntu-drivers autoinstall

# 2. NVIDIA Persistence & Toolkit
# Keeps GPU awake without a monitor plugged in
sudo nvidia-smi -pm 1
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker

# 3. Docker Engine & Compose
sudo apt-get install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
sudo systemctl restart docker

# 4. Mercury Environment Setup
mkdir -p ~/mercury/config/{jellyfin,jellyseerr,sonarr,radarr,prowlarr,qbittorrent,flaresolverr,tailscale,portainer}
sudo mkdir -p /media/linux/Expansion

# 5. Inject Master 'm' Command
cat << 'EOF' >> ~/.bash_aliases
alias gpu='watch -n 1 nvidia-smi'
alias mercury='cd ~/mercury'
m() {
    case $1 in
        gpu) gpu ;;
        up) cd ~/mercury && docker compose up -d ;;
        ps) docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" ;;
        reset) cd ~/mercury && docker compose down && docker system prune -f && docker compose up -d ;;
        mount) sudo mount -a && echo "🧟 Vault Refreshed." ;;
        status) ~/mercury/status.sh ;;
        *) echo "Usage: m [gpu|up|ps|reset|mount|status]" ;;
    esac
}
EOF

# 6. THE FULL BEHEADING
# Disables GUI to save RAM; boots straight to Terminal
sudo systemctl set-default multi-user.target

echo "🧟 Mercury is now Headless. Rebooting in 5 seconds..."
sleep 5
sudo reboot
