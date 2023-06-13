//
//  FilmSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmSoloView: View {
    let film: Film
    
    var body: some View {
        VStack {
            Text(film.title)
                .font(.largeTitle)
            Text("Episode: \(film.episodeID)")
            Text("directed by: \(film.director)")
            Text("released: \(film.releaseDate)")
        }
    }
}

struct FilmSoloView_Previews: PreviewProvider {
    static var previews: some View {
        FilmSoloView(film: SwapiFormattingData.film)
    }
}
