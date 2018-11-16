import Cocoa
import Tafelsalz

class ViewController: NSViewController, FileHandler {

	let dcrypt = DCrypt()

	@IBOutlet weak var dropArea: DropArea!

	func promptPassword() -> Password? {
		let passwordField = NSSecureTextField(frame: NSRect(x: 0, y: 0, width: 300, height: 22))
		passwordField.placeholderString = "Enter password…"

		let alert = NSAlert()
		alert.icon = dropArea.icon
		alert.messageText = "Password"
		alert.accessoryView = passwordField
		alert.addButton(withTitle: "OK")
		alert.addButton(withTitle: "Cancel")

		switch alert.runModal() {
			case .alertFirstButtonReturn: // .OK
				return Password(passwordField.stringValue)
			default:
				return nil
		}

	}

	// MARK: NSViewController

	override func viewDidLoad() {
		super.viewDidLoad()
		dropArea.delegate = self
	}

	// MARK: FileHandler

	func encrypt(bytes: Bytes) throws -> Bytes {
		// <#TODO#> If you need to pass additional user input to the encryption
		//      function, this would be the perfect place.
		return dcrypt.encrypt(bytes: bytes)
	}

	func decrypt(bytes: Bytes) throws -> Bytes {
		// <#TODO#> If you need to pass additional user input to the decryption
		//      function, this would be the perfect place.
		return try dcrypt.decrypt(bytes: bytes)
	}
}
