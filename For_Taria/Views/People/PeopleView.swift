//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @StateObject var peopleVM = StarWarsPersonDataModel()
    var results: [Person]? {
        get {
            return peopleVM.currentModels
        }
        set(newValue) {
            if let value = newValue {
                self.results = value
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Rogues & Heroes")
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(results ?? [], id: \.id) { person in
                    PersonView(person: person)
                }
            }
            .onAppear() {
                Task {
                    await peopleVM.searchPeopleFromAGalaxyFarFarAway()
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
