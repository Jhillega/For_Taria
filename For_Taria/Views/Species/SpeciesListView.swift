//
//  SpeciesListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListView: View {
    @State private var species = [Species]()
    @State private var speciesInFocus = false
    @State private var selectedSpecies: Species?
    let speciesRepo = SwapiSpeciesRepository()
    
    var body: some View {
        ZStack {
            List(species) { speciesType in
                SpeciesListViewCell(species: speciesType)
                    .listRowBackground(Color.black)
                    .onTapGesture {
                        selectedSpecies = speciesType
                        withAnimation {
                            speciesInFocus = true
                        }
                    }
            }
            .listStyle(.plain)
            .task {
                do {
                    species = try await speciesRepo.fetch()
                } catch {
                    print("Failed to fetch species: \(error)")
                }
            }

            // Overlay the detail view in place, mirroring PlanetListView.
            if speciesInFocus, let selectedSpecies {
                ScrollView {
                    SpeciesView(isPresented: $speciesInFocus, species: selectedSpecies)
                        .frame(width: 400, height: 800, alignment: .center)
                        .foregroundStyle(.yellow)
                        .background(.black)
                }
                .background(Color.black)
                .transition(.blurReplace)
            }
        }
        .navigationBarTitle(ResourceCategory.species.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct SpeciesListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
