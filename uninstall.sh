#!/bin/bash

PLIST_PATH="$HOME/Library/LaunchAgents/com.kill.apple.music.plist"
INSTALL_DIR="$HOME/.kill-apple-music"

echo ""
echo "  🔇 Kill Apple Music — Uninstaller"
echo ""

if launchctl list | grep -q "com.kill.apple.music" 2>/dev/null; then
    echo "  ⏹  Stopping agent..."
    launchctl unload "$PLIST_PATH" 2>/dev/null
fi

rm -f "$PLIST_PATH"
rm -rf "$INSTALL_DIR"

echo ""
echo "  ✅ Uninstalled. Apple Music can open freely again."
echo ""
