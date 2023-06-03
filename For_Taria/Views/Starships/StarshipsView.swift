//
//  StarshipsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipsView: View {
    @StateObject var starshipVM = StarWarsStarshipDataModel()
    
    @State private var starships = [Starship]()
    
    var body: some View {
        VStack {
            Text("Starships")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(starships, id: \.id) { starship in
                    VStack {
                        StarshipView(starship: starship)
                    }
                }
            }
            .onAppear {
                Task {
                    starships = await starshipVM.fetchStarshipsFromAGalaxyFarFarAway()
                }
            }
        }
    }
}

struct StarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsView()
    }
}
