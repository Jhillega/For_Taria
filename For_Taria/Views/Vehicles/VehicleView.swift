//
//  VehicleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/12/26.
//

import SwiftUI

struct VehicleView: View {
    @Binding var isPresented: Bool
    let vehicle: Vehicle

    private var details: [(label: String, value: String)] {
        [
            ("Model", vehicle.model),
            ("Class", vehicle.vehicleClass),
            ("Manufacturer", vehicle.manufacturer),
            ("Cost in Credits", vehicle.costInCredits),
            ("Length", vehicle.length),
            ("Max Speed", vehicle.maxAtmospheringSpeed),
            ("Crew", vehicle.crew),
            ("Passengers", vehicle.passengers),
            ("Cargo Capacity", vehicle.cargoCapacity),
            ("Consumables", vehicle.consumables)
        ]
    }

    var body: some View {
        VStack {
            Image(systemName: "gear")
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .scaledToFit()
            Text(vehicle.name)
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
    VehicleView(isPresented: $isPresented, vehicle: SwapiFormattingData.vehicle)
}
