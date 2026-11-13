//
//  SpeciesSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListViewCell: View {
    let species: Species
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .foregroundColor(species.accentColor)
                .padding()
            
            VStack(alignment: .leading) {
                Text(species.name)
                    .font(.title)
                    .bold()
                    .padding(.vertical)
                Text(species.language)
                Text(species.classification)
            }
            Spacer()
        }
        .frame(height: 150.00)
    }
}

extension Species {
    // Accent color derived from species designation for quick visual differentiation.
    // Shared by SpeciesListViewCell and SpeciesView.
    var accentColor: Color {
        switch designation {
        case .reptilian:
            return Color.green
        case .sentient:
            return Color.yellow
        }
    }
}

struct SpeciesSoloView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListViewCell(species: SwapiFormattingData.species)
    }
}
