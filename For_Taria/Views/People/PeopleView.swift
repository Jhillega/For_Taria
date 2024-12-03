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
    var peopleRepo = SWAPIPeopleRepository()
    
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
            .listStyle(.plain)
            .onAppear() {
                Task {
                    results = try await peopleRepo.fetch()
                }
            }
            .background(Color.black)
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
