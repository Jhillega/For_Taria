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
            let imageString = selectCorrectFilmImageString(for: film.episodeID)
            Image(imageString)
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
    
    
    func selectCorrectFilmImageString(for film: Int) -> String {
        var imageString = ""
        
        switch film {
        case 1:
            imageString = films.episode_one.rawValue
        case 2:
            imageString = films.episode_two.rawValue
        case 3:
            imageString = films.episode_three.rawValue
        case 4:
            imageString = films.episode_four.rawValue
        case 5:
            imageString = films.episode_five.rawValue
        case 6:
            imageString = films.episode_six.rawValue
        case 7:
            imageString = films.episode_seven.rawValue
        default:
            imageString = ""
        }
        
        return imageString
    }
    
    private enum films: String {
        case episode_one = "episode_one"
        case episode_two = "episode_two"
        case episode_three = "episode_three"
        case episode_four = "episode_four"
        case episode_five = "episode_five"
        case episode_six = "episode_six"
        case episode_seven = "episode_seven"
    }
}

struct FilmSoloView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListViewCell(film: SwapiFormattingData.film)
    }
}
