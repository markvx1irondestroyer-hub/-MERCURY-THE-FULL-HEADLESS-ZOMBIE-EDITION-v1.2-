v1.2 Full Headless Zombie Edition logic, integrating the purposeful beheading, smartphone control, and the critical internal drive trick.
🧟 Mercury: The Headless Zombie Media Stack (v1.2)
User: markvx1irondestroyer-hub
Description
A fully automated installer and Docker stack for a high-availability media server. This "Full Headless" edition is purposefully beheaded to disable the desktop GUI, saving RAM and power while keeping the NVIDIA GTX 750 awake for transcoding without a monitor. Everything is controlled remotely via smartphone.
🚀 Installation & The Beheading
 * Prepare the Foundation: Download the files to your home directory.
 * Execute the Beheading:
   bash install-headless.sh
   (This installs drivers, enables GPU persistence, and disables the GUI. The PC will reboot into a text-only state.)
 * The Internal Drive Trick: Immediately after reboot, secure your "Vault" so movies don't disappear:
   bash mount-vault.sh
   (This tricks the system into mounting your external Expansion drive before the apps wake up.)
 * Resurrect the Stack:
   m up
📱 The Digital Nerve Center (Web UI)
Access these ports via your smartphone browser using your server's IP to finish the brain connection:
 * Portainer (9443): Visual management for all containers.
 * Prowlarr (9696): Indexer manager; syncs indexers to Radarr/Sonarr.
 * Jellyfin (8096): Media player; point libraries to /data/expansion.
 * Radarr/Sonarr (7878/8989): Connect to qBittorrent using hostname qbittorrent.
 * Jellyseerr (5055): One-click request hub; connect via API Keys.
📒 The 'm' Command
| Command | Result |
|---|---|
| m up | Starts the entire media stack in the background. |
| m status | Checks storage status, GPU health, and app vitals. |
| m gpu | Live 1-second monitor of the GTX 750 performance. |
| m mount | Forces a refresh/mount of the Expansion Vault. |
| m reset | Nuclear Reset: Wipes cache and restarts the stack fresh. |
| m gui-on | Restores Desktop GUI (Emergency repairs only, requires reboot). |
| m gui-off | Returns to pure Headless mode (requires reboot). |
⚠️ Safety & Responsibility
 * Check the Code: Always inspect scripts before piping them into your terminal.
 * Power Stability: A UPS is recommended to protect the "Internal Trick" mount during power loss.
 * User Risk: You acknowledge you are modifying system boot targets at your own risk.
