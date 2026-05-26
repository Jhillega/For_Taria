//
//  TariaTabView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 10/16/24.
//

import SwiftUI

// Root tab bar hosting the category browser and ad-hoc search tabs.
struct For_TariaMainView: View {
    
    init() {
        // UITabBar.appearance() must be set before the view appears; init() is the
        // earliest safe point to apply global UIKit styling.
        UITabBar.appearance().barTintColor = .black
    }
    
    var body: some View {
        ContentView()
    }
}

#Preview {
    For_TariaMainView()
}
