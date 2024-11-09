// The Swift Programming Language
// https://docs.swift.org/swift-book


@attached(member, names: arbitrary)
public macro SymbolCollection(_ default: GenerateFormat) = #externalMacro(module: "SymbolMacros", type: "SymbolCollectionMacro")

@available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@attached(member, names: arbitrary)
public macro SymbolCollection(default: GenerateFormat = .sfSymbol) = #externalMacro(module: "SymbolMacros", type: "SymbolCollectionMacro")

@available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@attached(member, names: arbitrary)
public macro SFSymbolCollection() = #externalMacro(module: "SymbolMacros", type: "SFSymbolCollectionMacro")

@attached(member, names: arbitrary)
public macro ImageAssetCollection() = #externalMacro(module: "SymbolMacros", type: "ImageAssetCollectionMacro")

@attached(peer)
public macro ImageAsset() = #externalMacro(module: "SymbolMacros", type: "ImageAssetMacro")

@available(macOS 11.0, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
@attached(peer)
public macro SFSymbol() = #externalMacro(module: "SymbolMacros", type: "SFSymbolMacro")
