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
    
    @Binding var actionComplete: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Capsule()
                    .fill(.black)
                    .keyframeAnimator(
                        initialValue: 0,
                        trigger: rippleAnimationID,
                        content: { [rippleLocation] view, elapsedTime in
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
                        content: { [dragLocation] view, elapsedTime in
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
                  // .updating fires on every drag event; the .inactive → .dragging guard
                  // ensures the ripple and glow are triggered only once per touch.
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
                            
                            // Clamp so the glow origin never escapes the capsule bounds.
                            dragLocation = CGPoint(x: location.x.clamp(min: .zero, max: size.width), y: location.y.clamp(min: .zero, max: size.height))
                        }
                    }
                  ).onEnded { _ in
                      // Setting glowAnimationID to nil reverses the keyframe animation back to zero.
                      glowAnimationID = nil
                      withAnimation {
                          actionComplete.toggle()
                      }
                  }
                )
        }
    }
}

#Preview {
    @Previewable @State var isPressed = false
    ZStack {
        Color.black.ignoresSafeArea()
        ShinyButtonView(actionComplete: $isPressed)
            .frame(
                width: 240, height: 100.0
            )
    }
}
