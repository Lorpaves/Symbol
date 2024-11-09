//
//  GenerateFormat.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation

public struct GenerateFormat: RawRepresentable, Sendable {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

public extension GenerateFormat {
    static let asset = GenerateFormat(rawValue: 0)
    
    @available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    static let sfSymbol = GenerateFormat(rawValue: 1)
}
