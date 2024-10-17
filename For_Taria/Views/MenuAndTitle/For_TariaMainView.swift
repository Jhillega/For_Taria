//
//  TariaTabView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 10/16/24.
//

import SwiftUI

struct For_TariaMainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Category", systemImage: "list.dash")
                }
            SearchView()
                .tabItem {
                    Label("Ad Hoc Search", systemImage: "square.and.pencil")
                }
        }
        .tint(.yellow)
    }
}

#Preview {
    For_TariaMainView()
}
