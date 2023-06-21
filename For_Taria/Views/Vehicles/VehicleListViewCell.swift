//
//  VehicleSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct VehicleListViewCell: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack {
            Text(vehicle.name)
                .font(.title2)
                .bold()
                .padding()
            Text(vehicle.model)
            Text(vehicle.manufacturer)
        }
    }
}

struct VehicleSoloView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListViewCell(vehicle: SwapiFormattingData.vehicle)
    }
}
