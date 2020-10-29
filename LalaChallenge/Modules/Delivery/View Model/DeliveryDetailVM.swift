//
//  DeliveryDetailVM.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/29/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxSwift
import RxRealm

class DeliveryDetailVM {
    
    // MARK: Public
    var isFavorite: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    
    // MARK: Private
    private let deliveryService = DeliveryService()
    private let bag = DisposeBag()
    private let delivery: Delivery?
    
    init(delivery: Delivery) {
        
        self.delivery = delivery
        
        Observable.from(object: delivery)
            .subscribe(onNext: { [weak this = self] (item) in
                guard let this = this else { return }
                this.isFavorite.onNext(item.isFavorite)
            })
            .disposed(by: bag)
    }
    
    /**
     Add Delivery Item to Favorites
     NOTE: This change will only persist locally since there is no route provided to do this change remotely
     */
    public func addToFavorite() {
        guard let item = delivery else { return }
        deliveryService.addToFavorite(delivery: item)
    }
    
    /**
     Remove Delivery Item to Favorites
     NOTE: This change will only persist locally since there is no route provided to do this change remotely
     */
    public func removeToFavorite() {
        guard let item = delivery else { return }
        deliveryService.removeToFavorite(delivery: item)
    }
}
