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
    var rxCalification: Observable<CalificationModel> { get }
    var rxProduct: Observable<ProductModel> { get }
    var productDeleted: Observable<ProductModel> { get }
    func setUpInitial(windowScene: UIWindowScene) -> UIWindow
    func presentAddProduct()
    func presentHomeView()
    func presentProductDetailController(for product: ProductModel, image: UIImage?)
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func getImageFromLocalFile(imageId: String) -> UIImage?
    func saveImageInLocalFile(image: UIImage, imageId: String)
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel
    func DeleteProductFromDb(id: Int32)
    func saveCalification(with id: Int32, currentVote: Int32)
    func createCalification(cantidadDeVotos: Int32, promedio: Int32) -> CalificationModel
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel?
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
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel? {
        return interactor.getCalificationFromDb(idProduct: idProduct)
    }
    
    var rxCalification: RxSwift.Observable<CalificationModel> {
        return interactor.rxCalification.asObservable()
    }
    
    func createCalification(cantidadDeVotos: Int32, promedio: Int32) -> CalificationModel {
        return interactor.createCalification(cantidadDeVotos: cantidadDeVotos, promedio: promedio)
    }
    
    func saveCalification(with id: Int32, currentVote: Int32) {
        interactor.saveCalification(with: id, currentVote: currentVote)
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
