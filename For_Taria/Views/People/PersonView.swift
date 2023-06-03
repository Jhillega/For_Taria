//
//  PersonView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PersonView: View {
    let person: Person
    
    var body: some View {
        VStack {
            Text(person.name)
            Text("Birthday: " + person.birthYear)
        }
        .background(Color.black, alignment: .leading)
        .foregroundColor(.yellow)

    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person(name: "Dash Rendar",
                                  height: "66",
                                  mass: "55",
                                  hairColor: "",
                                  skinColor: "",
                                  eyeColor: "",
                                  birthYear: "",
                                  gender: .male,
                                  homeworld: "",
                                  films: [],
                                  species: [],
                                  vehicles: [],
                                  starships: [],
                                  created: "",
                                  edited: "",
                                  url: ""))
    }
}
