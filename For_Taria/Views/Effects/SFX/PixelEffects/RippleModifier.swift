//
//  RippleModifier.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

import SwiftUI

struct RippleModifier: ViewModifier {
    let origin: CGPoint
    let elapsedTime: TimeInterval
    let duration: TimeInterval
    let amplitude: Double
    let frequency: Double
    let decay: Double
    let speed: Double
    
    func body(content: Content) -> some View {
        let shader = ShaderLibrary.default.ripple(
            .float2(origin),
            .float(elapsedTime),
            .float(amplitude),
            .float(frequency),
            .float(decay),
            .float(speed)
        )
        
        let maxSampleOffset = CGSize(
            width: amplitude,
            height: amplitude
        )
        
        let elapsedTime = elapsedTime
        let duration = duration
        
        content.visualEffect { view, _ in
            view.layerEffect(
                shader,
                maxSampleOffset: maxSampleOffset,
                // Disables the shader once the animation finishes so the view
                // stops paying the shader cost every frame.
                isEnabled: 0...duration ~= elapsedTime
            )
        }
    }
}
