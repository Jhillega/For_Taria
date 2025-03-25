//
//  Comparable+Extensions.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/24/25.
//

extension Comparable where Self: AdditiveArithmetic {
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
