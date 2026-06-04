//
//  SWAPIRetrievable.swift
//  For_Taria
//
//  Created by Jason Hillegass on 6/1/26.
//

import Foundation

protocol SWAPIRetrievable: Codable, Identifiable, Sendable {
    var id: UUID { get }
    var name: String? { get }
    var url: String? { get }
}

