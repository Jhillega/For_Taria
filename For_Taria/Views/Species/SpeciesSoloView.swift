//
//  SpeciesSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct SpeciesSoloView: View {
    let species: Species
    
    var body: some View {
        VStack {
            Text(species.name)
                .font(.title)
                .bold()
                .padding()
            Text(species.language)
            Text(species.classification)
        }
        .multilineTextAlignment(.leading)
    }
}

struct SpeciesSoloView_Previews: PreviewProvider {
    static var previews: some View {
        SpeciesSoloView(species: Species(name: "Kerek",
                                         classification: "Biped",
                                         designation: .reptilian,
                                         averageHeight: "",
                                         skinColors: "",
                                         hairColors: "",
                                         eyeColors: "",
                                         averageLifespan: "",
                                         homeworld: "None of your business",
                                         language: "BO'stik",
                                         people: [""],
                                         films: [""],
                                         created: "",
                                         edited: "",
                                         url: ""))
    }
}
