//
//  ContentView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI
import CoreData

// App's root view: shows the category menu with the title splash overlaid on launch.
struct ContentView: View {
    // Starts true so the splash cover appears immediately; TitleView toggles it to false on dismiss.
    @State private var isShowingTitle = true
    
    var body: some View {
        CategoryView()
        .fullScreenCover(isPresented: $isShowingTitle, onDismiss: nil, content: {
            TitleView(launched: $isShowingTitle)
                .transition(.modifier(active: BlurTransition(progress: 100.0), identity: BlurTransition(progress: 0)))
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
