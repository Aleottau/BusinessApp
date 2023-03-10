//
//  ViewModel.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit

protocol ViewModelProtocol {
    func setUpInitial(windowScene: UIWindowScene) -> UIWindow
    func presentAddProduct()
    func presentHomeView()
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
}

class ViewModel {
    var coordinator: CoordinatorProtocol
    var interactor: InteractorProtocol
    init(coordinator: CoordinatorProtocol, interactor: InteractorProtocol) {
        self.coordinator = coordinator
        self.interactor = interactor
    }
}

extension ViewModel: ViewModelProtocol {
    func getLastIdFromDb() -> Int32 {
        return interactor.getLastIdFromDb()
    }
    
    
    func saveProductInDb(product: ProductModel) {
        interactor.saveProductInDb(product: product)
    }
    
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void) {
        interactor.getProductsFromDb(completion: completion)
    }
    
    
    func setUpInitial(windowScene: UIWindowScene) -> UIWindow {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = coordinator.initialController(with: self)
        window.makeKeyAndVisible()
        return window
    }
    
    func presentAddProduct() {
        coordinator.presentAddProduct(with: self)
    }
    func presentHomeView() {
        coordinator.presentHomeView(with: self)
    }
}
