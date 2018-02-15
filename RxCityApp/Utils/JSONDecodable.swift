//
//  JSONDecodable.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

enum JSONDecodeError: Error {
    case serializationError
    case nilDecodedObject
    case notFoundProperty(String)
}

typealias JSON = [String: Any]
protocol JSONDecodable {
    init?(json: JSON) throws
    func read<T>(_ property: String, from json: JSON, type: T.Type) throws -> T
}

extension JSONDecodable {
    func read<T>(_ property: String, from json: JSON, type: T.Type) throws -> T {
        guard let value = json[property] as? T else {
            throw JSONDecodeError.notFoundProperty(property)
        }
        
        return value
    }
}
