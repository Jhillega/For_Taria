//
//  PlanetsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PlanetListView: View {
    @State private var planets: [Planet]? = nil
    @State private var planetInFocus: Bool = false
    @State private var selectedPlanet: Planet? = nil
    let planetRepo = SwapiPlanetRepository()
    
    var body: some View {
        ZStack {
            List {
                ForEach(planets ?? [Planet](), id: \.id) { planet in
                    PlanetListViewCell(planet: planet)
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            self.selectedPlanet = planet
                            withAnimation {
                                planetInFocus.toggle()
                            }
                        }
                }
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    planets = try await planetRepo.fetch()
                }
            }

            
            // Overlay the detail view on top of the list rather than navigating away,
            // so the blur-replace transition reads as an in-place reveal.
            if planetInFocus {
                ScrollView {
                    // Falls back to MockService.testPlanet if selectedPlanet is somehow nil.
                    PlanetFocusView(isPresented: $planetInFocus, planet: selectedPlanet ?? MockService.testPlanet)
                        .frame(width: 400, height: 800, alignment: .center)
                        .foregroundStyle(.yellow)
                        .background(.black)
                        .onTapGesture(perform: {
                            withAnimation() {
                                planetInFocus.toggle()
                            }
                        })
                }
                .transition(.blurReplace)
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
