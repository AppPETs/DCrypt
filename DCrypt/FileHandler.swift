import Foundation

protocol FileHandler {
	func encrypt(bytes: [UInt8]) throws -> [UInt8]
	func decrypt(bytes: [UInt8]) throws -> [UInt8]
}
