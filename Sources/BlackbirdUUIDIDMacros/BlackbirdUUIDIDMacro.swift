import MacroToolkit
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct BlackbirdUUIDIDMacro: MemberMacro {
	public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
		let visibility = declaration.isPublic ? "public" : "internal"
		return ["""
		\(raw: visibility) struct ID: UUIDID, Codable, Hashable, BlackbirdColumnWrappable, BlackbirdStorableAsText {
			private let string: String

			\(raw: visibility) static var temporary: Self { Self.mock(lowByte: 0) }

			\(raw: visibility) static func mock(lowByte: UInt8) -> Self {
				self.init(rawString: String(format: "0x%0x", lowByte))
			}

			\(raw: visibility) static func random() -> Self {
				self.init(rawString: UUID().uuidString)
			}

			\(raw: visibility) var isTemporary: Bool {
				self == Self.temporary
			}

			\(raw: visibility) var ifNonTemporary: Self? {
				self.isTemporary ? nil : self
			}

			\(raw: visibility) init(rawString: String) {
				self.string = rawString
			}

			\(raw: visibility) init(from uuid: UUID) {
				self.string = uuid.uuidString
			}

			\(raw: visibility) init(from decoder: Decoder) throws {
				self.init(rawString: try decoder.decodeSingleValue())
			}

			\(raw: visibility) func encode(to encoder: Encoder) throws {
				try encoder.encodeSingleValue(self.string)
			}

			\(raw: visibility) static func from(unifiedRepresentation: String) -> Self {
				Self(rawString: unifiedRepresentation)
			}

			\(raw: visibility) static func fromValue(_ value: Blackbird.Value) -> Self? {
				value.stringValue.map(Self.init(rawString:))
			}

			\(raw: visibility) func unifiedRepresentation() -> String {
				self.string
			}
		}
		"""]
	}
}

@main
struct BlackbirdUUIDIDPlugin: CompilerPlugin {
	let providingMacros: [Macro.Type] = [
		BlackbirdUUIDIDMacro.self,
	]
}
