//
//  PeopleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct PeopleView: View {
    @State var results: [Person]?
    @State private var personInFocus = false
    @State private var selectedPerson: Person?
    let peopleRepo = SWAPIPeopleRepository()
    
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
                        .onTapGesture {
                            selectedPerson = result
                            withAnimation {
                                personInFocus = true
                            }
                        }
                }
                .listStyle(.plain)
                .background(Color.black)
                .foregroundColor(.yellow)

                // Overlay the detail view in place, mirroring PlanetListView.
                if personInFocus, let selectedPerson {
                    ScrollView {
                        PersonView(isPresented: $personInFocus, person: selectedPerson)
                            .frame(width: 400, height: 800, alignment: .center)
                            .foregroundStyle(.yellow)
                            .background(.black)
                    }
                    .background(Color.black)
                    .transition(.blurReplace)
                }
            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.yellow)
                    .scaleEffect(3)
            }
        }
        .task {
            do {
                results = try await peopleRepo.fetch(individual: true)
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
