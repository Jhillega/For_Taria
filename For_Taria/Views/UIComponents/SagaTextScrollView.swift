//
//  SagaTextScrollView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/25/25.
//

import SwiftUI

struct SagaTextScrollView: View {
    
    @Binding var textInput: String
        
    var body: some View {
        
        ScrollView {
            Text(textInput)
                .fontWeight(.bold)
                .font(.title)
                .lineSpacing(10)
                .padding()
                .rotation3DEffect(.degrees(60), axis: (x: 1, y: 0, z: 0))
                .shadow(color: .yellow, radius: 2, x: 0, y: 15)
                .frame(width: 300)
        }
    }
    
    
}

#Preview {
    @Previewable @State var textInput: String = "Long text goes here,\nLong text goes here,\n Long text goes here"
    SagaTextScrollView(textInput: $textInput)
}
