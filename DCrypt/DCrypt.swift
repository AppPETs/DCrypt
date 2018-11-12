import Foundation
import Tafelsalz

class DCrypt: FileHandler {

	enum Error: Swift.Error {
		case invalidCiphertextSize
		case decryptionFailed
	}

	func encrypt(bytes: [UInt8]) -> [UInt8] {
		// <#TODO#> Implement encryption
		return []
	}

	func decrypt(bytes: [UInt8]) throws -> [UInt8] {
		// <#TODO#> Implement decryption
		return []
	}

}
