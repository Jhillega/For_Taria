//
//  TitleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

// Splash/title screen shown on first launch. `launched` is bound to ContentView's
// isShowingTitle; ShinyButtonView toggles it to true which dismisses this cover.
struct TitleView: View {
    @Binding var launched: Bool
    
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .padding()
            Text("My Gift for Taria \nA Star Wars Reference.")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("An app by her Husband")
                .font(.subheadline)
                .italic()
                .opacity(0.66)
            Spacer()
            Text("Continue")
                .frame(width: 200, height: 50)
                .padding()
                .foregroundStyle(.yellow)
                .background(
                    ShinyButtonView(actionComplete: $launched)
                )
                .padding()
            Spacer()
            Spacer()
            Spacer()
        }
        .background(Color.black)
        .foregroundColor(.yellow)
    }
}

#Preview {
    @Previewable @State var launched: Bool = false
    TitleView(launched: $launched)
}
