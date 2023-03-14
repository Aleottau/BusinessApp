//
//  ViewModel.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import UIKit
import RxSwift

protocol ViewModelProtocol {
    var rxProduct: Observable<ProductModel> { get }
    var productDeleted: Observable<ProductModel> { get }
    func setUpInitial(windowScene: UIWindowScene) -> UIWindow
    func presentAddProduct()
    func presentHomeView()
    func presentCalificationView()
    func presentProductDetailController(for product: ProductModel, image: UIImage?)
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func getImageFromLocalFile(imageId: String) -> UIImage?
    func saveImageInLocalFile(image: UIImage, imageId: String)
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel
    func DeleteProductFromDb(id: Int32)
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
    func presentCalificationView() {
        coordinator.presentCalificationView(with: self)
    }
    
    var productDeleted: RxSwift.Observable<ProductModel> {
        return interactor.productDeleted.asObservable()
    }
    
    func DeleteProductFromDb(id: Int32) {
        interactor.DeleteProductFromDb(id: id)
    }
    
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel {
        return interactor.createNewProduct(id: id, nameProduct: nameProduct, phoneNumber: phoneNumber, overview: overview)
    }
    
    func getImageFromLocalFile(imageId: String) -> UIImage? {
        interactor.getImageFromLocalFile(imageId: imageId)
    }
    
    func saveImageInLocalFile(image: UIImage, imageId: String) {
        interactor.saveImageInLocalFile(image: image, imageId: imageId)
    }
    
    var rxProduct: RxSwift.Observable<ProductModel> {
        return interactor.rxProduct.asObservable()
    }
    
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
    func presentProductDetailController(for product: ProductModel, image: UIImage?) {
        coordinator.presentProductDetail(for: product, with: self, image: image)
    }
}
