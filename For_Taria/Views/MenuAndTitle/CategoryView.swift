//
//  CategoryView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/13/23.
//

import SwiftUI

struct CategoryView: View {
    
    init() {
            UINavigationBar.appearance().titleTextAttributes = [
                .foregroundColor: UIColor.systemYellow,
            ]
        }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(ResourceCategory.allCases, id: \.rawValue) { resourceCategory in
                        switch resourceCategory {
                        case .people:
                            NavigationLink(destination: PeopleView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        case .planets:
                            NavigationLink(destination: PlanetListView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        case .starships:
                            NavigationLink(destination: StarshipsView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        case .films:
                            NavigationLink(destination: FilmsListView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        case .species:
                            NavigationLink(destination: SpeciesListView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        case .vehicles:
                            NavigationLink(destination: VehicleListView(),
                                           label: { Text(resourceCategory.rawValue.localizedCapitalized) })
                        }
                    }
                    .padding(.vertical, 10)
                }
                .navigationBarTitle("Menu", displayMode: .inline)
                .background(Color.black)
                .foregroundColor(Color.yellow)
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}

enum ResourceCategory: String, CaseIterable {
    case people = "people"
    case films = "films"
    case starships = "starships"
    case vehicles = "vehicles"
    case species = "species"
    case planets = "planets"
}
