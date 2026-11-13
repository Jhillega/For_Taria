//
//  FilmView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/12/26.
//

import SwiftUI

struct FilmView: View {
    @Binding var isPresented: Bool
    let film: Film

    private var details: [(label: String, value: String)] {
        [
            ("Episode", String(film.episodeID)),
            ("Director", film.director),
            ("Producer", film.producer),
            ("Release Date", film.releaseDate),
            ("Opening Crawl", film.openingCrawl.replacingOccurrences(of: "\r\n", with: " "))
        ]
    }

    var body: some View {
        VStack {
            Image(film.imageName)
                .resizable()
                .scaledToFit()
                // Poster takes ~35% of the screen height (the enclosing scroll view fills the screen).
                .containerRelativeFrame(.vertical) { length, _ in length * 0.35 }
            Text(film.name)
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            ScrollView {
                ForEach(details, id: \.label) { detail in
                    Text("\(detail.label):\n \(detail.value)")
                        .fontWeight(.bold)
                        .font(.title)
                        .lineSpacing(10)
                        .padding()
                        .frame(width: 300)
                }
            }

            Button(
                action: { isPresented.toggle() },
                label: { Text("Close") }
            )
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    FilmView(isPresented: $isPresented, film: SwapiFormattingData.film)
}
