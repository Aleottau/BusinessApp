//
//  ProductDetailController.swift
//  BusinessApp
//
//  Created by alejandro on 9/03/23.
//

import UIKit

class ProductDetailController: UIViewController {
    var productImage =  UIImageView()
    
    let viewModel: ViewModelProtocol
    init(viewModel: ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange

        // Do any additional setup after loading the view.
    }
    
}
