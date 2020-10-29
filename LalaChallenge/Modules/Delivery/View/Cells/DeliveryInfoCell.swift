//
//  DeliveryInfoCell.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import SDWebImage

class DeliveryInfoCell: UITableViewCell {

    private var toLabel = UILabel()
    private var fromLabel = UILabel()
    private var priceLabel = UILabel()
    
    private var itemImageView = UIImageView()
    
    // Check and display received cell data 
    var deliveryInfo: DeliveryCellItem? {
        didSet {
            
            // Display Delivery Details
            guard let info = deliveryInfo?.itemDelivery else { return }
            fromLabel.text = "\(Vocabulary.From): \(info.routeStart)"
            toLabel.text = "\(Vocabulary.To): \(info.routeEnd)"
            priceLabel.text = info.totalDeliveryFee()
            
            // Display image if valid
            guard let imageUrl = URL(string: info.deliveryItemPic) else { return }
            itemImageView.sd_setImage(with: imageUrl, completed: nil)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // add ui elements
        addSubview(itemImageView)
        addSubview(toLabel)
        addSubview(fromLabel)
        addSubview(priceLabel)
        
        customize()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customize() {
        
        // customize label alignments
        priceLabel.textAlignment = .right
        
        // customize image view
        itemImageView.clipsToBounds = true
        itemImageView.layer.cornerRadius = 5.0
        itemImageView.backgroundColor = .lightGray
    }
    
    func setConstraints() {
        // image
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        itemImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        itemImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        itemImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        // from label
        fromLabel.translatesAutoresizingMaskIntoConstraints = false
        fromLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        fromLabel.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: 80).isActive = true
        fromLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10).isActive = true
        fromLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // to label
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        toLabel.topAnchor.constraint(equalTo: fromLabel.topAnchor, constant: 30).isActive = true
        toLabel.leadingAnchor.constraint(equalTo: itemImageView.leadingAnchor, constant: 80).isActive = true
        toLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -10).isActive = true
        toLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        // price label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor, constant: 10).isActive = true
        priceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
