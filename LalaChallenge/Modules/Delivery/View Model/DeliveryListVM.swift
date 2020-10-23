//
//  DeliveryListVM.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxSwift

public class DeliveryListVM {
    
    private let deliveryService = DeliveryService()
    private let bag = DisposeBag()
    
    public func loadDeliveries() {
        
        _ = deliveryService.loadDeliveries()
            .subscribe(onNext: { [weak this = self] (values) in
                guard let this = this else { return }
                print("values", values)
            })
            .disposed(by: bag)
    }
}
