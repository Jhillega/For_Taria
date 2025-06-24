//
//  Shaders.metal
//  For_Taria
//
//  Created by Jason Hillegass on 3/25/25.
//

#include <SwiftUI/SwiftUI_Metal.h>
#include <metal_stdlib>
using namespace metal;


[[stitchable]]
half4 passthrough(float2 position, half4 color) {
    return color;
}

[[stitchable]]
half4 recolor(float2 position, half4 color) {
    return half4(1, 0, 0, color.a);
}

[[stitchable]]
half4 invert(float2 position, half4 color) {
    return half4(1, 0, 0, 1 - color.a);
}

[[stitchable]]
half4 gradient(float2 position, half4 color) {
    return half4(
                 position.x / position.y,
                 0,
                 position.y / position.x,
                 color.a
                 );
}

[[stitchable]]
half4 rainbow(float2 position, half4 color, float time) {
    float angle = atan2(position.y, position.x) + time;
    
    return half4(
                 sin(angle),
                 sin(angle + 2),
                 sin(angle + 4),
                 color.a
                 );
}

[[stitchable]]
float2 wave(float2 position, float time, float2 size) {
    float2 distance = position / size;
    position.y += sin(time * 5 + position.y / 20) * distance.x * 3;
    return position;
}


[[stitchable]]
half4 loupe(float2 position, SwiftUI::Layer layer, float2 size, float2 touch) {
    float maxDistance = 0.05;
    
    float2 uv = position / size;
    float2 center = touch / size;
    float2 delta = uv - center;
    float aspectRatio = size.x / size.y;
    
    float distance = (delta.x * delta.x) + (delta.y * delta.y) / aspectRatio;
    float zoom = 1;
    
    if (distance < maxDistance) {
        zoom /= 2;
        zoom += distance * 10;
    }
    
    float2 newPos = delta * zoom + center;
    return layer.sample(newPos * size);
}

[[stitchable]]
half4 circles(
              float2 position,
              half4 color,
              float2 size,
              float amount
              ) {
                  float2 uv = position /size;
                  float strength = 20;
                  float2 f = fract(position/ strength);
                  float d = abs(f.x - 0.5) + abs(f.y - 0.5);
                  
                  if (d + uv.x + uv.y < amount * 3) {
                      return color;
                  } else {
                      return 0;
                  }
              }

[[ stitchable ]]
float2 distortion(float2 position) {
    return float2(position.x + 100, position.y);
}

[[ stitchable ]]
half4 pixellate(
                float2 position,
                SwiftUI::Layer layer,
                float size
                ) {
    float sample_x = size * round(position.x / size);
    float sample_y = size * round(position.y / size);
    return layer.sample(float2(sample_x, sample_y));
}
