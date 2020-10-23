//
//  DeliveryDetailCell.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import SDWebImage

class DeliveryDetailCell: UITableViewCell {

    var toLabel = UILabel()
    var fromLabel = UILabel()
    var toPlaceholder = UILabel()
    var fromPlaceholder = UILabel()
    
    var itemPlaceholder = UILabel()
    var itemImageView = UIImageView()
    var pricePlaceholder = UILabel()
    var priceLabel = UILabel()
    
    var deliveryInfo: DeliveryCellItem? {
        didSet {
            guard let info = deliveryInfo?.itemDelivery else { return }
            fromLabel.text = info.routeStart
            toLabel.text = info.routeEnd
            priceLabel.text = info.totalDeliveryFee()

            guard let imageUrl = URL(string: info.deliveryItemPic) else { return }
            itemImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(itemImageView); addSubview(itemPlaceholder)
        addSubview(toLabel); addSubview(toPlaceholder)
        addSubview(fromLabel); addSubview(fromPlaceholder)
        addSubview(priceLabel); addSubview(pricePlaceholder)
        customize()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customize() {
        selectionStyle = .none
        fromPlaceholder.text = "From"
        toPlaceholder.text = "To"
        itemPlaceholder.text = "Goods to Deliver"
        pricePlaceholder.text = "Delivery Fee"
        toLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        fromLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        toPlaceholder.font = UIFont.systemFont(ofSize: 18)
        fromPlaceholder.font = UIFont.systemFont(ofSize: 18)
        pricePlaceholder.font = UIFont.systemFont(ofSize: 18)
        itemPlaceholder.font = UIFont.systemFont(ofSize: 18)
        fromLabel.textAlignment = .right
        toLabel.textAlignment = .right
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 5.0
        itemImageView.backgroundColor = .lightGray
        priceLabel.textAlignment = .right
    }
    
    func setConstraints() {
        
        // image placeholder
        itemPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        itemPlaceholder.topAnchor.constraint(equalTo: toPlaceholder.topAnchor, constant: 50).isActive = true
        itemPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        itemPlaceholder.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        itemPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // image
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.topAnchor.constraint(equalTo: itemPlaceholder.topAnchor, constant: 30).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // from placeholder
        fromPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        fromPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        fromPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        fromPlaceholder.trailingAnchor.constraint(equalTo: fromLabel.leadingAnchor, constant: -10).isActive = true
        fromPlaceholder.widthAnchor.constraint(equalToConstant: 80).isActive = true
        fromPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // from label
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
        fromLabel.leadingAnchor.constraint(equalTo: fromLabel.leadingAnchor, constant: 10).isActive = true
        fromLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        fromLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // to placeholder
        toPlaceholder.translatesAutoresizingMaskIntoConstraints = false
        toPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        toPlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        toPlaceholder.trailingAnchor.constraint(equalTo: toLabel.leadingAnchor, constant: -10).isActive = true
        toPlaceholder.widthAnchor.constraint(equalToConstant: 80).isActive = true
        toPlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // to label
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        toLabel.leadingAnchor.constraint(equalTo: toLabel.leadingAnchor, constant: 10).isActive = true
        toLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        toLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // price placeholder
        pricePlaceholder.translatesAutoresizingMaskIntoConstraints = false
        pricePlaceholder.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 30).isActive = true
        pricePlaceholder.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        pricePlaceholder.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10).isActive = true
        pricePlaceholder.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        // price label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 30).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: pricePlaceholder.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        priceLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 10).isActive = true
//        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
//        priceLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
//        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
