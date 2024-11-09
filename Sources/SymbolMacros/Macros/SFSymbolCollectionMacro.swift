//
//  SFSymbolCollectionMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftSyntax
import SwiftSyntaxMacros

public enum SFSymbolCollectionMacro: MemberMacro {}

extension SFSymbolCollectionMacro: CollectionMacro {
    static let macro: GenerateImageCollectionMacro = .sfSymbol
    
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        let symbols = try mapSymbols(of: declaration)
        return writeSymbols(symbols)
    }
}
