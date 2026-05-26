//
//  WalkingManView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/25/25.
//

import SwiftUI

struct WalkingManView: View {
    
    @State private var start = Date.now
    @State private var touchPoint = CGPoint.zero
    
    var body: some View {
        TimelineView(.animation) { tl in            
            Image(systemName: "figure.walk.circle")
                .font(.system(size: 300))
                .foregroundStyle(.blue)
                // loupe shader magnifies pixels in a circular region around the touch point.
                .visualEffect { [touchPoint] content, proxy in
                    content
                        .layerEffect(ShaderLibrary.loupe(
                            .float2(proxy.size),
                            .float2(touchPoint)
                        ), maxSampleOffset: .zero)
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged({ touchPoint = $0.location })
                )
        }
    }
}

#Preview {
    WalkingManView()
}
