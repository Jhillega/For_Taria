//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @State var results: [Person]?
    let repo = SWAPIRepository()
    
    init() {
            // Tint the nav bar title yellow to match the Star Wars theme.
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow
            ]
        }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            if let results {
                List(results) { result in
                    PeopleViewCell(person: result)
                        .listRowBackground(Color.black)
                }
                .listStyle(.plain)
                .background(Color.black)
                .foregroundColor(.yellow)
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.yellow)
                    .scaleEffect(3)
            }
        }
        .task {
            do {
                results = try await repo.fetch(for: .people) as? [Person]
            } catch {
                print("Failed to fetch people: \(error)")
            }
        }
        .navigationBarTitle(ResourceCategory.people.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleView()
    }
}
