import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(SymbolMacros)
import SymbolMacros

let testMacros: [String: Macro.Type] = [
    "SymbolCollection": SymbolCollectionMacro.self,
    "SFSymbolCollection": SFSymbolCollectionMacro.self,
    "ImageAssetCollection": ImageAssetCollectionMacro.self,
    "SFSymbol": SFSymbolMacro.self,
    "ImageAsset": ImageAssetMacro.self,
]
#endif

final class SymbolTests: XCTestCase {
    func testMacro() throws {
        #if canImport(SymbolMacros)
        assertMacroExpansion(
            """
            @SymbolCollection(.sfSymbol)
            struct Symbols {
                let symbol1 = "sidebar.left"
                @ImageAsset let symbol_asset = "sidebar.left"
                let symbol_sf = "sidebar.left"
                @SFSymbolCollection
                struct SFSymbol {
                    let sidebarLeft = "123"
                    let sidebarRight = "sidebarRight"
                    let sidebar = "sidebar"
                }
                @ImageAssetCollection
                struct AssetSymbol: String {
                    let image1 = "image"
                }
            }
            """,
            expandedSource: """
            (a + b, "a + b")
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(SymbolMacros)
        assertMacroExpansion(
            #"""
            #stringify("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
