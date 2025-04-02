//
//  PlanetFocusView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/28/25.
//

import SwiftUI

public struct PlanetFocusView: View {
    
    var planet: Planet?
    
    public var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 300, height: 400, alignment: .center)
                .scaledToFit()
            Text("PlanetFocusView for \(planet?.name ?? "Unknown")")
        }
    }
}


#Preview {
    PlanetFocusView()
}
