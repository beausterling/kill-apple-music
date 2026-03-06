import Cocoa

let center = NSWorkspace.shared.notificationCenter
center.addObserver(
    forName: NSWorkspace.didLaunchApplicationNotification,
    object: nil,
    queue: .main
) { notification in
    guard let app = notification.userInfo?[NSWorkspace.applicationUserInfoKey] as? NSRunningApplication,
          app.localizedName == "Music" else { return }
    app.terminate()
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
        if !app.isTerminated { app.forceTerminate() }
    }
}

RunLoop.main.run()
