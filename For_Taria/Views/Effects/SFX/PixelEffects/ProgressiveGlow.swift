//
//  ProgressiveGlow.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//
import SwiftUI

// Drives the Metal glow shader from a touch origin; progress animates from 0→1
// to reveal the glow radially outward from the touch point.
struct ProgressiveGlow: ViewModifier {
    let origin: CGPoint
    let progress: CGFloat
    
    func body(content: Content) -> some View {
        content.visualEffect { view, proxy in
            view.colorEffect(ShaderLibrary.default.glow(
                .float2(origin),
                .float2(proxy.size),
                .float(3.0),
                .float(progress)
            )
        )
        }
    }
}
