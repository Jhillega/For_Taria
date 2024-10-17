//
//  For_TariaApp.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

@main
struct For_TariaApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        loadRocketSimConnect()
    }

    var body: some Scene {
        WindowGroup {
            For_TariaMainView()
        }
    }
    
    private func loadRocketSimConnect() {
        #if DEBUG
        guard (Bundle(path: "/Applications/RocketSim.app/Contents/Frameworks/RocketSimConnectLinker.nocache.framework")?.load() == true) else {
            print("Failed to load linker framework")
            return
        }
        print("RocketSim Connect successfully linked")
        #endif
    }
}


