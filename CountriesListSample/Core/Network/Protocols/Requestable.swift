//
//  Requestable.swift
//  CountriesList
//
//  Created by QueNV on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation
import Alamofire

extension Requestable {
    
    /// Creates a `DataRequest` from the specified `form`
    ///
    /// - Parameter form: Object conforms to `BaseRequestable` protocol.
    /// - Returns: The created `DataRequest`.
    
    func request(_ form: BaseRequestable) -> DataRequest {
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 20
        let requestPath = form.path
        debugPrint(requestPath)
        return Alamofire.request(
            requestPath,
            method: form.method,
            parameters: form.parameters,
            encoding: JSONEncoding.default,
            headers: form.headers)
    }    
}

protocol Requestable {
    
}
