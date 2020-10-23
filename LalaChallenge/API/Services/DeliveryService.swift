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
    
    func loadDeliveries(offset: Int = 0, limit: Int = 20) -> Observable<Any> {
        return APIManager
            .shared
            .requestCollection(DeliveryRouter.loadDeliveries(offset: offset, limit: limit), Delivery.self)
            .asObservable()
    }
}
