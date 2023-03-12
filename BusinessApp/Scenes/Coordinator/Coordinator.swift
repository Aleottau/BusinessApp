//
//  Coordinator.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    func initialController(with prensenter: ViewModel) -> UIViewController
    func presentAddProduct(with viewModel: ViewModel)
    func presentProductDetail(for product: ProductModel, with viewModel: ViewModel, image: UIImage?)
    func presentHomeView(with viewModel: ViewModel)
}
class Coordinator {
    var navigation: UINavigationController
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
}

extension Coordinator: CoordinatorProtocol {
    
    func initialController(with viewModel: ViewModel) -> UIViewController {
        let HomeBusinnesViewController = HomeBusinnesViewController(viewModel: viewModel)
        navigation.setViewControllers([HomeBusinnesViewController], animated: false)
        return navigation
    }
    func presentAddProduct(with viewModel: ViewModel) {
        let addProduct = AddProductController(viewModel: viewModel)
//        addProduct.modalPresentationStyle = .fullScreen
        navigation.pushViewController(addProduct, animated: true)
    }
    func presentProductDetail(for product: ProductModel, with viewModel: ViewModel, image: UIImage?) {
        let productDetail = ProductDetailController(product: product, viewModel: viewModel, image: image)
        navigation.pushViewController(productDetail, animated: true)
    }
    func presentHomeView(with viewModel: ViewModel) {
        let homeView = HomeBusinnesViewController(viewModel: viewModel)
        navigation.setViewControllers([homeView], animated: true)
    }
}
