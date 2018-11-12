import Cocoa

class ViewController: NSViewController {

	@IBOutlet weak var dropArea: DropArea!

	let handler = DCrypt()

	// MARK: NSViewController

	override func viewDidLoad() {
		super.viewDidLoad()

		dropArea.delegate = handler
	}

	override var representedObject: Any? {
		didSet {
			// Update the view, if already loaded.
		}
	}

}
