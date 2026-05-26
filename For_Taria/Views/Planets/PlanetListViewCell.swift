//
//  PlanetView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetListViewCell: View {
    let planet: Planet
    // Maps climate string to a row color for quick visual variety in the list.
    // Unrecognized climates fall back to white.
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
            return .white
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "globe")
                .resizable()
                .scaledToFit()
                .foregroundColor(colorOfPlanet)
                .pixellationShader()
            VStack(alignment: .leading) {
                Text(planet.name)
                    .font(.title2)
                    .bold()
                    .padding(.vertical)
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
        .foregroundColor(.yellow)
        .background(Color.black)
        .frame(height: 150.00)
    }
}

struct PlanetView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListViewCell(planet: SwapiFormattingData.planet)
    }
}
