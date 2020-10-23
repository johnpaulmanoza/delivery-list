//
//  APIManager.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift

class APIManager {

    static var shared = APIManager()
    private var manager: Alamofire.SessionManager
    
    public func baseUrl() -> String {
        let url = "https://mock-api-mobile.dev.lalamove.com"
        // Add env checking here if possible
        return url
    }
    
    init() {

        let config = URLSessionConfiguration.default
        config.httpMaximumConnectionsPerHost = 50
        // 10 seconds request timeout
        config.timeoutIntervalForResource = 30.0
        config.timeoutIntervalForRequest = 30.0
        // disable response caching
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil

        manager = Alamofire.SessionManager(configuration: config)
    }
    
    // MARK: Request with JSON as Result
    public func request(_ urlConvertible: URLRequestConvertible) -> Observable<Any> {
        // Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<Any>.create { [weak this = self] observer in

            guard let this = this else { return  Disposables.create() }
            
            // We need to omit 401 - status code, bc TaskSessionDelegate will NOT be called
            // if we include 401 here, causing the retrier to NOT work.
            // Ref: https://github.com/Alamofire/Alamofire/issues/2214
            var codes: [Int] = []; codes.append(contentsOf: 200...400); codes.append(contentsOf: 402..<599)
            
            this.manager.request(urlConvertible)
                .validate(statusCode: codes)
                .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value); observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            })
            
            return Disposables.create()
        }
    }
    
    // MARK: Request with Array of Mapped Items as Result
    public func requestCollection<T: Mappable>(_ urlConvertible: URLRequestConvertible, _ type: T.Type? = nil) -> Observable<Any> {
        // Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<Any>.create { [weak this = self] observer in
            
            guard let this = this else { return  Disposables.create() }
            
            this.manager.request(urlConvertible).responseArray(completionHandler: { (response: DataResponse<[T]>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value); observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            })
            // IMPORTANT: We NEED to add a validation in order for the retrier to work.
            .validate(statusCode: 200..<403)
            
            return Disposables.create()
        }
    }

}
