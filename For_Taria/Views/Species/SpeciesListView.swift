//
//  SpeciesListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListView: View {
    @State private var species = [Species]()
    let speciesRepo = SwapiSpeciesRepository()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    List(species) { speciesType in
                        SpeciesListViewCell(species: speciesType)
                            .listRowBackground(Color.black)
                    }
                    .listStyle(.plain)
                    .onAppear {
                        Task {
                            species = try await speciesRepo.fetch()
                        }
                    }
                }
                .navigationBarTitle(ResourceCategory.species.rawValue.localizedCapitalized, displayMode: .inline)
                .foregroundColor(.yellow)
                .background(Color.black)
            }
        }
    }
}

struct SpeciesListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
