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
            // drawingGroup() flattens the view hierarchy into a single texture before the
            // distortion shader samples it; without this, child views render independently
            // and the shader cannot displace pixels across view boundaries.
            .drawingGroup()
            .distortionEffect(
                ShaderLibrary.distortion(),
                maxSampleOffset: CGSize(width: 100, height: 0)
            )
    }
}
