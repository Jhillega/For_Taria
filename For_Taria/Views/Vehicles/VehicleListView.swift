//
//  VehicleListView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/2/23.
//

import SwiftUI

struct VehicleListView: View {
    @State private var vehicles = [Vehicle]()
    @State private var vehicleInFocus = false
    @State private var selectedVehicle: Vehicle?
    let service = SWAPIService()
    let vehicleRepo = SwapiVehicleRepository()
    
    var body: some View {
        ZStack {
            List {
                ForEach(vehicles, content: { vehicle in
                    VehicleListViewCell(vehicle: vehicle)
                        .listRowBackground(Color.black)
                        .onTapGesture {
                            selectedVehicle = vehicle
                            withAnimation {
                                vehicleInFocus = true
                            }
                        }
                })
            }
            .listStyle(.plain)
            .task {
                do {
                    vehicles = try await vehicleRepo.fetch()
                } catch {
                    print("Failed to fetch vehicles: \(error)")
                }
            }

            // Overlay the detail view in place, mirroring PlanetListView.
            if vehicleInFocus, let selectedVehicle {
                ScrollView {
                    VehicleView(isPresented: $vehicleInFocus, vehicle: selectedVehicle)
                        .frame(width: 400, height: 800, alignment: .center)
                        .foregroundStyle(.yellow)
                        .background(.black)
                }
                .background(Color.black)
                .transition(.blurReplace)
            }
        }
        .navigationBarTitle(ResourceCategory.vehicles.rawValue.localizedCapitalized, displayMode: .inline)
        .foregroundColor(.yellow)
        .background(Color.black)
    }
}

struct VehicleListView_Previews: PreviewProvider {
    static var previews: some View {
        VehicleListView()
    }
}
