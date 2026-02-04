#!/bin/bash
# 🧟 MERCURY: THE FULLY BEHEADED ZOMBIE INSTALLER (v1.2.3)
echo "🚀 Starting Full Mercury Beheading..."

# 1. System, NVIDIA Drivers & Emoji Support
sudo apt update && sudo apt upgrade -y
sudo apt install -y fonts-noto-color-emoji ca-certificates curl gnupg
sudo ubuntu-drivers autoinstall

# 2. NVIDIA Persistence & Toolkit
sudo nvidia-smi -pm 1
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt update && sudo apt install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker

# 3. Docker Engine & Compose
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER
sudo systemctl restart docker

# 4. Mercury Environment Setup
mkdir -p ~/mercury/config/{jellyfin,jellyseerr,sonarr,radarr,prowlarr,qbittorrent,flaresolverr,tailscale,portainer}
sudo mkdir -p /media/linux/Expansion

# 5. Inject Master 'm' Command (Optional TV Sideload Included)
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
        gui-on) sudo systemctl set-default graphical.target && echo "✅ GUI Restored. Reboot to see desktop." ;;
        gui-off) sudo systemctl set-default multi-user.target && echo "🧟 Beheaded. Reboot for Headless mode." ;;
        heal) 
            echo "🧟 Reviving the Zombie..."
            sudo mount -a
            sudo chown -R $USER:$USER /media/linux/Expansion ~/mercury/config
            cd ~/mercury && docker compose up -d --remove-orphans
            docker system prune -f
            echo "✅ Surgery Complete. System Stable."
            ;;
        tv)
            echo "📺 --- SAMSUNG TIZEN SIDELOADER ---"
            echo "1. Enable Developer Mode on TV (Apps > 12345)"
            echo "2. Set Host IP to: $(hostname -I | awk '{print $1}')"
            echo "3. Restart TV (Hold Power button)"
            read -p "Enter your Samsung TV IP address: " TV_IP
            docker run --rm --ulimit nofile=1024:65536 \
              -e JELLYFIN_RELEASE="release-10.8.z" \
              ghcr.io/georift/install-jellyfin-tizen "$TV_IP"
            ;;
        *) echo "Usage: m [gpu|up|ps|reset|mount|status|gui-on|gui-off|heal|tv]" ;;
    esac
}
EOF

# 6. Inject The Login Badge
cat << 'EOF' >> ~/.bashrc
echo -e "\e[32m"
cat << "ZOMBIE"
      .---.
     / @ @ \     🧟 MERCURY ZOMBIE SERVER v1.2.3
    |  \_  |     -------------------------------
     \  m  /     Status: HEADLESS / BEHEADED
      '---'      Type 'm' for Master Commands
ZOMBIE
echo "nom nom nom brains.. the Zombie rises."
echo -e "\e[0m"
EOF

# 7. THE FULL BEHEADING
sudo systemctl set-default multi-user.target

echo "🧟 Mercury is now Headless and Hungry. Rebooting in 5 seconds..."
sleep 5
sudo reboot
