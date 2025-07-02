# 🧠 distraction-shield (macOS)

A **macOS website blocker** that runs quietly in the background, blocks distracting sites, and motivates you with quotes. Designed to be **hard to disable**, helping you focus deeply.

## 🚫 Blocked Sites (by default)
- youtube.com
- reddit.com
- facebook.com
- instagram.com
- twitter.com

## ⏰ Active Hours
Blocks sites daily from **8 AM to 10 PM** (configurable in the script).

## ✨ Features
- Launches automatically via LaunchAgent
- Runs silently in the background
- Shows motivational quotes (macOS notifications)
- Logs all block/unblock actions
- Difficult to disable casually
- Fully open-source and customizable

---

## ⚠️ Requirements

- macOS
- Admin privileges (used only during installation)

---

## 📦 Installation

> You must run the script with `sudo` to allow it to manage system files and services.

```bash
git clone https://github.com/yourusername/distraction-shield.git
cd distraction-shield
chmod +x install.sh
sudo ./install.sh

## 📦 Un Installation

sudo launchctl bootout system /Library/LaunchDaemons/com.blocker.hidden.plist
sudo rm /Library/LaunchDaemons/com.blocker.hidden.plist
sudo rm /usr/local/lib/.block_web.py
sudo rm /usr/local/lib/.quotes.txt
