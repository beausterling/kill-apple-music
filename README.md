# Kill Apple Music

Permanently prevents Apple Music from opening on your Mac. Event-driven, zero CPU, one command install.

**[Website](https://beausterling.github.io/kill-apple-music/)**

## The Problem

Apple Music launches itself whenever you:
- Connect AirPods or Bluetooth headphones
- Press the play/pause media key
- Use Handoff from your iPhone
- Restart your Mac with "Reopen windows" enabled
- Sometimes just... exist near your Mac

There's no built-in setting to turn this off. Apple considers it a feature.

## The Fix

Kill Apple Music is a tiny compiled Swift binary that listens for app-launch events using macOS native APIs. The instant Music.app tries to open, it gets killed before it fully loads. No window. No audio. No mercy.

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

Apple Music will work normally again immediately.

## Requirements

- macOS 12+ (Monterey, Ventura, Sonoma, Sequoia)
- Xcode Command Line Tools (`xcode-select --install`)
- Works on both **Intel and Apple Silicon** Macs — compiles natively on your machine

## How It Works

1. The install script compiles a small Swift binary from source on your machine using `swiftc`
2. A macOS LaunchAgent starts the binary at login and keeps it running
3. The binary listens for app-launch events via `NSWorkspace.didLaunchApplicationNotification`
4. When Music.app launches, it's immediately terminated
5. Zero CPU while idle — it only activates when an app launches

## Kill Apple Music vs noTunes

| | Kill Apple Music | noTunes |
|---|---|---|
| Detection method | Event-driven (instant) | Polling (every second) |
| CPU while idle | Zero | Constant |
| Install | One terminal command | Homebrew or manual download |
| Menu bar icon | None | Yes |
| Intel + Apple Silicon | Compiles natively | Universal binary |
| Open source | MIT | MIT |

Both are great tools. Kill Apple Music just takes a different, more efficient approach.

## License

MIT
