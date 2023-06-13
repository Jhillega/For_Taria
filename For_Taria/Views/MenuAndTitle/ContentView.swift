//
//  ContentView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isShowingTitle = true
    
    var body: some View {
        VStack {
            CategoryView()
        }
        .fullScreenCover(isPresented: $isShowingTitle, onDismiss: nil, content: {
            TitleView()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
