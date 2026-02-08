# 3. Docker Engine & Compose (Added -y to all for non-interactive)
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo usermod -aG docker $USER

# 5. Inject Master 'm' Command (Now with a check to prevent duplicates)
if ! grep -q "m() {" ~/.bash_aliases; then
cat << 'EOF' >> ~/.bash_aliases
alias gpu='watch -n 1 nvidia-smi'
alias mercury='cd ~/mercury'
m() {
    case $1 in
        gpu) gpu ;;
        up) cd ~/mercury && sudo docker compose up -d ;;
        ps) sudo docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" ;;
        reset) cd ~/mercury && sudo docker compose down && sudo docker system prune -f && sudo docker compose up -d ;;
        mount) sudo mount -a && echo "🧟 Vault Refreshed." ;;
        status) ~/mercury/status.sh ;;
        gui-on) sudo systemctl set-default graphical.target && echo "✅ GUI Restored. Reboot to see desktop." ;;
        gui-off) sudo systemctl set-default multi-user.target && echo "🧟 Beheaded. Reboot for Headless mode." ;;
        heal) 
            echo "🧟 Reviving the Zombie..."
            sudo mount -a
            sudo chown -R $USER:$USER /media/linux/Expansion ~/mercury/config
            cd ~/mercury && sudo docker compose up -d --remove-orphans
            sudo docker system prune -f
            echo "✅ Surgery Complete. System Stable."
            ;;
        tv)
            echo "📺 --- SAMSUNG TIZEN SIDELOADER ---"
            echo "1. Enable Developer Mode on TV (Apps > 12345)"
            echo "2. Set Host IP to: $(hostname -I | awk '{print $1}')"
            echo "3. Restart TV (Hold Power button)"
            read -p "Enter your Samsung TV IP address: " TV_IP
            sudo docker run --rm --ulimit nofile=1024:65536 \
              -e JELLYFIN_RELEASE="release-10.8.z" \
              ghcr.io/georift/install-jellyfin-tizen "$TV_IP"
            ;;
        *) echo "Usage: m [gpu|up|ps|reset|mount|status|gui-on|gui-off|heal|tv]" ;;
    esac
}
EOF
fi

# 6. Inject The Login Badge (Now with a check to prevent duplicates)
if ! grep -q "MERCURY ZOMBIE SERVER" ~/.bashrc; then
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
fi
