#!/bin/bash

set -e

echo "[+] Installing distraction-shield..."

# Copy Python script to hidden location
sudo cp block_websites.py /usr/local/lib/.block_web.py
sudo chmod +x /usr/local/lib/.block_web.py

# Copy LaunchAgent
cp com.blocker.hidden.plist ~/Library/LaunchAgents/

# Copy quotes file
mkdir -p ~/.distraction-shield/
cp quotes.txt ~/.distraction-shield/

# Create log file
mkdir -p ~/Library/Logs
touch ~/Library/Logs/webblock.log

# Load LaunchAgent
launchctl unload ~/Library/LaunchAgents/com.blocker.hidden.plist 2>/dev/null || true
launchctl load ~/Library/LaunchAgents/com.blocker.hidden.plist

echo "[✓] distraction-shield is now running in the background."
