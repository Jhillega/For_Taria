//
//  FilmsListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmsListView: View {
    @State private var films = [Film]()
    let filmRepo = SwapiFilmRepository()
    
    var body: some View {
            VStack {
                List {
                    ForEach(films, content: { film in
                        FilmListViewCell(film: film)
                            .listRowBackground(Color.black)
                    })
                }
                .listStyle(.plain)
                .onAppear {
                    Task {
                        films = try await filmRepo.fetch()
                    }
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
