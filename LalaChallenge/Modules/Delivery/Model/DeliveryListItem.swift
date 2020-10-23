//
//  DeliveryListItem.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import Foundation

import RxDataSources

enum DeliveryListItem: SectionModelType {

    typealias Item = Row

    case listSection(header: String, items: [Row])

    enum Row {
        // declare per row type/layout
        case deliverySmallDetailItem(item: DeliveryCellItem)
        case deliveryFullDetailItem(item: DeliveryCellItem)
    }

    // followings are not directly related to this topic, but represents how to conform to SectionModelType
    var items: [Row] {
        switch self {
        case .listSection(_, let items):
            return items
        }
    }

    public init(original: DeliveryListItem, items: [Row]) {
        switch original {
        case .listSection(let header, _):
            self = .listSection(header: header, items: items)
        }
    }
}

class DeliveryCellItem {

    var itemDelivery: Delivery?

    init(delivery: Delivery) {
        itemDelivery = delivery
    }
}

