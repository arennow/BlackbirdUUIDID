import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct BlackbirdUUIDIDMacro: MemberMacro {
	public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
		["""
		struct ID: Codable, Hashable, BlackbirdColumnWrappable, BlackbirdStorableAsText {
			private let string: String

			static var temporary: Self { Self.mock(lowByte: 0) }

			static func mock(lowByte: UInt8) -> Self {
				self.init(rawString: String(format: "0x%0x", lowByte))
			}

			static func random() -> Self {
				self.init(rawString: UUID().uuidString)
			}

			var isTemporary: Bool {
				self == Self.temporary
			}

			var ifNonTemporary: Self? {
				self.isTemporary ? nil : self
			}

			init(rawString: String) {
				self.string = rawString
			}

			init(from uuid: UUID) {
				self.string = uuid.uuidString
			}

			init(from decoder: Decoder) throws {
				self.init(rawString: try decoder.decodeSingleValue())
			}

			func encode(to encoder: Encoder) throws {
				try encoder.encodeSingleValue(self.string)
			}

			static func from(unifiedRepresentation: String) -> Self {
				Self(rawString: unifiedRepresentation)
			}

			static func fromValue(_ value: Blackbird.Value) -> Self? {
				value.stringValue.map(Self.init(rawString:))
			}

			func unifiedRepresentation() -> String {
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
