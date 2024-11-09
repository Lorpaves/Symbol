//
//  ContentView.swift
//  Example
//
//  Created by Lorpaves on 2024/11/9.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Symbols.sidebarLeft
            Symbols.sidebarRight
            Symbols.Assets.wallpaper
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

import Symbol

@SymbolCollection
struct Symbols {
    let sidebarRight = "sidebar.right"
    
    @ImageAssetCollection
    struct Assets {
        let wallpaper = "Wallpaper"
    }
    
    @SFSymbolCollection
    struct SFSymbols {
        let sidebarLeft = "sidebar.left"
    }
}
