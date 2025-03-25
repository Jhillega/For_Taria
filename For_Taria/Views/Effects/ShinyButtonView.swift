//
//  ShinyButtonView.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

import SwiftUI

struct ShinyButtonView: View {
    /// Color Button Effect
    
    private enum DragState {
        case inactive
        case dragging
    }
    
    @GestureState private var dragState: DragState = .inactive
    @State private var dragLocation: CGPoint?
    @State private var glowAnimationID: UUID?
    
    @State private var rippleAnimationID: UUID?
    @State private var rippleLocation: CGPoint?
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Capsule()
                    .fill(.black)
                    .keyframeAnimator(
                        initialValue: 0,
                        trigger: rippleAnimationID,
                        content: { view, elapsedTime in
                            view.modifier(RippleModifier(
                                origin: rippleLocation ?? .zero,
                                elapsedTime: elapsedTime,
                                duration: 1.0,
                                amplitude: 2.0,
                                frequency: 4.0,
                                decay: 10.0,
                                speed: 800.0))
                            
                        }, keyframes: { _ in
                            MoveKeyframe(.zero)
                            LinearKeyframe(1.0,
                                           duration: 2.0
                            )
                        }
                    )
                    .sensoryFeedback(
                        .impact,
                        trigger: rippleAnimationID
                    )
                KeyframeAnimator(
                    initialValue: 0.0,
                    trigger: glowAnimationID
                ) { value in
                    ParticleCloud(center: dragLocation,
                                  progress: Float(value)
                    )
                    .clipShape(Capsule())
                } keyframes: { _ in
                    if glowAnimationID != nil {
                        MoveKeyframe(.zero)
                        LinearKeyframe(
                            1.0,
                            duration: 0.4
                        )
                    } else {
                        LinearKeyframe(
                            .zero,
                            duration: 0.4
                        )
                    }
                }
                Capsule()
                    .strokeBorder(
                        Color.white,
                        style: .init(lineWidth: 1.0)
                    )
                Capsule()
                    .glow(fill: .palette, lineWidth: 4.0)
                    .keyframeAnimator(
                        initialValue: .zero,
                        trigger: glowAnimationID,
                        content: { view, elapsedTime in
                            view.modifier(
                                ProgressiveGlow(
                                    origin: dragLocation ?? .zero,
                                    progress: elapsedTime
                                )
                            )
                        },
                        keyframes: { _ in
                            if glowAnimationID != nil {
                                MoveKeyframe(.zero)
                                LinearKeyframe(
                                    1.0,
                                    duration: 0.4
                                )
                            } else {
                                MoveKeyframe(1.0)
                                LinearKeyframe(
                                    .zero,
                                    duration: 0.4
                                )
                            }
                        }
                    )
            }
            .gesture(
                  DragGesture(
                    minimumDistance: .zero
                  )
                  .updating(
                    $dragState,
                    body: { gesture, state, _ in
                        switch state {
                        case .inactive:
                            rippleAnimationID = UUID()
                            rippleLocation = gesture.location
                            dragLocation = gesture.location
                            glowAnimationID = UUID()
                            state = .dragging
                        case .dragging:
                            let location = gesture.location
                            let size = proxy.size
                            
                            dragLocation = CGPoint(x: location.x.clamp(min: .zero, max: size.width), y: location.y.clamp(min: .zero, max: size.height))
                        }
                    }
                  ).onEnded { _ in
                      glowAnimationID = nil
                  }
                )
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ShinyButtonView()
            .frame(
                width: 240, height: 100.0
            )
    }
}
