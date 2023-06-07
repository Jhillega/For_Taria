//
//  CardableProtocol+ModelStructs.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/6/23.
//

import Foundation
import UIKit
import SwiftUI

protocol Cardable {
    func returnAsCard<T>(using object: T) -> [CardLabels : Any]
}

struct Card {
    var cardType: CardType
    var labelOne: String
    var labelTwo: String
    var labelThree: String
    
    var image: UIImage?
}

enum CardLabels {
    case labelOne
    case labelTwo
    case labelThree
    case image
    case cardType
}

enum CardType: String {
    case person = "person"
    case planet = "planet"
    case species = "species"
    case vehicle = "vehicle"
}


