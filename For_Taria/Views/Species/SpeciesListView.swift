//
//  SpeciesListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListView: View {
    @StateObject var speciesVM = StarWarsSpeciesDataModel()
    @State private var species = [Species]()
    
    var body: some View {
        VStack{
            Text(ResourceCategory.species.rawValue.localizedCapitalized)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(species, id: \.id) { speciesType in
                    VStack {
                        SpeciesSoloView(species: speciesType)
                    }
                }
            }
            .onAppear {
                Task {
                    species = await speciesVM.fetchSpeciesFromAGalaxyFarFarAway() ?? []
                }
            }
        }
    }
}

struct SpeciesListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
