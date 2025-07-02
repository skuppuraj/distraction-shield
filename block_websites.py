### block_websites.py

import time
import random
from datetime import datetime as dt
import os
import subprocess

# Hosts file path on macOS
HOSTS_PATH = "/etc/hosts"
REDIRECT = "127.0.0.1"

# Sites to block
BLOCKED_SITES = [
    "www.youtube.com", "youtube.com",
    "www.reddit.com", "reddit.com",
    "www.facebook.com", "facebook.com",
    "twitter.com", "www.twitter.com",
    "www.instagram.com", "instagram.com",
    "x.com", "www.x.com",
]

# Blocking hours (24-hour format)
BLOCK_HOURS = (8, 22)  # 8 AM to 10 PM

# Log file path
LOG_FILE = os.path.expanduser("~/Library/Logs/webblock.log")

# Quotes file path
QUOTES_FILE = os.path.join(os.path.dirname(__file__), "quotes.txt")

def log(message):
    with open(LOG_FILE, "a") as log_file:
        timestamp = dt.now().strftime("%Y-%m-%d %H:%M:%S")
        log_file.write(f"[{timestamp}] {message}\n")

def show_quote():
    if not os.path.exists(QUOTES_FILE):
        return
    with open(QUOTES_FILE, "r") as f:
        quotes = [line.strip() for line in f if line.strip()]
    if quotes:
        quote = random.choice(quotes)
        subprocess.run(["osascript", "-e", f'display notification "{quote}" with title "Stay Focused"'])

def is_block_time():
    now = dt.now()
    return BLOCK_HOURS[0] <= now.hour < BLOCK_HOURS[1]

def block_sites():
    try:
        with open(HOSTS_PATH, "r+") as file:
            content = file.read()
            for site in BLOCKED_SITES:
                entry = f"{REDIRECT} {site}\n"
                if entry not in content:
                    file.write(entry)
        log("Sites blocked")
        show_quote()
    except PermissionError as e:
        log(f"PermissionError while blocking sites: {e}")

def unblock_sites():
    try:
        with open(HOSTS_PATH, "r+") as file:
            lines = file.readlines()
            file.seek(0)
            for line in lines:
                if not any(site in line for site in BLOCKED_SITES):
                    file.write(line)
            file.truncate()
        log("Sites unblocked")
    except PermissionError as e:
        log(f"PermissionError while unblocking sites: {e}")

if __name__ == "__main__":
    # while True:
        try:
            if is_block_time():
                block_sites()
            else:
                unblock_sites()
        except Exception as e:
            log(f"Error: {str(e)}")
        time.sleep(300)  # every 5 minutes
