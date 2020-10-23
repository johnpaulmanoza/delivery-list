//
//  ViewController.swift
//  LalaChallenge
//
//  Created by John Paul Manoza on 10/23/20.
//  Copyright © 2020 John Paul Manoza. All rights reserved.
//

import UIKit

class DeliveryListVC: UIViewController {
    
    private let viewModel = DeliveryListVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        viewModel.loadDeliveries()
    }
}

