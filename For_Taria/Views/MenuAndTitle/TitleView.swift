//
//  TitleView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/23.
//

import SwiftUI

struct TitleView: View {
    @Environment(\.dismiss) var dismiss
    
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
            Button(action: {
                dismiss()
            }, label: {
                Text("Continue")
                    .padding()
                    .foregroundStyle(.black)
                    .background(
                        RoundedRectangle(cornerSize: CGSize(width: 50, height: 30), style: .continuous)
                    )
            })
            .padding()
            Spacer()
            Spacer()
            Spacer()
        }
        .background(Color.black)
        .foregroundColor(.yellow)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
