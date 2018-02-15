//
//  APIUrl.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation

class APIUrl {
    class func build(scheme: HTTPRequestScheme, base: APIBase, path: APIPath, action: String? = nil, parameters: [APIParameter: String]? = nil) -> URL? {
        var components = URLComponents()
        var basePaths = base.rawValue.split(separator: "/")
        
        components.scheme = scheme.rawValue
        components.host = String(basePaths[0])
        
        components.path = "/" + basePaths.dropFirst().joined(separator: "/")
        components.path += "/" + path.rawValue
        
        if let actionPath = action?.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
            components.path += "/" + actionPath
        }
        
        components.queryItems = parameters?.map({ key, value in
            URLQueryItem(name: key.rawValue, value: value)
        })
        
        return components.url
    }
}
