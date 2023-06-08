//
//  FilmsListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmsListView: View {
    @State private var films = [Film]()
    let service = SWAPIService()
    
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
                    let result = await service.fetch_FilmsAbout_FromAGalaxyFarFarAway()
                    switch result {
                    case .success(let filmResponse):
                        films = filmResponse.results
                    case .failure(let error):
                        print(error.localizedDescription)
                        films = []
                    }
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
