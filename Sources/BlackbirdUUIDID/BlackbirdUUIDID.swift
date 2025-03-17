// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: named(ID))
public macro UUIDID() = #externalMacro(module: "BlackbirdUUIDIDMacros", type: "BlackbirdUUIDIDMacro")

public protocol UUIDID {
	static var temporary: Self { get }
	static func mock(lowByte: UInt8) -> Self
	static func random() -> Self

	var isTemporary: Bool { get }
	var ifNonTemporary: Self? { get }
}
