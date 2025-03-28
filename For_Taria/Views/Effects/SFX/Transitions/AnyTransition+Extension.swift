//
//  AnyTransition+Extension.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/26/25.
//

import SwiftUI

extension AnyTransition {
    static let blur: AnyTransition = .modifier(
        active: BlurTransition(progress: 1), identity: BlurTransition(progress: 0)
    )
}
