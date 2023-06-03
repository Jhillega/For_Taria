//
//  FilmsListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmsListView: View {
    @StateObject var filmVM = StarWarsFilmDataModel()
    @State private var films = [Film]()
    
    var body: some View {
        VStack {
            Text("Episodes")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(films, content: { film in
                    FilmSoloView(film: film)
                })
            }
            .onAppear {
                Task {
                    films = await filmVM.fetchFilmsAboutAGalaxyFarFarAway() ?? []
                }
            }
        }
    }
}

struct FilmsListView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsListView()
    }
}
