//
//  SymbolPlugin.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct SymbolPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        ImageAssetCollectionMacro.self,
        SFSymbolCollectionMacro.self,
        SymbolCollectionMacro.self,
        ImageAssetMacro.self,
        SFSymbolMacro.self,
    ]
}
