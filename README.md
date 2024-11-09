### Usage

```swift

import Symbol
import SwiftUI

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


struct ContentView: View {
    var body: some View {
        VStack {
            Symbols.sidebarLeft
            Symbols.sidebarRight
            Image(uiImage: Symbols.sidebarRight_UIImage)
            Symbols.Assets.wallpaper
        }
        .padding()
    }
}

```
