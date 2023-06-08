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
                    let result = await service.fetch_Vehicles_FromAGalaxyFarFarAway()
                    switch result {
                    case .success(let vehicleReturn):
                        vehicles = vehicleReturn.results
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
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
