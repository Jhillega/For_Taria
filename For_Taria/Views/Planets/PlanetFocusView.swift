//
//  PlanetFocusView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/28/25.
//

import SwiftUI

public struct PlanetFocusView: View {
    @Binding public var isPresented: Bool
    var planet: Planet
    var scrollViewContent: String?
    public var body: some View {
        VStack {
            // pixellationShader() is decorative here — gives the globe a retro bitmap look.
            Image(systemName: "globe")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .scaledToFit()
                .pixellationShader()
            Text("PlanetFocusView for \(planet.name)")
            ScrollView {
                ForEach(Planet.displayablePropertyNames) { propertyName in
                    // TODO: - Add viewBuilder for scrolling info
                    // Star Wars Marquee Style
                    Text("\(propertyName.displayablePropertyName):\n \(planet.dataForProperty(propertyName))")
                        .fontWeight(.bold)
                        .font(.title)
                        .lineSpacing(10)
                        .padding()
                        .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                        .shadow(color: .yellow, radius: 2, x: 0, y: 15)
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
    PlanetFocusView(isPresented: $isPresented, planet: MockService.testPlanet)
}
