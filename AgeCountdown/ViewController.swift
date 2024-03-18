import Cocoa

class ViewController: NSViewController {

    override func loadView() {
           self.view = NSView(frame: NSRect(x: 0, y: 0, width: 100, height: 50))
       }

       override func viewDidLoad() {
           super.viewDidLoad()
           
           let quitButton = NSButton(title: "Quit", target: self, action: #selector(quitButtonClicked))
           quitButton.frame = NSRect(x: 10, y: 10, width: 80, height: 30)
           quitButton.bezelStyle = .rounded
           self.view.addSubview(quitButton)
       }
       
       @objc func quitButtonClicked() {
           NSApp.terminate(nil)
       }


}

