//
//  ImageAssetCollectionMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftSyntax
import SwiftSyntaxMacros

public enum ImageAssetCollectionMacro: MemberMacro {}

extension ImageAssetCollectionMacro: CollectionMacro {
    static let macro: GenerateImageCollectionMacro = .asset
    
    public static func expansion(of node: AttributeSyntax, providingMembersOf declaration: some DeclGroupSyntax, conformingTo protocols: [TypeSyntax], in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        let symbols = try mapSymbols(of: declaration)
        return writeSymbols(symbols)
    }
}


