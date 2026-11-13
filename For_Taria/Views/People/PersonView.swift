//
//  PersonView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 11/12/26.
//

import SwiftUI

struct PersonView: View {
    @Binding var isPresented: Bool
    let person: Person

    // Label/value pairs shown in the marquee-style scroll.
    private var details: [(label: String, value: String)] {
        [
            ("Birth Year", person.birthYear),
            ("Gender", person.gender?.rawValue),
            ("Height", person.height),
            ("Mass", person.mass),
            ("Hair Color", person.hairColor),
            ("Skin Color", person.skinColor),
            ("Eye Color", person.eyeColor)
        ].map { ($0.0, $0.1 ?? "unknown") }
    }

    var body: some View {
        VStack {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 200, height: 300, alignment: .center)
                .scaledToFit()
            Text(person.name ?? "Unknown")
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
    PersonView(isPresented: $isPresented, person: SwapiFormattingData.person)
}
