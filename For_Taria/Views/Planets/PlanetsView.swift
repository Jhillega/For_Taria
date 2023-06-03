//
//  PlanetsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetsView: View {
    @State private var planets = [Planet]()
    @StateObject var vm = StarWarsPlanetsDataModel()
    
    var body: some View {
        VStack {
            Text("Planets")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(planets, id: \.id) { planet in
                    PlanetView(planet: planet)
                }
            }
            .onAppear {
                Task {
                    planets = await vm.fetchPlanetsFromAGalaxyFarFarAway()
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
