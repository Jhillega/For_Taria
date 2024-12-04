//
//  StarshipsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipsView: View {
    @State private var starships = [Starship]()
    let starshipRepo = SwapiStarshipRepository()
    
    var body: some View {
        VStack {
            Text("Starships")
                .font(.largeTitle)
                .bold()
                .padding()
            List(starships) { starship in
                StarshipView(starship: starship)
                    .listRowBackground(Color.black)
            }
            .listStyle(.plain)
        }
        .onAppear {
            Task {
                starships = try await starshipRepo.fetch()
            }
        }
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct StarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsView()
    }
}
