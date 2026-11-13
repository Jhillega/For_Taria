//
//  StarshipsView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipsView: View {
    @State private var starships = [Starship]()
    @State private var starshipInFocus = false
    @State private var selectedStarship: Starship?
    let starshipRepo = SwapiStarshipRepository()
    
    var body: some View {
        ZStack {
            List(starships) { starship in
                StarshipViewCell(starship: starship)
                    .listRowBackground(Color.black)
                    .onTapGesture {
                        selectedStarship = starship
                        withAnimation {
                            starshipInFocus = true
                        }
                    }
            }
            .listStyle(.plain)

            // Overlay the detail view in place, mirroring PlanetListView.
            if starshipInFocus, let selectedStarship {
                ScrollView {
                    StarshipView(isPresented: $starshipInFocus, starship: selectedStarship)
                        .frame(width: 400, height: 800, alignment: .center)
                        .foregroundStyle(.yellow)
                        .background(.black)
                }
                .background(Color.black)
                .transition(.blurReplace)
            }
        }
        .task {
            do {
                starships = try await starshipRepo.fetch()
            } catch {
                print("Failed to fetch starships: \(error)")
            }
        }
        .navigationBarTitle(ResourceCategory.starships.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct StarshipsView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipsView()
    }
}
