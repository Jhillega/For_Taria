//
//  SpeciesView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/12/26.
//

import SwiftUI

struct SpeciesView: View {
    @Binding var isPresented: Bool
    let species: Species

    private var details: [(label: String, value: String)] {
        [
            ("Classification", species.classification),
            ("Designation", species.designation.rawValue),
            ("Language", species.language),
            ("Average Height", species.averageHeight),
            ("Average Lifespan", species.averageLifespan),
            ("Skin Colors", species.skinColors),
            ("Hair Colors", species.hairColors),
            ("Eye Colors", species.eyeColors)
        ]
    }

    var body: some View {
        VStack {
            Image(systemName: "person")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .scaledToFit()
                .foregroundColor(species.accentColor)
            Text(species.name)
                .font(.largeTitle)
                .bold()
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
    SpeciesView(isPresented: $isPresented, species: SwapiFormattingData.species)
}
