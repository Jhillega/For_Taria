//
//  VehicleListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct VehicleListView: View {
    @StateObject var vehicleVM = StarWarsVehicleDataModel()
    @State private var vehicles = [Vehicle]()
    
    var body: some View {
        VStack {
            Text(ResourceCategory.vehicles.rawValue.localizedCapitalized)
                .font(.largeTitle)
                .bold()
                .padding()
            List {
                ForEach(vehicles, content: { vehicle in
                    VehicleSoloView(vehicle: vehicle)
                })
            }
            .onAppear {
                Task {
                    vehicles = await vehicleVM.fetchVehiclesFromAGalaxyFarFarAway() ?? []
                }
            }
        }
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
