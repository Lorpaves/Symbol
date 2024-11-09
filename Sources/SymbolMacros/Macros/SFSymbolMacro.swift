//
//  SFSymbolMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftSyntax
import SwiftSyntaxMacros

public enum SFSymbolMacro: PeerMacro {}

extension SFSymbolMacro {
    public static func expansion(of node: AttributeSyntax, providingPeersOf declaration: some DeclSyntaxProtocol, in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        return []
    }
}
