//
//  Utils.swift
//  Symbol
//
//  Created by Lorpaves on 2024/11/9.
//

import Foundation
import SwiftSyntax

// MARK: - DeclGroupSyntax

extension DeclGroupSyntax {
    var structDeclSyntaxes: [StructDeclSyntax] {
        memberBlock.members.compactMap { $0.decl.as(StructDeclSyntax.self) }
    }

    var enumCaseDelcSyntaxes: [VariableDeclSyntax] {
        memberBlock.members.compactMap { $0.decl.as(VariableDeclSyntax.self) }
    }
}

// MARK: - Collection<VariableDeclSyntax>

extension Collection where Iterator.Element == VariableDeclSyntax {
    func transformToSymbols(defaultFormat: GenerateFormat) throws -> [Symbol] {
        try compactMap { member throws -> Symbol? in
            guard member.bindingSpecifier.text == "let" else { return nil }
            return try member.transformToSymbol(defaultFormat: defaultFormat)
        }
    }
}

// MARK: - StructDeclSyntax

extension StructDeclSyntax {
    func attributes(contains identifier: String) -> Bool {
        return attributes
            .compactMap({ $0.as(AttributeSyntax.self) })
            .first(where: { $0.attributeName.as(IdentifierTypeSyntax.self)?.name.text == identifier }) != nil
    }

    func inheritance(contains identifier: String) -> Bool {
        inheritanceClause?
            .inheritedTypes
            .contains(where: { $0.type.as(IdentifierTypeSyntax.self)?.name.text == identifier }) == true
    }

    func mapMembersToSymbol(defaultFormat: GenerateFormat) throws -> [Symbol] {
        return try memberBlock.members.compactMap { member throws -> Symbol? in
            guard let variableDeclMember = member.decl.as(VariableDeclSyntax.self),
                  variableDeclMember.bindingSpecifier.text == "let" else {
                return nil
            }
            return try variableDeclMember.transformToSymbol(defaultFormat: defaultFormat)
        }
    }
}

// MARK: - PatternBindingSyntax

extension PatternBindingSyntax {
    func transformToSymbols(defaultFormat: GenerateFormat) throws -> Symbol? {
        guard let identifier = pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            return nil
        }
        guard let initializerValue = initializer?.value else {
            return nil
        }
        return try Symbol(
            identifier: identifier,
            stringLiteral: initializerValue.trimmedDescription,
            generateFormat: defaultFormat,
            node: self
        )
    }
}

// MARK: - VariableDeclSyntax

extension VariableDeclSyntax {
    func attributes(contains identifier: String) -> Bool {
        return attributes
            .compactMap({ $0.as(AttributeSyntax.self) })
            .first(where: { $0.attributeName.as(IdentifierTypeSyntax.self)?.name.text == identifier }) != nil
    }

    func transformToSymbol(defaultFormat: GenerateFormat) throws -> Symbol? {
        let generateFormat: GenerateFormat = {
            if self.attributes(contains: "SFSymbol") { return .sfSymbol }
            if self.attributes(contains: "ImageAsset") { return .asset }
            return defaultFormat
        }()
        if let symbol = try bindings.first?.transformToSymbols(defaultFormat: generateFormat) {
            return symbol
        }
        return nil
    }
}
