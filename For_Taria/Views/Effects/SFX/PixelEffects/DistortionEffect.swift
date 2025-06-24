//
//  DistortionEffect.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/23/25.
//

import SwiftUI

extension View {
    func distortionEffect() -> some View {
        modifier(DistortionEffect())
    }
}

struct DistortionEffect: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 10)
            .drawingGroup()
            .distortionEffect(
                ShaderLibrary.distortion(),
                maxSampleOffset: CGSize(width: 100, height: 0)
            )
    }
}
