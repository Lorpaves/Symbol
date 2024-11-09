//
//  Symbol.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation
import SwiftSyntax

struct Symbol {
    var identifier: String
    var stringLiteral: String
    var generateFormat: GenerateFormat
    init(
        identifier: String,
        stringLiteral: String? = nil,
        generateFormat: GenerateFormat,
        node: SyntaxProtocol
    ) throws {
        self.identifier = identifier

        if let stringLiteral {
            self.stringLiteral = stringLiteral
        } else {
            self.stringLiteral = identifier
        }
        self.generateFormat = generateFormat
        
        if generateFormat == .sfSymbol {
            if #available (iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *) {
                try Diagnostician.diagnoseSFSymbolImage(Self.resolveImageName(stringLiteral ?? identifier), of: node)
            }
            return
        }
    }
    private static func resolveImageName(_ name: String) -> String {
        var name = name
        if name.hasPrefix("\"") {
            name.removeFirst()
        }
        if name.hasSuffix("\"") {
            name.removeLast()
        }
        return name
    }

    var assetNSUIImageDelc: DeclSyntax {
        """
        #if canImport(UIKit)
        static var \(raw: identifier)_UIImage: \(Constants.imageTypeDelc_UIKit) { 
            \(Constants.imageTypeDelc_UIKit)(named: \(raw: stringLiteral)) ?? \(Constants.imageTypeDelc_UIKit)() 
        }
        #endif
        #if canImport(AppKit)
        static var \(raw: identifier)_NSImage: \(Constants.imageTypeDelc_AppKit) { 
            \(Constants.imageTypeDelc_AppKit)(named: \(raw: stringLiteral)) ?? \(Constants.imageTypeDelc_AppKit)()
        }
        #endif
        """
    }

    var assetImageDelc: DeclSyntax {
        """
        #if canImport(SwiftUI)
        static var \(raw: identifier): \(Constants.imageTypeDelc_SwifTUI) { 
            \(Constants.imageTypeDelc_SwifTUI)(\(raw: stringLiteral))
        }
        #endif
        """
    }

    @available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    var symbolNSUIImageDelc: DeclSyntax {
        """
        #if canImport(UIKit)
        static var \(raw: identifier)_UIImage: \(Constants.imageTypeDelc_UIKit) { 
            \(Constants.imageTypeDelc_UIKit)(systemName: \(raw: stringLiteral), withConfiguration: nil)!
        }
        #endif
        #if canImport(AppKit)
        static var \(raw: identifier)_NSImage: \(Constants.imageTypeDelc_AppKit) { 
            \(Constants.imageTypeDelc_AppKit)(systemSymbolName: \(raw: stringLiteral), accessibilityDescription: nil)!
        }
        #endif

        """
    }

    @available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    var symbolImageDelc: DeclSyntax {
        """
        #if canImport(SwiftUI)
        static var \(raw: identifier): \(Constants.imageTypeDelc_SwifTUI) { 
            \(Constants.imageTypeDelc_SwifTUI)(systemName: \(raw: stringLiteral))
        }
        #endif
        """
    }
}
