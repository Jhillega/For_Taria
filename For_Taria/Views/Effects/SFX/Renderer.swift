//
//  Renderer.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

import MetalKit
import SwiftUI

final class Renderer: NSObject {
    
    var center = CGPoint(x: 0.5, y: 0.5)
    
    var progress: Float = 0.0 {
        didSet {
            metalView?.isPaused = progress == .zero
        }
    }
    
    private weak var metalView: MTKView?
    
    private let commandQueue: MTLCommandQueue
    
    private let cleanState: MTLComputePipelineState
    private let drawState: MTLComputePipelineState
    
    private var particleBuffer: MTLBuffer!
    
    var particleCount: Int = 32
    
    var colors: [SIMD4<Float>] = Array(
        repeating: .init(
            Float.random(in: 0..<0.3),
            Float.random(in: 0.3..<0.7),
            Float.random(in: 0.7..<1.0), 1.0),
        count: 3
        )
    
    
    init(metalView: MTKView) {
        self.metalView = metalView
        
        guard
            let device = MTLCreateSystemDefaultDevice(),
            let commandQueue = device.makeCommandQueue()
                else {
            fatalError("Metal is not available")
        }
        
        self.commandQueue = commandQueue
        
        do {
            let library = try device.makeDefaultLibrary(bundle: .main)
            
            let clearFunc = library.makeFunction(name: "cleanScreen")!
            let drawFunc = library.makeFunction(name: "drawParticles")!
            
            cleanState = try device.makeComputePipelineState(function: clearFunc)
            drawState = try device.makeComputePipelineState(function: drawFunc)
        }
        catch {
            fatalError("Library not available: \(error)")
        }
        
        super.init()
        
        let particles: [Particle] = (0..<particleCount).map { i in
            let vx = Float(5.0)
            let vy = Float(5.0)
            
            return Particle(
                color: colors[i % colors.count],
                radius: Float.random(in: 4..<30),
                lifespan: .zero,
                position: SIMD2<Float>(.zero, .zero),
                velocity: SIMD2<Float>(vx, vy)
            )
        }
        
        particleBuffer = device.makeBuffer(
            bytes: particles,
            length: MemoryLayout<Particle>.stride * particleCount
        )
        
        metalView.device = device
        metalView.delegate = self
        metalView.framebufferOnly = false
        metalView.backgroundColor = .clear
    }
}

extension Renderer: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        
    }
    
    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else { return }
        
        let texture = drawable.texture
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let commandEncoder = commandBuffer?.makeComputeCommandEncoder()
        
        commandEncoder?.setTexture(texture, index: 0)
        
        // set clean state
        commandEncoder?.setComputePipelineState(cleanState)
        
        let w = cleanState.threadExecutionWidth
        let h = cleanState.maxTotalThreadsPerThreadgroup / w
        
        commandEncoder?.dispatchThreads(
            MTLSize(
                width: texture.width,
                height: texture.height,
                depth: 1
            ),
            threadsPerThreadgroup: MTLSize(
                width: w,
                height: h,
                depth: 1
            )
        )
        
        // set draw state
        commandEncoder?.setComputePipelineState(drawState)
        
        commandEncoder?.setBuffer(
            particleBuffer,
            offset: 0,
            index: 0
        )
        
        var info = ParticleCloudInfo(
            center: SIMD2<Float>(Float(center.x), Float(center.y)),
            progress: progress
        )
        
        commandEncoder?.setBytes(
            &info,
            length: MemoryLayout<ParticleCloudInfo>.stride,
            index: 1
        )
        
        commandEncoder?.dispatchThreads(
            MTLSize(width: particleCount, height: 1, depth: 1),
            threadsPerThreadgroup: MTLSize(width: drawState.threadExecutionWidth, height: 1, depth: 1)
        )
        
        commandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
}
