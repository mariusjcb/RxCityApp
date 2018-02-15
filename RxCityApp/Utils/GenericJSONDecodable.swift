//
//  GenericJSONDecodable.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

protocol GenericJSONDecodable: JSONDecodable {
    static func fromJSONArray(_ array: [JSON]) throws -> [Self]
    static func fromData(_ data: Data) throws -> [Self]
}

extension GenericJSONDecodable {
    static func fromJSONArray(_ array: [JSON]) throws -> [Self] {
        return try array.flatMap { try Self(json: $0) }
    }
    
    static func fromData(_ data: Data) throws -> [Self] {
        guard let JSONObject = try? JSONSerialization.jsonObject(with: data, options: []) else {
            throw JSONDecodeError.serializationError
        }
        
        guard let array = JSONObject as? [JSON] else {
            throw JSONDecodeError.nilDecodedObject
        }
        
        return try fromJSONArray(array)
    }
}
