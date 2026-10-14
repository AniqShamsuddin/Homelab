#!/usr/bin/env bash
# UFW rules for the homelab. Allow rules are added before enabling so SSH is never locked out.
set -euo pipefail

LAN_SUBNET="192.168.4.0/22"   # adjust to your network

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow from "$LAN_SUBNET" to any port 22 proto tcp   # SSH from the LAN only
sudo ufw allow in on tailscale0                              # remote access over Tailscale
sudo ufw allow from fd00::/8 to any port 53                  # DNS over IPv6 from the local ULA range
sudo ufw --force enable
sudo ufw status verbose
