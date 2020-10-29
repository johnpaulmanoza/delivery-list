//
//  Delivery.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

// NOTE: This class serves two purposes, to map the response
// and to create a new schema for the local database object

public class Delivery: Object, Mappable {

    @objc dynamic public var deliveryId: String = ""
    @objc dynamic public var deliveryRemarks: String = ""
    @objc dynamic public var deliveryItemPic: String = ""
    @objc dynamic public var deliveryPickupTime: String = ""
    @objc dynamic public var deliveryFee: String = ""
    @objc dynamic public var deliverySurcharge: String = ""
    
    @objc dynamic public var routeStart: String = ""
    @objc dynamic public var routeEnd: String = ""
    
    @objc dynamic public var senderName: String = ""
    @objc dynamic public var senderPhone: String = ""
    @objc dynamic public var senderEmail: String = ""
    
    public required convenience init?(map: Map) {
        self.init()
    }

    public override class func primaryKey() -> String {
        return "deliveryId"
    }
    
    public func mapping(map: Map) {
        
        deliveryId          <- map["id"]
        deliveryRemarks     <- map["remarks"]
        deliveryItemPic     <- map["goodsPicture"]
        deliveryPickupTime  <- map["pickupTime"]
        deliveryFee         <- map["deliveryFee"]
        deliverySurcharge   <- map["surcharge"]

        routeStart          <- map["route.start"]
        routeEnd            <- map["route.end"]
        
        senderName          <- map["sender.name"]
        senderPhone         <- map["sender.phone"]
        senderEmail         <- map["sender.email"]
    }
    
    /**
    Compute Total Delivery Fee by adding surcharge and delivery fee
     */
    public func totalDeliveryFee() -> String {
        
        // Remove currency and convert these values into number
        let delFee = deliveryFee.replacingOccurrences(of: "$", with: "")
        let delCharge = deliverySurcharge.replacingOccurrences(of: "$", with: "")
        
        guard
            let delFeeValue = Double(delFee),
            let delChargeValue = Double(delCharge)
        else
            { return "" }
        
        let total = delFeeValue + delChargeValue
        let totalDesc = String(format: "%.2f", total)
        
        return "$\(totalDesc)"
    }
}
