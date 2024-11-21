//
//  LearnCard.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import Foundation

struct LearnCard: Identifiable, Decodable {
    let id = UUID()

    let title: String
    let body: String
    let question: String?

    enum CodingKeys: String, CodingKey {
        case title
        case body
        case question
    }
}
