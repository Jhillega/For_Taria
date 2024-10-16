//
//  SpeciesDetailView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/15/23.
//

import SwiftUI

struct SpeciesDetailView: View {
    let species: Species
    
    var body: some View {
        VStack {
            Text(species.name)
            Text(species.averageHeight)
            Text(species.averageLifespan)
            Text(species.classification)
            Text(species.designation.rawValue)
            Text(species.eyeColors)
            Text(species.hairColors)
        }
    }
}

struct SpeciesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesDetailView(species: SwapiFormattingData.species)
    }
}
