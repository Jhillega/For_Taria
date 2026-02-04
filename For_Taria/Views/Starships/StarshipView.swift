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
        HStack {
            Image(systemName: "gear")
                .resizable()
                .frame(height: 100)
                .frame(width: 100)
            VStack(alignment: .leading) {
                Text(starship.name)
                    .bold()
                    .padding(.vertical)
                Text(starship.model)
                Text(starship.starshipClass)
            }
        }
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct StarshipView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipView(starship: SwapiFormattingData.starship)
    }
}
