//
//  FilmsListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmsListView: View {
    @State private var films = [Film]()
    @State private var filmInFocus = false
    @State private var selectedFilm: Film?
    let filmRepo = SwapiFilmRepository()
    
    var body: some View {
            ZStack {
                List {
                    ForEach(films, content: { film in
                        FilmListViewCell(film: film)
                            .listRowBackground(Color.black)
                            .onTapGesture {
                                selectedFilm = film
                                withAnimation {
                                    filmInFocus = true
                                }
                            }
                    })
                }
                .listStyle(.plain)
                .task {
                    do {
                        films = try await filmRepo.fetch()
                    } catch {
                        print("Failed to fetch films: \(error)")
                    }
                }

                // Overlay the detail view in place, mirroring PlanetListView.
                if filmInFocus, let selectedFilm {
                    ScrollView {
                        FilmView(isPresented: $filmInFocus, film: selectedFilm)
                            .frame(width: 400, height: 800, alignment: .center)
                            .foregroundStyle(.yellow)
                            .background(.black)
                    }
                    .background(Color.black)
                    .transition(.blurReplace)
                }
            }
            .navigationBarTitle(ResourceCategory.films.rawValue.localizedCapitalized, displayMode: .inline)
            .foregroundColor(Color.yellow)
            .background(Color.black.ignoresSafeArea(.all))
    }
    
    init() {
        // UIAppearance must be set before the view appears; required for pre-iOS 16
        // list background and separator styling that SwiftUI modifiers don't reach.
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().backgroundColor = .black
    }
}

struct FilmsListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsListView()
    }
}
