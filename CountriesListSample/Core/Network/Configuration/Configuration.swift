//
//  Configuration.swift
//  CountriesList
//
//  Created by QueNV on 10/24/18.
//  Copyright © 2018 smartosc. All rights reserved.
//

import Foundation
import Alamofire

struct Configuration {
    
    /// The base URL. `nil` by default.
    var baseURL: String = CLString.emptyString
    
    /// The HTTP Method. `.GET` by default.
    var method: Alamofire.HTTPMethod = .get
    
    /// The request parameter encoding. `.JSON` by default.
    var encoding: Alamofire.ParameterEncoding = JSONEncoding.default
    
    /// The HTTP headers. `nil` by default.
    public var headers: [String: String] = [:]
    
    /// The `Alamofire.DataResponseSerializer`.
    public var dataResponseSerializer: Alamofire.DataResponseSerializer<Any> = Alamofire.DataRequest.jsonResponseSerializer()
    
    /// `Configuration` Intializer
    ///
    /// - returns: new `Configuration` object
    public init() {
    }
    
}

