//
//  AnyTransition+Extension.swift
//  For_Taria
//
//  Created by Jason Hillegass on 3/26/25.
//

import SwiftUI

extension AnyTransition {
    // Registers a named .blur transition backed by BlurTransition so call sites
    // can write .transition(.blur) instead of spelling out the full modifier pair.
    static let blur: AnyTransition = .modifier(
        active: BlurTransition(progress: 1), identity: BlurTransition(progress: 0)
    )
}
