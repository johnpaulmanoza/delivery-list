//
//  DeliveryService.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

public class DeliveryService {
    
    private let manager = APIManager()
    private let realm: Realm!
    
    init() {
        realm = try? Realm()
    }
    
    /**
     Load list of deliveries
     
     - Parameters:
        - offset: current page of the list, defaults to 0
        - limit: number of items per page, defaults to 29
     */
    func loadDeliveries(offset: Int = 0, limit: Int = 20) -> Observable<Any> {
        return manager
            .requestCollection(DeliveryRouter.loadDeliveries(offset: offset, limit: limit), Delivery.self)
            .map({ [weak this = self] (items) -> Any in
                guard let deliveryItems = items as? [Delivery] else { return items }

                // store results to local database first
                this?.storeDelivery(items: deliveryItems)
                
                return items
            })
            .asObservable()
    }
    
    /**
     Set as favorite delivery item
     
     - Parameters:
        - delivery: Item to add as favorite
     */
    func addToFavorite(delivery: Delivery) {
        
        do {
            try realm.write {
                delivery.isFavorite = true
                realm.create(Delivery.self, value: delivery, update: .all)
            }
        } catch _ {

        }
    }
    
    /**
     Remove as favorite delivery item
     
     - Parameters:
        - delivery: Item to remove as favorite
     */
    func removeToFavorite(delivery: Delivery) {
        
        do {
            try realm.write {
                delivery.isFavorite = false
                realm.create(Delivery.self, value: delivery, update: .all)
            }
        } catch _ {

        }
    }
    
    /**
     Persist delivery items into local database
     - Parameters:
        - items: Array of delivery items to store
    */
    private func storeDelivery(items: [Delivery]) {
        
        do {
            try realm.write {
                _ = items.map { realm.create(Delivery.self, value: $0, update: .all) }
            }
        } catch _ {

        }
    }
    
    /**
    Reset delivery items table
     */
    private func resetDeliveryItems() {
        
        do {
            try realm.write {
                let items = realm.objects(Delivery.self); realm.delete(items)
            }
        } catch _ {

        }
    }
}
