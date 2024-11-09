//
//  SymbolCollectionMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftSyntax
import SwiftSyntaxMacros

public enum SymbolCollectionMacro: MemberMacro {}

extension SymbolCollectionMacro: CollectionMacro {
    static let macro: GenerateImageCollectionMacro = .all
}

extension SymbolCollectionMacro {
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        let symbols = try mapSymbols(of: declaration)
        
        return writeSymbols(symbols)
    }
}

