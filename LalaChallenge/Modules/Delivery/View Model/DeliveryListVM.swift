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
    var isPagingEnabled: BehaviorSubject<Bool?> = BehaviorSubject(value: nil)
    var error: PublishSubject<String?> = PublishSubject()
    
    // MARK: Private
    private let deliveryService = DeliveryService()
    private let bag = DisposeBag()
    private var items: [Delivery] = []
    private var page = 0
    private let limit = 20
    
    public func loadDeliveries() {
        
        isLoading.onNext(page == 0)

        _ = deliveryService.loadDeliveries(offset: page, limit: limit)
            .subscribe(onNext: { [weak this = self] (values) in
                
                guard let this = this else { return }
                guard let items = values as? [Delivery] else { return }
                
                // stop pagination and hide loader
                this.isLoading.onNext(false)
                this.isPagingEnabled.onNext(items.count == this.limit)
                
                // display items
                this.items.append(contentsOf: items)
                this.showItems()
                
            }, onError: { [weak this = self] (e) in
                
                this?.isLoading.onNext(false)
                this?.error.onNext(e.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    public func paginateDeliveries() {
        
        page += 1; loadDeliveries()
    }
    
    private func showItems() {
        
        let listItems = items
            .map { DeliveryCellItem(delivery: $0) }
            .map { DeliveryListItem.Row.deliverySmallDetailItem(item: $0) }
        
        sections.onNext([
            DeliveryListItem.listSection(header: "", items: listItems)
        ])
    }
}
