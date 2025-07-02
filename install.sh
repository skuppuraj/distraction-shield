#!/bin/bash

set -e

echo "🔐 Installing Website Blocker (requires sudo)..."

# Ensure sudo access
if [ "$EUID" -ne 0 ]; then
  echo "❌ Please run this installer with sudo: sudo ./install.sh"
  exit 1
fi

# Create hidden install location
INSTALL_PATH="/usr/local/lib"
SCRIPT_NAME=".block_web.py"
PLIST_NAME="com.blocker.hidden.plist"
PLIST_DEST="/Library/LaunchDaemons/$PLIST_NAME"

echo "📁 Creating install directory at $INSTALL_PATH..."
mkdir -p "$INSTALL_PATH"

echo "📄 Copying blocker script..."
cp block_websites.py "$INSTALL_PATH/$SCRIPT_NAME"
chmod +x "$INSTALL_PATH/$SCRIPT_NAME"

echo "💬 Copying quotes.txt..."
cp quotes.txt "$INSTALL_PATH/.quotes.txt"

# Patch path inside script to use correct quote file path
sed -i '' "s|quotes.txt|/usr/local/lib/.quotes.txt|g" "$INSTALL_PATH/$SCRIPT_NAME"

echo "🛠️ Installing LaunchDaemon..."
cp "$PLIST_NAME" "$PLIST_DEST"
chmod 644 "$PLIST_DEST"
chown root:wheel "$PLIST_DEST"

echo "✅ Loading LaunchDaemon..."
launchctl load -w "$PLIST_DEST"

echo "🎉 Installed! The blocker will run in the background and start at boot."
