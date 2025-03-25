//
//  ParticleCloud.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

import SwiftUI
import MetalKit

struct Particle {
    let color: SIMD4<Float>
    let radius: Float
    let lifespan: Float
    let position: SIMD2<Float>
    let velocity: SIMD2<Float>
}

struct ParticleCloudInfo {
    let center: SIMD2<Float>
    let progress: Float
}

struct ParticleCloud: UIViewRepresentable {
    let center: CGPoint?
    let progress: Float
    
    private let metalView = MTKView()
    
    func makeUIView(context: Context) -> MTKView {
        context.coordinator.progress = progress
        
        return metalView
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {
        context.coordinator.progress = progress
        
        guard let center else { return }
        
        let bounds = uiView.bounds
        
        context.coordinator.center = CGPoint(
            x: center.x / bounds.width,
            y: center.y / bounds.height
        )
    }
    
    func makeCoordinator() -> Renderer {
        Renderer(metalView: metalView)
    }
}
