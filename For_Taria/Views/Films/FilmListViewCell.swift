//
//  FilmSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct FilmListViewCell: View {
    let film: Film
    
    var body: some View {
        HStack {
            Image(film.imageName)
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading) {
                Text(film.name)
                    .font(.title3)
                Group {
                    Text("Episode: \(film.episodeID)")
                    Text("directed by: \(film.director)")
                    Text("released: \(film.releaseDate)")
                }
                .font(.subheadline)
            }
            Spacer()
        }
        .frame(height: 100.00)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

extension Film {
    // Maps SWAPI episode number to the corresponding asset catalog image name.
    // Shared by FilmListViewCell and FilmView so both show the same poster.
    var imageName: String {
        switch episodeID {
        case 1: return "episode_one"
        case 2: return "episode_two"
        case 3: return "episode_three"
        case 4: return "episode_four"
        case 5: return "episode_five"
        case 6: return "episode_six"
        case 7: return "episode_seven"
        default: return ""
        }
    }
}

struct FilmSoloView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListViewCell(film: SwapiFormattingData.film)
    }
}
