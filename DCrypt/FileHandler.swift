import Foundation
import Tafelsalz

protocol FileHandler {
	func encrypt(bytes: Bytes) throws -> Bytes
	func decrypt(bytes: Bytes) throws -> Bytes
}
