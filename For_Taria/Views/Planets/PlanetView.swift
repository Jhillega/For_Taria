//
//  PlanetView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetView: View {
    let planet: Planet
    var colorOfPlanet: SwiftUI.Color {
        switch planet.climate {
        case "arid":
            return .yellow
        case "temperate":
            return .green
        case "murky":
            return .mint
        case "frozen":
            return .blue
        default:
            return .black
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(colorOfPlanet)
                .padding()
            VStack {
                Text(planet.name)
                    .font(.title2)
                    .bold()
                    .padding()
                Text("Climate: " + planet.climate)
                    .font(.body)
                Text("Orbital period: " + planet.orbitalPeriod)
                    .font(.body)
                Text("Gravity: " + planet.gravity)
                    .font(.body)
            }
            Spacer()
            Spacer()
        }
        .frame(height: 150.00)
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetView(planet: Planet(name: "Earth",
                                  rotationPeriod: "24 hours",
                                  orbitalPeriod: "365 Days",
                                  diameter: "",
                                  climate: "temperate",
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
