//
//  CountryNameAPI.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

enum CountriesAPI {
    case Name(String)
    case AlpaCodes([String])
}

extension CountriesAPI: Resource, Webservice {
    var base: APIBase { return .restCountries }
    
    var url: URL? {
        switch self {
        case .Name(let name):
            return getUrl(path: .name, action: name, parameters: parameters)
        case .AlpaCodes:
            return getUrl(path: .alpha, parameters: parameters)
        }
    }
    
    var parameters: [APIParameter : String] {
        switch self {
        case .Name:
            return [.fullText: "true"]
        case .AlpaCodes(let codes):
            return [.codes: codes.joined(separator: ";")]
        }
    }
}
