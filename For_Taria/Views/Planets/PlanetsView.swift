//
//  PlanetsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetsView: View {
    @StateObject var vm = StarWarsPlanetsDataModel()
    @State private var planets: [Planet]? = nil
    
    var body: some View {
        VStack {
            Text("Planets")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(planets ?? [Planet](), id: \.id) { planet in
                    PlanetView(planet: planet)
                }
            }
            .listStyle(.insetGrouped)
            .onAppear {
                Task {
                    await vm.fetchPlanetsFromAGalaxyFarFarAway()
                    let sortedPlanets = vm.currentFetchedPlanets?.sorted { (lhs, rhs) in
                        return lhs.name < rhs.name
                    }
                    self.planets = sortedPlanets
                }
            }
        }
    }
}

struct PlanetsView_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsView()
    }
}
