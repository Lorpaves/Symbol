//
//  CollectionMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

protocol CollectionMacro {
    static var macro: GenerateImageCollectionMacro { get }
}

extension CollectionMacro where Self: MemberMacro {
    static func diagnose(_ decl: some DeclGroupSyntax) throws -> StructDeclSyntax {
        guard let structDecl = decl.as(StructDeclSyntax.self) else {
            throw DiagnosticsError(
                diagnostics: [
                    Diagnostic(
                        node: Syntax(decl),
                        message: SymbolDiagnosticMessage.notStruct(macro: macro.macroIdentifier)
                    ),
                ]
            )
        }
        return structDecl
    }

    static func mapSymbols(of declaration: some DeclGroupSyntax) throws -> [Symbol] {
        let enumDecl = try diagnose(declaration)
        let defaultFormat: GenerateFormat
        switch macro {
        case .all:
            if let attribute = declaration.attributes.first?.as(AttributeSyntax.self),
               let attribuetArgs = attribute.arguments?.as(LabeledExprListSyntax.self),
               let formatLiteral = attribuetArgs.first?.expression.as(MemberAccessExprSyntax.self)?.declName.baseName.text {
                switch formatLiteral {
                case "asset":
                    defaultFormat = .asset
                default:
                    defaultFormat = .sfSymbol
                }
            } else {
                defaultFormat = .sfSymbol
            }
        case .asset:
            defaultFormat = .asset
        case .sfSymbol:
            defaultFormat = .sfSymbol
        }
        var symbols = try enumDecl.mapMembersToSymbol(defaultFormat: defaultFormat)

        for structDelc in declaration.structDeclSyntaxes {
            let format: GenerateFormat?
            if structDelc.attributes(contains: GenerateImageCollectionMacro.sfSymbol.macroIdentifier) {
                format = .sfSymbol
            } else if structDelc.attributes(contains: GenerateImageCollectionMacro.asset.macroIdentifier) {
                format = .asset
            } else {
                format = nil
            }
            guard let format else { continue }
            let transformedSymbols = try structDelc.mapMembersToSymbol(defaultFormat: format)
            symbols.append(contentsOf: transformedSymbols)
        }
        return symbols
    }

    static func writeSymbols(_ symbols: [Symbol]) -> [DeclSyntax] {
        var syntaxes: [DeclSyntax] = []
        for symbol in symbols {
            switch symbol.generateFormat {
            case .asset:
                syntaxes.append(symbol.assetImageDelc)
                syntaxes.append(symbol.assetNSUIImageDelc)
            case .sfSymbol:
                if #available(iOS 13.0, macOS 11.0, tvOS 13.0, watchOS 6.0, *) {
                    syntaxes.append(symbol.symbolImageDelc)
                    syntaxes.append(symbol.symbolNSUIImageDelc)
                }
            default: break
            }
        }
        return syntaxes
    }
}
