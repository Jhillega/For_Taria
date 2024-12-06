//
//  PlanetsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetListView: View {
    @State private var planets: [Planet]? = nil
    let planetRepo = SwapiPlanetRepository()
    
    var body: some View {
        VStack {
            List {
                ForEach(planets ?? [Planet](), id: \.id) { planet in
                    PlanetListViewCell(planet: planet)
                        .listRowBackground(Color.black)
                }
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    planets = try await planetRepo.fetch()
                }
            }
        }
        .navigationBarTitle(ResourceCategory.planets.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetListView()
    }
}
