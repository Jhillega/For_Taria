//
//  PixellationEffect.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/23/25.
//

import SwiftUI

extension View {
    func pixellationShader(pixelSize: Float = 8) -> some View {
        modifier(PixellationShader(pixelSize: pixelSize))
    }
}

struct PixellationShader: ViewModifier {
    
    let pixelSize: Float
    let startDate = Date()
    
    func body(content: Content) -> some View {
        // TimelineView drives continuous redraws; required for layer shaders
        // that need to re-sample on every frame.
        TimelineView(.animation) { _ in
            content
                .layerEffect(
                    ShaderLibrary.pixellate(
                        .float(pixelSize)
                    ), maxSampleOffset: .zero
                )
        }
    }
}
