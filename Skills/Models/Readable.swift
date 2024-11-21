//
//  Readable.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import Foundation

protocol Readable: Identifiable {
    var id: UUID { get }
    var title: String { get }
}
