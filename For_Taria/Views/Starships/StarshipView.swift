//
//  StarshipView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct StarshipView: View {
    let starship: Starship
    
    var body: some View {
        VStack {
            Text(starship.name)
                .bold()
                .padding()
            Text(starship.model)
            Text(starship.starshipClass)
        }
    }
}

struct StarshipView_Previews: PreviewProvider {
    static var previews: some View {
        StarshipView(starship: Starship(name: "Test Ship",
                                        model: "Testy Testerson",
                                        manufacturer: "Me",
                                        costInCredits: "5600000",
                                        length: "120",
                                        maxAtmospheringSpeed: "664",
                                        crew: "Awesome",
                                        passengers: "0",
                                        cargoCapacity: "0",
                                        consumables: "0",
                                        hyperdriveRating: "0",
                                        mglt: "0",
                                        starshipClass: "Test Fleet Ship",
                                        pilots: [""],
                                        films: [""],
                                        created: "",
                                        edited: "",
                                        url: ""))
    }
}
