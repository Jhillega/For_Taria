//
//  VehicleListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct VehicleListView: View {
    @State private var vehicles = [Vehicle]()
    let service = SWAPIService()
    let vehicleRepo = SwapiVehicleRepository()
    
    var body: some View {
        VStack {
            Text(ResourceCategory.vehicles.rawValue.localizedCapitalized)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(vehicles, content: { vehicle in
                    VehicleListViewCell(vehicle: vehicle)
                        .listRowBackground(Color.black)
                })
            }
            .listStyle(.plain)
            .onAppear {
                Task {
                    vehicles = try await vehicleRepo.fetch()
                }
            }
        }
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
