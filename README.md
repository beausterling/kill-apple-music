# Kill Apple Music

Permanently prevents Apple Music from opening on your Mac. Lightweight, event-driven, and uses zero CPU while idle.

## How It Works

Uses macOS's native `NSWorkspace` app-launch notifications to detect the instant Music.app tries to open, then kills it before it fully loads. No polling, no wasted resources.

## Install

```bash
git clone https://github.com/beausterling/kill-apple-music.git
cd kill-apple-music
bash install.sh
```

That's it. Apple Music will never open again — even after restarting your Mac.

## Uninstall

```bash
~/.kill-apple-music/uninstall.sh
```

## Requirements

- macOS 12+ (Monterey or later)
- Xcode Command Line Tools (`xcode-select --install`)

## How It Works (Technical)

1. A small compiled Swift binary listens for app-launch events via `NSWorkspace.didLaunchApplicationNotification`
2. When Music.app launches, it's immediately terminated
3. A macOS LaunchAgent starts the binary at login and keeps it running

The binary uses zero CPU while waiting — it only activates when an app launches.

## License

MIT
