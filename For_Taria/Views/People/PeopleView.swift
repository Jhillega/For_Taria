//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @State private var results = [Person]()
    
    var body: some View {
        VStack {
            Text("Rogues & Heroes")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(results, id: \.id) { person in
                    PersonView(person: person)
                }
            }
            .onAppear() {
                StarWarsPersonDataModel().fetchPeopleFromAGalaxyFarFarAway { results in
                    self.results = results
                }
            }
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
