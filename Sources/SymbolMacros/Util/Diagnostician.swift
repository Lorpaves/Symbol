//
//  Diagnostician.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation
import SwiftDiagnostics
import SwiftSyntax
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

enum Diagnostician {
    
    @available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    static func diagnoseSFSymbolImage(_ symbolName: String, of node: SyntaxProtocol) throws {
#if canImport(UIKit)
        if UIImage(systemName: symbolName, withConfiguration: nil) == nil {
            throw DiagnosticsError(
                diagnostics: [
                    Diagnostic(
                        node: node,
                        message: SymbolDiagnosticMessage.symbolNotFound(symbolName)
                    )
                ]
            )
        }
#elseif canImport(AppKit)
        if NSImage(systemSymbolName: symbolName, accessibilityDescription: nil) == nil {
            throw DiagnosticsError(
                diagnostics: [
                    Diagnostic(
                        node: node,
                        message: SymbolDiagnosticMessage.symbolNotFound(symbolName)
                    )
                ]
            )
        }
#endif
    }
    
}
