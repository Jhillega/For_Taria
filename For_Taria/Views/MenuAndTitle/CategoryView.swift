//
//  CategoryView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/13/23.
//

import SwiftUI

struct CategoryView: View {
    
    init() {
            //Use this if NavigationBarTitle is with displayMode = .inline
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
                                           label: { Text(resourceCategory.rawValue) })
                        case .planets:
                            NavigationLink(destination: PlanetsView(),
                                           label: { Text(resourceCategory.rawValue) })
                        case .starships:
                            NavigationLink(destination: StarshipsView(),
                                           label: { Text(resourceCategory.rawValue) })
                        case .films:
                            NavigationLink(destination: FilmsListView(),
                                           label: { Text(resourceCategory.rawValue) })
                        case .species:
                            NavigationLink(destination: SpeciesListView(),
                                           label: { Text(resourceCategory.rawValue) })
                        case .vehicles:
                            NavigationLink(destination: VehicleListView(),
                                           label: { Text(resourceCategory.rawValue) })
                        }
                    }
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
