#!/bin/bash

echo "[!] Uninstalling distraction-shield..."

launchctl unload ~/Library/LaunchAgents/com.blocker.hidden.plist 2>/dev/null

rm -f ~/Library/LaunchAgents/com.blocker.hidden.plist
sudo rm -f /usr/local/lib/.block_web.py
rm -rf ~/.distraction-shield/
rm -f ~/Library/Logs/webblock.log

echo "[✓] Uninstalled. You are now free... but beware temptation."
