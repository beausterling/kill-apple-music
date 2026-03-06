#!/bin/bash
set -e

BINARY_NAME="KillAppleMusic"
INSTALL_DIR="$HOME/.kill-apple-music"
PLIST_NAME="com.kill.apple.music.plist"
PLIST_PATH="$HOME/Library/LaunchAgents/$PLIST_NAME"

echo ""
echo "  🔇 Kill Apple Music — Installer"
echo "  Permanently prevents Apple Music from opening."
echo ""

# Check for Xcode Command Line Tools
if ! command -v swiftc &> /dev/null; then
    echo "  ❌ Swift compiler not found."
    echo "  Run: xcode-select --install"
    echo ""
    exit 1
fi

# Unload existing agent if present
if launchctl list | grep -q "com.kill.apple.music" 2>/dev/null; then
    echo "  ⏹  Stopping existing installation..."
    launchctl unload "$PLIST_PATH" 2>/dev/null || true
fi

# Also unload old no-more-music agent if present
if launchctl list | grep -q "com.nomore.music" 2>/dev/null; then
    launchctl unload "$HOME/Library/LaunchAgents/com.nomore.music.plist" 2>/dev/null || true
    rm -f "$HOME/Library/LaunchAgents/com.nomore.music.plist"
    rm -rf "$HOME/.no-more-music"
fi

# Create install directory
mkdir -p "$INSTALL_DIR"

# Compile
echo "  🔨 Compiling..."
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
swiftc "$SCRIPT_DIR/KillAppleMusic.swift" -o "$INSTALL_DIR/$BINARY_NAME"

# Copy uninstall script
cp "$SCRIPT_DIR/uninstall.sh" "$INSTALL_DIR/uninstall.sh"
chmod +x "$INSTALL_DIR/uninstall.sh"

# Create LaunchAgent
echo "  📦 Installing LaunchAgent..."
cat > "$PLIST_PATH" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.kill.apple.music</string>
    <key>ProgramArguments</key>
    <array>
        <string>${INSTALL_DIR}/${BINARY_NAME}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
</dict>
</plist>
EOF

# Load agent
launchctl load "$PLIST_PATH"

# Kill Music if currently running
killall "Music" 2>/dev/null || true

echo ""
echo "  ✅ Installed! Apple Music will never open again."
echo ""
echo "  To uninstall, run:"
echo "    ~/.kill-apple-music/uninstall.sh"
echo ""
