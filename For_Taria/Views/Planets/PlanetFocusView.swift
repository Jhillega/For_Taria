//
//  PlanetFocusView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/28/25.
//

import SwiftUI

public struct PlanetFocusView: View {
    
    var planet: Planet
    
    public var body: some View {
        VStack {
            Image(systemName: "globe")
                .resizable()
                .frame(width: 300, height: 400, alignment: .center)
                .scaledToFit()
            Text("PlanetFocusView for \(planet.name)")
            ForEach(Planet.displayablePropertyNames) { propertyName in
                Text("\(propertyName.displayablePropertyName): \(planet.dataForProperty(propertyName))")
            }
        }
    }
}


#Preview {
    PlanetFocusView(planet: MockService.testPlanet)
}
