//
//  StarshipsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipsView: View {
    @State private var starships = [Starship]()
    let service = SWAPIService()
    
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
                let result = await service.fetch_Starships_FromAGalaxyFarFarAway()
                switch result {
                case .success(let returnedStarships):
                    starships = returnedStarships.results.sorted { (lhs, rhs) in
                        return lhs.name < rhs.name
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
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
