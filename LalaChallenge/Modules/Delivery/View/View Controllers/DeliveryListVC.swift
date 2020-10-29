//
//  ViewController.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import JGProgressHUD
import UIScrollView_InfiniteScroll

class DeliveryListVC: UIViewController {
    
    private let viewModel = DeliveryListVM()
    private let tableView = UITableView()
    private let loading = JGProgressHUD(style: .dark)
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        customize()
        
        bind()
        
        observe()
    }
    
    private func customize() {
        
        title = Vocabulary.MyDeliveries
        
        // add and customize tableview
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        view.addSubview(tableView)
        
        // register prototype cells for the tableview
        tableView.register(DeliveryInfoCell.self, forCellReuseIdentifier: DeliveryInfoCell.id)
        tableView.pin(to: view)
    }
    
    private func bind() {
        
        viewModel.loadDeliveries()
        
        // Observe changes from the viewmodel sections
        // and update the list accordingly
        _ = viewModel.sections.asObservable()
            .bind(to: tableView.rx.items(dataSource: dataSource))
    }
    
    private func observe() {
        
        // Update Loader Status
        _ = viewModel.isLoading.asObservable()
            .subscribe(onNext: { [weak this = self] (isloading) in
                guard let this = this else { return }
                _ = isloading
                    ? this.loading.show(in: this.view)
                    : this.loading.dismiss(animated: true)
            })
            .disposed(by: bag)
        
        // Show an error once view model throws one
        _ = viewModel.error.asObservable()
            .subscribe(onNext: { [weak this = self] (error) in
                guard let errorMsg = error else { return }
                this?.presentAlertWithTitle(title: Vocabulary.ErrorNetworkRequest,
                                            message: errorMsg,
                                            options: Vocabulary.Retry,
                                            completion: { _ in
                                                this?.viewModel.loadDeliveries()
                                            })
            })
            .disposed(by: bag)
        
        // Update Paginator Status
        _ = viewModel.isPagingEnabled.asObservable()
            .subscribe(onNext: { [weak this = self] (shouldPaginate) in
                guard let isPagingEnabled = shouldPaginate else { return }
                if isPagingEnabled {
                    this?.addPaginator()
                } else {
                    this?.tableView.finishInfiniteScroll()
                    this?.tableView.removeInfiniteScroll()
                }
            })
            .disposed(by: bag)
        
        // Observe row selections
        _ = Observable.zip(
                tableView.rx.itemSelected,
                tableView.rx.modelSelected(DeliveryListItem.Row.self)
            )
            .subscribe(onNext: { [weak this = self] (indexPath, model) in
                this?.tableView.deselectRow(at: indexPath, animated: true)
                switch model {
                case .deliverySmallDetailItem(let data):
                    this?.navigateToDelivery(detail: data)
                default:
                    break
                }
            })
            .disposed(by: bag)
    }
    
    private func addPaginator() {
        // end the current pagination and restart
        tableView.finishInfiniteScroll()
        tableView.infiniteScrollIndicatorStyle = .medium
        tableView.addInfiniteScroll { [weak this = self] (_) in
            this?.viewModel.paginateDeliveries()
        }
    }
    
    /**
    Navigate to Delivery Details Page
     */
    private func navigateToDelivery(detail: DeliveryCellItem) {
        let view = DeliveryDetailVC()
        view.detail = detail
        navigationController?.pushViewController(view, animated: true)
    }
}

extension DeliveryListVC {

    // Provide Datasource for the tableview
    public var dataSource: RxTableViewSectionedReloadDataSource<DeliveryListItem> {
        let dataSource = RxTableViewSectionedReloadDataSource<DeliveryListItem>(configureCell: { (source, tableView, indexPath, _) in

            switch source[indexPath] {
            case .deliverySmallDetailItem(let data):
                let cell = tableView.dequeueReusableCell(withIdentifier: DeliveryInfoCell.id, for: indexPath)
                // set cell model data
                (cell as! DeliveryInfoCell).deliveryInfo = data
                return cell
            default:
                return UITableViewCell()
            }
        })

        return dataSource
    }
}

