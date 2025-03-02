// swift-tools-version: 6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(name: "BlackbirdUUIDID",
					  platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
					  products: [
					  	.library(name: "BlackbirdUUIDID",
								   targets: ["BlackbirdUUIDID"]),
					  	.executable(name: "BlackbirdUUIDIDClient",
									  targets: ["BlackbirdUUIDIDClient"]),
					  ],
					  dependencies: [
					  	.package(url: "https://github.com/swiftlang/swift-syntax.git", "509.0.0"..<"602.0.0"),
					  	.package(url: "https://github.com/stackotter/swift-macro-toolkit.git", .upToNextMinor(from: "0.6.0")),
					  ],
					  targets: [
					  	.macro(name: "BlackbirdUUIDIDMacros",
								 dependencies: [
								 	.product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
								 	.product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
								 	.product(name: "MacroToolkit", package: "swift-macro-toolkit"),
								 ]),
					  	.target(name: "BlackbirdUUIDID", dependencies: ["BlackbirdUUIDIDMacros"]),
					  	.executableTarget(name: "BlackbirdUUIDIDClient", dependencies: ["BlackbirdUUIDID"]),
					  ])
