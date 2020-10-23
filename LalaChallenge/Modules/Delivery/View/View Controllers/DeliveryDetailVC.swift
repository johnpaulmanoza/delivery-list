//
//  DeliveryDetailVC.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

class DeliveryDetailVC: UIViewController {
    
    public var detail: DeliveryCellItem?
    
    private let favButton = UIButton(type: .custom)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customize()
        
        bind()
        
        observe()
    }
    
    private func customize() {
        
        title = "Delivery Details"
        tableView.rowHeight = 500; tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        tableView.register(DeliveryDetailCell.self, forCellReuseIdentifier: DeliveryDetailCell.id)
        tableView.pin(to: view)
        
        favButton.layer.cornerRadius = 5
        favButton.backgroundColor = UIColor.blue
        favButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        favButton.titleLabel?.textColor = .gray
        favButton.setTitle("Add to Favorite", for: .normal)
        view.addSubview(favButton)
        view.bringSubviewToFront(favButton)
        
        setupConstraint()
    }
    
    private func bind() {
        
    }
    
    private func observe() {
        
    }
    
    private func setupConstraint() {
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

extension DeliveryDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryDetailCell.id, for: indexPath) as? DeliveryDetailCell
        else
            { return UITableViewCell() }
        
        cell.deliveryInfo = detail
        
        return cell
    }
}
