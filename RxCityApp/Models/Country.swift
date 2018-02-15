//
//  Country.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

final class Country: GenericJSONDecodable {
    private(set) var name: String!
    private(set) var nativeName: String!
    private(set) var borders: [String]!
    
    init?(json: JSON) throws {
        self.name = try read("name", from: json, type: String.self)
        self.nativeName = try read("nativeName", from: json, type: String.self)
        self.borders = try read("borders", from: json, type: [String]?.self) ?? []
    }
}
