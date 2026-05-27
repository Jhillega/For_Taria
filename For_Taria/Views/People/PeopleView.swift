//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @State var results: [Person]?
    let peopleRepo = SWAPIPeopleRepository()
    
    init() {
            // Tint the nav bar title yellow to match the Star Wars theme.
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow
            ]
        }
    
    var body: some View {
        VStack {
            List(results ?? []) { result in
                    PeopleViewCell(person: result)
                    .listRowBackground(Color.black)
            }
            .listStyle(.plain)
            .task {
                do {
                    results = try await peopleRepo.fetch(individual: true)
                } catch {
                    print("Failed to fetch people: \(error)")
                }
            }
            .background(Color.black)
        }
        .navigationBarTitle(ResourceCategory.people.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
