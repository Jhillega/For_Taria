//
//  SpeciesListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListView: View {
    @State private var species = [Species]()
    let service = SWAPIService()
    
    var body: some View {
        VStack{
            Text(ResourceCategory.species.rawValue.localizedCapitalized)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(species, id: \.id) { speciesType in
                    VStack {
                        SpeciesListViewCell(species: speciesType)
                    }
                }
            }
            .onAppear {
                Task {
                    let result = await service.fetch_Species_FromAGalaxyFarFarAway()
                    switch result {
                    case .success(let speciesReturn):
                        species = speciesReturn.results.sorted { (lhs, rhs) in
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

struct SpeciesListView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListView()
    }
}
