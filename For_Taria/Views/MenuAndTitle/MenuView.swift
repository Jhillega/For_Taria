//
//  MenuView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct MenuView: View {
    @State private var showingTitle = true
//    @State private var searchTerm: String = ""
    @State private var presentPeople = false
    @State private var presentFilms = false
    @State private var presentStarships = false
    @State private var presentPlanets = false
    @State private var presentSpecies = false
    @State private var presentVehicles = false
    
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Text("What are you looking for?")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .multilineTextAlignment(.center)
                    .padding()
                VStack {
                    ForEach(ResourceCategory.allCases, id: \.rawValue) { item in
                        Button(item.rawValue) {
//                            searchTerm = item.rawValue
                            print("\(item.rawValue) button tapped")
                            switch item.rawValue {
                            case ResourceCategory.people.rawValue:
                                presentPeople = true
                            case ResourceCategory.planets.rawValue:
                                presentPlanets = true
                            case ResourceCategory.starships.rawValue:
                                presentStarships = true
                            case ResourceCategory.films.rawValue:
                                presentFilms = true
                            case ResourceCategory.species.rawValue:
                                presentSpecies = true
                            case ResourceCategory.vehicles.rawValue:
                                presentVehicles = true
                            default:
                                presentPeople = true
                            }
                            
                        }
                        .font(.body)
                        .foregroundColor(.yellow)
                    }
                    .background(Color.black)
                }
                .sheet(isPresented: $presentVehicles,
                       content: {
                    VehicleListView()
                })
                .sheet(isPresented: $presentSpecies,
                       content: {
                    SpeciesListView()
                })
                .sheet(isPresented: $presentFilms,
                       content: {
                    FilmsListView()
                })
                .sheet(isPresented: $presentStarships,
                       content: {
                    StarshipsView()
                })
                .sheet(isPresented: $presentPeople,
                       content: {
                    PeopleView()
                })
                .sheet(isPresented: $presentPlanets,
                       content: {
                    PlanetsView()
                })
                .fullScreenCover(isPresented: $showingTitle,
                                 onDismiss: nil) {
                    TitleView()
                }
            }
        }
        .tint(Color.purple)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
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
