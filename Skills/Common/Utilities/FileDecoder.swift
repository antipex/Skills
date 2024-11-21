//
//  DataLoader.swift
//  Skills
//
//  Created by Kyle Rohr on 20/11/2024.
//

import Foundation

final class FileDecoder {
    static func load<T: Decodable>(
        _ type: T.Type,
        fromFileNamed fileName: String,
        withExtension fileExtension: String = "json"
    ) throws -> T? {
        if let path = Bundle.main.path(forResource: fileName, ofType: fileExtension) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let object = try JSONDecoder().decode(type, from: data)

                return object
            } catch {
                print("Error: \(error)")

                throw FileDecoderError.decoding(error)
            }
        } else {
            throw FileDecoderError.unknown
        }
    }
}

enum FileDecoderError: Error {
    case unknown
    case decoding(Error)
}
