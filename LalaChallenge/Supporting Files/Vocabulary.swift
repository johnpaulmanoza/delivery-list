//
//  Vocabulary.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/29/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation

private func NSLocalizedString(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

class Vocabulary {
    
    // Translations happens in this fnx NSLocalizedString()
    
    static let ErrorNetworkRequest = NSLocalizedString("Error Network Request")
    static let Retry = NSLocalizedString("Retry")
    static let From = NSLocalizedString("From")
    static let To = NSLocalizedString("To")
    static let GoodsToDeliver = NSLocalizedString("Goods to Deliver")
    static let DeliveryFee = NSLocalizedString("Delivery Fee")
    static let DeliveryDetails = NSLocalizedString("Delivery Details")
    static let MyDeliveries = NSLocalizedString("My Deliveries")
    static let AddToFavorites = NSLocalizedString("Add To Favorites")
}
