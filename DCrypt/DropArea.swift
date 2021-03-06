import Cocoa
import Tafelsalz

class DropArea: NSImageView {

	var delegate: FileHandler? = nil

	private let dragFilter: [NSPasteboard.ReadingOptionKey: Any] = [.urlReadingFileURLsOnly: true]

	private var isReceivingDrag = false {
		didSet {
			needsDisplay = true
		}
	}

	private var draggedUrl: URL? = nil

	public var icon: NSImage? {
		guard let path = draggedUrl?.path else {
			return nil
		}

		return NSWorkspace.shared.icon(forFile: path)
	}

	func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
		let pasteboard = draggingInfo.draggingPasteboard

		// Check if the dragged objects are file URLs
		guard pasteboard.canReadObject(forClasses: [NSURL.self], options: dragFilter) else {
			return false
		}

		guard let urls = pasteboard.readObjects(forClasses: [NSURL.self], options: dragFilter) as? [URL] else {
			return false
		}

		// Check if there is only one URL
		guard urls.count == 1 else {
			return false
		}

		let url = urls.first!
		assert(url.isFileURL)

		// Check if the dragged URLs are file and not directories
		guard url.absoluteString.last! != "/" else {
			return false
		}

		return true
	}

	// MARK: NSImageView

	required init?(coder: NSCoder) {
		super.init(coder: coder)

		registerForDraggedTypes([.fileURL])
		isEditable = false
	}

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

		if isReceivingDrag {
			NSColor.selectedControlColor.set()
			let path = NSBezierPath(rect: bounds)
			path.lineWidth = 7.5
			path.stroke()
		}
    }

	// MARK: NSDraggingDestination

	override func draggingEntered(_ draggingInfo: NSDraggingInfo) -> NSDragOperation {
		let allowDrag = shouldAllowDrag(draggingInfo)
		isReceivingDrag = allowDrag
		return allowDrag ? .generic : NSDragOperation()
	}

	override func draggingExited(_ draggingInfo: NSDraggingInfo?) {
		// Drag is aborted without a drop
		isReceivingDrag = false
	}

	override func prepareForDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
		return shouldAllowDrag(draggingInfo)
	}

	override func performDragOperation(_ draggingInfo: NSDraggingInfo) -> Bool {
		isReceivingDrag = false
		let pasteboard = draggingInfo.draggingPasteboard

		guard let urls = pasteboard.readObjects(forClasses: [NSURL.self], options: dragFilter) as? [URL] else {
			fatalError("Unexpectedly accepted unknown drag type.")
		}

		assert(urls.count == 1)
		let url = urls.first!
		assert(url.isFileURL)

		draggedUrl = url

		// Load file and pass bytes to delegate
		if let delegate = delegate {
		do {
				let content = try Data(contentsOf: url)
				let filename = url.lastPathComponent
				let basename = filename.split(separator: ".").dropLast().joined(separator: ".")
				let ext = filename.split(separator: ".").last!

				let savePanel = NSSavePanel()
				savePanel.directoryURL = URL(fileURLWithPath: url.deletingLastPathComponent().path, isDirectory: true)
				savePanel.isExtensionHidden = false

				let bytesToWrite: Bytes
				if ext == "dcrypt" {
					// Decrypt file
					savePanel.nameFieldStringValue = basename
					do {
						bytesToWrite = try delegate.decrypt(bytes: Bytes(content))
					} catch {
						if let e = error as? DCryptError, e == .userCanceled {
							return false
						}
						let alert = NSAlert(error: error)
						alert.beginSheetModal(for: self.window!)
						return false
					}
				} else {
					// Encrypt file
					savePanel.nameFieldStringValue = filename + ".dcrypt"
					do {
						bytesToWrite = try delegate.encrypt(bytes: Bytes(content))
					} catch {
						if let e = error as? DCryptError, e == .userCanceled {
							return false
						}
						let alert = NSAlert(error: error)
						alert.beginSheetModal(for: self.window!)
						return false
					}
				}

				savePanel.beginSheetModal(for: window!) {
					response in

					if response == .OK {
						let targetUrl = savePanel.url!

						do {
							try Data(bytesToWrite).write(to: targetUrl)
						} catch {
							if let e = error as? DCryptError, e == .userCanceled {
								return
							}
							let alert = NSAlert(error: error)
							alert.beginSheetModal(for: self.window!)
							return
						}
					}
				}
			} catch {
				if let e = error as? DCryptError, e == .userCanceled {
					return false
				}
				let alert = NSAlert(error: error)
				alert.beginSheetModal(for: self.window!)
				return false
			}
		}

		return true
	}

	override func draggingEnded(_ sender: NSDraggingInfo) {

	}

	override func concludeDragOperation(_ sender: NSDraggingInfo?) {
		assert(draggedUrl != nil)

//		let path = draggedUrl!.path

//		image = NSWorkspace.shared.icon(forFile: path)
	}

}
