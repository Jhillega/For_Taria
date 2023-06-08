//
//  PlanetsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetsView: View {
    @State private var planets: [Planet]? = nil
    let service = SWAPIService()
    
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
                    let result = await service.fetch_Planets_FromAGalaxyFarFarAway()
                    switch result {
                    case .success(let planetsReturned):
                        planets = planetsReturned.results.sorted { (lhs, rhs) in
                            lhs.name < rhs.name
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
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
