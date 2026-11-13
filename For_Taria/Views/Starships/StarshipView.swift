//
//  StarshipView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/12/26.
//

import SwiftUI

struct StarshipView: View {
    @Binding var isPresented: Bool
    let starship: Starship

    private var details: [(label: String, value: String)] {
        [
            ("Model", starship.model),
            ("Class", starship.starshipClass),
            ("Manufacturer", starship.manufacturer),
            ("Cost in Credits", starship.costInCredits),
            ("Length", starship.length),
            ("Max Speed", starship.maxAtmospheringSpeed),
            ("Crew", starship.crew),
            ("Passengers", starship.passengers),
            ("Cargo Capacity", starship.cargoCapacity),
            ("Consumables", starship.consumables),
            ("Hyperdrive Rating", starship.hyperdriveRating),
            ("MGLT", starship.mglt)
        ]
    }

    var body: some View {
        VStack {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .scaledToFit()
            Text(starship.name)
                .font(.largeTitle)
                .bold()
            ScrollView {
                ForEach(details, id: \.label) { detail in
                    Text("\(detail.label):\n \(detail.value)")
                        .fontWeight(.bold)
                        .font(.title)
                        .lineSpacing(10)
                        .padding()
                        .frame(width: 300)
                }
            }

            Button(
                action: { isPresented.toggle() },
                label: { Text("Close") }
            )
        }
    }
}

#Preview {
    @Previewable @State var isPresented: Bool = true
    StarshipView(isPresented: $isPresented, starship: SwapiFormattingData.starship)
}
