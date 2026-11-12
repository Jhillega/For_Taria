//
//  VehicleSoloView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct VehicleListViewCell: View {
    let vehicle: Vehicle
    var imageHeight: CGFloat = 100
    var imageWidth: CGFloat = 100
    
    var body: some View {
        HStack {
            Image(systemName: "gear")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading) {
                Text(vehicle.name ?? "MISSING DATA")
                    .font(.title2)
                    .bold()
                    .padding(.vertical)
                Text(vehicle.model ?? "MISSING DATA")
                Text(vehicle.manufacturer ?? "MISSING DATA")
            }
            .multilineTextAlignment(.leading)
        }
        .frame(height: imageHeight)
    }
}

struct VehicleSoloView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListViewCell(vehicle: SwapiFormattingData.vehicle)
    }
}
