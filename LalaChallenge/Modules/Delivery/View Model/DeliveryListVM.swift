//
//  DeliveryListVM.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxRealm

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
    
    init() {
        
        let realm = try! Realm()
        let items = realm.objects(Delivery.self)

        // Observe changes in the list of deliveries in local db
        _ = Observable
            .array(from: items)
            .subscribe(onNext: { [weak this = self] nextItems in
                this?.items = nextItems
                this?.showItems()
            })
    }
    /**
    Load list of deliveries
    */
    public func loadDeliveries() {
        
        // show loader only on the first load, otherwise hide it
        // since we already have a pagination loader at the bottom
        // of the list
        isLoading.onNext(page == 0)

        _ = deliveryService.loadDeliveries(offset: page, limit: limit)
            .subscribe(onNext: { [weak this = self] (values) in
                
                guard let this = this else { return }
                guard let items = values as? [Delivery] else { return }
                
                // stop list pagination and hide loader
                // NOTE: Stop pagination when the results count
                // is less than the limit
                this.isLoading.onNext(false)
                this.isPagingEnabled.onNext(items.count == this.limit)
                
            }, onError: { [weak this = self] (e) in
                
                // Display any errors 
                this?.isLoading.onNext(false)
                this?.error.onNext(e.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    /**
        Paginate list of deliveries
     */
    public func paginateDeliveries() {
        
        // NOTE: increment page
        
        page += 1; loadDeliveries()
    }
    
    /**
    Display list items by iterating the delivery results and converting them to UI Model Classes
     */
    private func showItems() {
        
        let listItems = items
            .map { DeliveryCellItem(delivery: $0) }
            .map { DeliveryListItem.Row.deliverySmallDetailItem(item: $0) }
        
        sections.onNext([
            DeliveryListItem.listSection(header: "", items: listItems)
        ])
    }
}
