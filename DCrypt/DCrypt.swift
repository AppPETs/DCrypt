import Foundation
import Tafelsalz

class DCrypt: FileHandler {

	enum Error: Swift.Error, LocalizedError {
		case invalidCiphertextSize
		case decryptionFailed

		// MARK: LocalizedError

		public var errorDescription: String? {
			switch self {
			case .decryptionFailed:
				return NSLocalizedString("The decryption failed. The data could not be authenticated.", comment: "DCrypt.Error.decryptionFailed/errorDescription")
			case .invalidCiphertextSize:
				return NSLocalizedString("The size of the ciphertext is invalid.", comment: "DCrypt.Error.invalidCiphertextSize/errorDescription")
			}
		}
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
