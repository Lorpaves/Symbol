//
//  GenerateFormat.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation

struct GenerateFormat: RawRepresentable, Sendable {
    let rawValue: Int
    
    init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension GenerateFormat {
    static let asset = GenerateFormat(rawValue: 0)
    
    static let sfSymbol = GenerateFormat(rawValue: 1)
}

extension GenerateFormat: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}
