//
//  SpeciesSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesListViewCell: View {
    let species: Species
    // Row accent color derived from species designation for quick visual differentiation.
    var characterColor: Color {
        switch species.designation {
        case .reptilian:
            return Color.green
        case .sentient:
            return Color.yellow
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .foregroundColor(characterColor)
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

struct SpeciesSoloView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesListViewCell(species: SwapiFormattingData.species)
    }
}
