//
//  StarshipView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipView: View {
    let starship: Starship
    
    var body: some View {
        VStack {
            Text(starship.name)
                .bold()
                .padding()
            Text(starship.model)
            Text(starship.starshipClass)
        }
    }
}

struct StarshipView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipView(starship: SwapiFormattingData.starship)
    }
}
