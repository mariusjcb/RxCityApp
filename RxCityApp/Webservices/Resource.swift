//
//  Resource.swift
//  RxCityApp
//
//  Created by Marius Ilie on 15/02/2018.
//  Copyright © 2018 Marius Ilie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum ResourceRequestError: Error {
    case invalidRequestData
    case invalidResponse
    case badStatusCode(Int)
    case other(Error)
}

protocol Resource {
    var method: HTTPRequestMethod { get }
    var url: URL? { get }
    var parameters: [APIParameter: String] { get }
    
    func getRequest() -> URLRequest?
    func requestData() -> Observable<Data>
}

extension Resource {
    var method: HTTPRequestMethod { return .get }
    
    func getRequest() -> URLRequest? {
        guard let url = url else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
    
    func requestData() -> Observable<Data> {
        return Observable.create({ observer in
            let request = self.getRequest()
            if request == nil {
                observer.onError(ResourceRequestError.invalidRequestData)
            }
            
            let task = URLSession.shared.dataTask(with: request!, completionHandler: { (data, response, error) in
                if let error = error {
                    observer.onError(ResourceRequestError.other(error))
                } else {
                    let response = response as? HTTPURLResponse
                    if response == nil {
                        observer.onError(ResourceRequestError.invalidResponse)
                    }
                    
                    let code = response!.statusCode
                    
                    if code >= 200, code < 300 {
                        observer.onNext(data ?? Data())
                        observer.onCompleted()
                    } else {
                        observer.onError(ResourceRequestError.badStatusCode(code))
                    }
                }
            })
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        })
    }
}
