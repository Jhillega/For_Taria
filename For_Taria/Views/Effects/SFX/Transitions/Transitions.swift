//
//  Transitions.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/26/25.
//

import SwiftUI

struct BlurTransition: ViewModifier {
    var progress = 0.0
    
    func body(content: Content) -> some View {
        content
            .blur(radius: progress * 10)
            .opacity(1 - progress)
            .clipped()
    }
}
