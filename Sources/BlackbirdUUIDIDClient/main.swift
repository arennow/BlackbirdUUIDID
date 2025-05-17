import BlackbirdUUIDID
import Foundation

protocol BlackbirdColumnWrappable {}
protocol BlackbirdStorableAsText {}

enum Blackbird {
	struct Value {
		var stringValue: String? { nil }
	}
}

extension Encoder {
	func encodeSingleValue(_: some Any) throws {}
}

extension Decoder {
	func decodeSingleValue<T>() throws -> T { fatalError() }
}

@UUIDID
struct Outer {
	let a = 17
	let b = 25
}

enum NestedContainer {
	@UUIDID
	struct Inner {}
}
