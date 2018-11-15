import Foundation

enum DCryptError: Error, LocalizedError {
	case userCanceled
	case invalidCiphertextSize
	case decryptionFailed

	// MARK: LocalizedError

	public var errorDescription: String? {
		switch self {
		case .userCanceled:
			return nil
		case .decryptionFailed:
			return NSLocalizedString("The decryption failed. The data could not be authenticated.", comment: "DCrypt.Error.decryptionFailed/errorDescription")
		case .invalidCiphertextSize:
			return NSLocalizedString("The size of the ciphertext is invalid.", comment: "DCrypt.Error.invalidCiphertextSize/errorDescription")
		}
	}
}
