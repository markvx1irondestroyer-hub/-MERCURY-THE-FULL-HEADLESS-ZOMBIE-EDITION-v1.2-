[![🧟 Mercury Stack Validation](https://github.com/markvx1irondestroyer-hub/-Mercury-The-Headless-Zombie-Media-Stack-/actions/workflows/validate-stack.yml/badge.svg)](https://github.com/markvx1irondestroyer-hub/-Mercury-The-Headless-Zombie-Media-Stack-/actions/workflows/validate-stack.yml)

​🧟 MERCURY: THE FULL HEADLESS ZOMBIE EDITION (v1.2)


​"The Beheading was Purposeful. The Smartphone is the Crown."


​This is the official blueprint for a dedicated, monitor-free media server. By "Beheading" the system, we disable the Desktop GUI to save RAM and power, allowing the NVIDIA GTX 750 to focus entirely on transcoding media for your remote devices.


​PHASE 1: THE PURPOSEFUL BEHEADING

​Goal: Prepare the hardware and disable the monitor requirement.

​Prepare the Installer:

​Create a file named install-headless.sh.

​Paste the content of the Master Installer script into this file.

​Execute:

​Run chmod +x install-headless.sh.

​Run ./install-headless.sh.

​What happens: The script installs NVIDIA drivers, enables GPU persistence (keeping the card awake without a monitor), installs Docker, and sets the system to boot directly to the terminal. The PC will reboot automatically.

​PHASE 2: THE INTERNAL DRIVE TRICK

​Goal: Ensure the "Vault" (Expansion Drive) is connected before the apps wake up.

​Why this matters: If the server reboots, Docker apps often start faster than USB drives can mount. This script "tricks" Linux into treating your external drive as a permanent internal component so your library never looks empty.

​Execute:

​Create mount-vault.sh.

​Run chmod +x mount-vault.sh && ./mount-vault.sh.

​PHASE 3: THE GOLDEN DEPLOYMENT

​Goal: Wake the media empire.

​Deploy the Stack:

​Ensure your docker-compose.yml (The Golden YAML) is in ~/mercury/.


​Run the master command: m up.

​The 'm' Command: You now have a single-letter interface to manage the server.


​m status: Check vitals.


​m gpu: Monitor the GTX 750.


​m reset: The "Nuclear" fix for hangs.


​PHASE 4: THE DIGITAL NERVE CENTER (Smartphone Setup)

​Once the stack is up, use your smartphone browser and the server's IP address to finish the configuration:

​Portainer (Port 9443): Your mobile command center for managing all apps.

​Prowlarr (Port 9696): Add your indexers; they will automatically sync to Radarr and Sonarr.

​Radarr/Sonarr (Ports 7878/8989): Connect them to qBittorrent using the hostname qbittorrent.

​Jellyseerr (Port 5055): Connect to Jellyfin and your Arrs via API Keys to enable one-click requests from your phone.

​⚠️ SAFETY & RECOVERY

​Emergency Desktop: If you ever need the monitor back for local repairs, type m gui-on and reboot.


​Return to Shadow: Type m gui-off and reboot to return to the pure Headless state.

​⚠️ Disclaimer: Please always check the code and understand its function before installing it on your system. By running these scripts, you acknowledge that you do so at your own risk. I am not responsible for any data loss, hardware issues, or system instability that may occur during or after the installation process.

