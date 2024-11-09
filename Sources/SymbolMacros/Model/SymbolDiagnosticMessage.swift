//
//  SymbolDiagnosticMessage.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftDiagnostics

enum SymbolDiagnosticMessage: DiagnosticMessage {
    case notStruct(macro: String)
    case symbolNotFound(String)
    var severity: DiagnosticSeverity { .error }

    var message: String {
        switch self {
        case let .notStruct(macro):
            return "Macro @\(macro) can only be applied to structs."
        case let .symbolNotFound(string):
            return "Image '\(string)' not found."
        }
    }


    var diagnosticID: MessageID {
        MessageID(domain: "Symbol", id: message)
    }
}
