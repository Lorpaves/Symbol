//
//  GenerateImageCollectionMacro.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation

enum GenerateImageCollectionMacro {
    case all
    case sfSymbol
    case asset

    var macroIdentifier: String {
        switch self {
        case .all:
            return "SymbolCollection"
        case .sfSymbol:
            return "SFSymbolCollection"
        case .asset:
            return "ImageAssetCollection"
        }
    }
}
