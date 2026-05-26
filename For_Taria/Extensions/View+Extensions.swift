//
//  View+Extensions.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

import SwiftUI

extension View where Self: Shape {
  // Draws a thin inner stroke plus two blurred outer strokes to fake a neon glow.
  // Two blur passes at different radii produce more convincing bloom than one.
  func glow(
    fill: some ShapeStyle,
    lineWidth: Double,
    blurRadius: Double = 8.0,
    lineCap: CGLineCap = .round
  ) -> some View {
    self
      .stroke(style: StrokeStyle(lineWidth: lineWidth / 2, lineCap: lineCap))
      .fill(fill)
      .overlay {
        self
          .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
          .fill(fill)
          .blur(radius: blurRadius)
      }
      .overlay {
        self
          .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: lineCap))
          .fill(fill)
          .blur(radius: blurRadius / 2)
      }
  }
}

// Full-spectrum angular gradient used as the fill for ShinyButtonView's glow border.
extension ShapeStyle where Self == AngularGradient {
  static var palette: some ShapeStyle {
    .angularGradient(
      stops: [
        .init(color: .blue, location: 0.0),
        .init(color: .purple, location: 0.2),
        .init(color: .red, location: 0.4),
        .init(color: .mint, location: 0.5),
        .init(color: .indigo, location: 0.7),
        .init(color: .pink, location: 0.9),
        .init(color: .blue, location: 1.0),
      ],
      center: .center,
      startAngle: Angle(radians: .zero),
      endAngle: Angle(radians: .pi * 2)
    )
  }
}
