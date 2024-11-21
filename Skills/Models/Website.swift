//
//  Website.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import Foundation

struct Website: Readable, Decodable {
    let id: UUID = UUID()
    let title: String
    let url: URL

    enum CodingKeys: String, CodingKey {
        case title
        case url
    }
}
