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
    
    // MARK: Public
    var sections: PublishSubject<[DeliveryListItem]> = PublishSubject()
    var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var error: PublishSubject<String?> = PublishSubject()
    
    // MARK: Private
    private let deliveryService = DeliveryService()
    private let bag = DisposeBag()
    
    public func loadDeliveries() {
        
        isLoading.onNext(true)

        _ = deliveryService.loadDeliveries()
            .subscribe(onNext: { [weak this = self] (values) in
                guard let this = this else { return }
                guard let items = values as? [Delivery] else { return }
                this.isLoading.onNext(false)
                this.showItems(items)
            }, onError: { [weak this = self] (e) in
                this?.isLoading.onNext(false)
                this?.error.onNext(e.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    private func showItems(_ items: [Delivery]) {
        
        let listItems = items
            .map { DeliveryCellItem(delivery: $0) }
            .map { DeliveryListItem.Row.deliverySmallDetailItem(item: $0) }
        
        sections.onNext([
            DeliveryListItem.listSection(header: "", items: listItems)
        ])
    }
}
