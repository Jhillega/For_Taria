//
//  PlanetView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetView: View {
    let planet: Planet
    
    var body: some View {
        VStack {
            Text(planet.name)
                .padding()
            Text("Climate: " + planet.climate)
            Text("Orbital period: " + planet.orbitalPeriod)
            Text("Gravity: " + planet.gravity)
        }
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView(planet: Planet(name: "Earth",
                                  rotationPeriod: "24 hours",
                                  orbitalPeriod: "365 Days",
                                  diameter: "",
                                  climate: "Continental",
                                  gravity: "-9.86",
                                  terrain: "Gaia",
                                  surfaceWater: "Awesome",
                                  population: "9 billion",
                                  residents: [],
                                  films: [],
                                  created: "",
                                  edited: "",
                                  url: ""))
    }
}
