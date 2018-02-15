//
//  Webservice.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

protocol Webservice {
    var scheme: HTTPRequestScheme { get }
    var base: APIBase { get }
    
    func getUrl(path: APIPath, action: String?, parameters: [APIParameter: String]?) -> URL?
}

extension Webservice {
    var scheme: HTTPRequestScheme { return .https }
    
    func getUrl(path: APIPath, action: String? = nil, parameters: [APIParameter: String]? = nil) -> URL? {
        return APIUrl.build(scheme: scheme, base: base, path: path, action: action, parameters: parameters)
    }
}
