//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @State var results: [Person]?
    var service = SWAPIService()
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow
            ]
        }
    
    var body: some View {
        VStack {
            Text(ResourceCategory.people.rawValue.localizedCapitalized)
                .font(.largeTitle)
                .bold()
                .padding()
            List(results ?? []) { result in
                    PeopleViewCell(person: result)
                    .listRowBackground(Color.black)
            }
            .onAppear() {
                Task {
                    let result = await service.fetch_People_FromAGalaxyFarFarAway()
                    var people: [Person]
                    switch result {
                    case .success(let peopleResponse):
                        people = peopleResponse.results.sorted { (lhs, rhs) in
                            lhs.name < rhs.name
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        people = []
                    }
                    
                    results = people
                }
            }
        }
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
