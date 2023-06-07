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
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
            VStack{
                Text(person.name)
                    .font(.title)
                    .bold()
                    .padding()
                Text("Birthday: " + person.birthYear)}
        }
        .frame(height: 150.00)
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
                                  birthYear: "1998",
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
