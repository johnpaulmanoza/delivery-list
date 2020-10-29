//
//  DeliveryService.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxSwift

public class DeliveryService {
    
    private let manager = APIManager()
    
    /**
     Load list of deliveries
     
     - Parameters:
        - offset: current page of the list, defaults to 0
        - limit: number of items per page, defaults to 29
     */
    func loadDeliveries(offset: Int = 0, limit: Int = 20) -> Observable<Any> {
        return manager
            .requestCollection(DeliveryRouter.loadDeliveries(offset: offset, limit: limit), Delivery.self)
            .asObservable()
    }
}
