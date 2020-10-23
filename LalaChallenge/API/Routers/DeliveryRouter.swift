//
//  DeliveryRouter.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import Alamofire

enum DeliveryRouter: URLRequestConvertible {

    case loadDeliveries(offset: Int, limit: Int)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .loadDeliveries:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .loadDeliveries:
            return "v2/deliveries"
        }
    }
    
    private var parameters: Parameters? {
        var params: [String: Any] = [:]
        switch self {
        case .loadDeliveries(let offset, let limit):
            params.updateValue(limit, forKey: "limit")
            params.updateValue(offset, forKey: "offset")
        }
        return params
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIManager.shared.baseUrl().asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))

        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Parameters
        if let params = parameters {
            // limited to get only
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: params)
        }
        
        return urlRequest
    }
}
