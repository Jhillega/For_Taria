//
//  Comparable+Extensions.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

// AdditiveArithmetic constraint satisfies the compiler for both Int and CGFloat
// without requiring separate overloads for each numeric type.
extension Comparable where Self: AdditiveArithmetic {
    // Keeps drag coordinates within view bounds; used by ShinyButtonView.
    func clamp(min: Self, max: Self) -> Self {
        if self < min {
            return min
        }
        if self > max {
            return max
        }
        return self
    }
}
