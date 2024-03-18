import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    let birthdayString = "1996-11-27"
    private var statusItem: NSStatusItem!
    private var timer: Timer?
    private var popover: NSPopover!
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    func updateCountdownString() {
        guard let birthday = dateFormatter.date(from: birthdayString) else {
            statusItem?.button?.title = "Error"
            return
        }
        
        let today = Date()
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year, .month, .day], from: birthday, to: today)
        let years = ageComponents.year ?? 0
        let months = ageComponents.month ?? 0
        let days = ageComponents.day ?? 0
        
        let countdownString = String(format: "%d-%02d-%02d", years, months, days)
        statusItem?.button?.title = countdownString
    }
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        updateCountdownString() // Initial update
        statusItem.button?.action = #selector(togglePopover)
        self.popover = NSPopover()
        self.popover.contentSize = NSSize(width: 100, height: 50)
        self.popover.behavior = .transient
        self.popover.contentViewController = ViewController()
        
        // Schedule a timer to update the countdown string
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            self?.updateCountdownString()
        }
        
        // Ensure the timer is stopped when the application terminates
        NSApp.delegate = self
    }
    
    @objc func togglePopover() {
        if let button = statusItem.button {
            if popover.isShown {
                self.popover.performClose(nil)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        timer?.invalidate()
    }
    
    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}
