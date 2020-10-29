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
    
    public var detail: DeliveryCellItem? {
        didSet {
            guard let delivery = detail?.itemDelivery else { return }
            
            // initialize view model with selected delivery item
            viewModel = DeliveryDetailVM(delivery: delivery)
        }
    }
    
    private let favButton = UIButton(type: .custom)
    private let tableView = UITableView()
    
    private var bottomSafeAreaHeight: CGFloat = 0
    private var isFavoriteItem: Bool = false
    private var viewModel: DeliveryDetailVM!
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customize()
        
        bind()
        
        observe()
    }
    
    private func customize() {
        
        title = Vocabulary.DeliveryDetails
        
        // add and customize tableview
        tableView.rowHeight = 500; tableView.dataSource = self
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        // register prototype cells for the tableview
        tableView.register(DeliveryDetailCell.self, forCellReuseIdentifier: DeliveryDetailCell.id)
        tableView.pin(to: view)
        
        // add fav button
        favButton.layer.cornerRadius = 5
        favButton.backgroundColor = UIColor.systemBlue
        favButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        favButton.titleLabel?.textColor = .gray
        favButton.addTarget(self, action: #selector(favButtonTap(_:)), for: .touchUpInside)

        view.addSubview(favButton)
        view.bringSubviewToFront(favButton)
        
        // get safe insets
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }
        
        setupConstraint()
    }
    
    private func bind() {
        
    }
    
    private func observe() {
        
        // observe changes for isFavorite property of selected delivery item
        _ = viewModel.isFavorite.asObserver()
            .subscribe(onNext: { [weak this = self] (isFav) in
                guard let this = this else { return }
                this.isFavoriteItem = isFav
                this.customizeFavButtonTitle()
            })
            .disposed(by: bag)
    }
    
    private func setupConstraint() {
        // compute the fav button bottom constraint
        // value should be a negative value
        let favButtonBottomsConst = -1 * (bottomSafeAreaHeight + 10)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        favButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: favButtonBottomsConst).isActive = true
        favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        favButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        favButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func customizeFavButtonTitle() {
        // set fav button title
        let title = isFavoriteItem ? Vocabulary.RemoveToFavorites : Vocabulary.AddToFavorites
        favButton.setTitle(title, for: .normal)
    }
    
    // Respond to fav button
    @objc
    private func favButtonTap(_ sender: UIButton) {
        if isFavoriteItem {
            viewModel.removeToFavorite()
        } else {
            viewModel.addToFavorite()
        }
    }
}

extension DeliveryDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    // Provide Datasource for the tableview
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryDetailCell.id, for: indexPath) as? DeliveryDetailCell
        else
            { return UITableViewCell() }
        
        // set cell model data
        cell.deliveryInfo = detail
        
        return cell
    }
}
