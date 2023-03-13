//
//  Interactor.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import RxSwift

protocol InteractorProtocol {
    var rxProduct: PublishSubject<ProductModel> { get }
    var productDeleted: Observable<ProductModel> { get }
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func getImageFromLocalFile(imageId: String) -> UIImage?
    func saveImageInLocalFile(image: UIImage, imageId: String)
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel
    func DeleteProductFromDb(id: Int32)
}

class Interactor {
    let rxProduct = PublishSubject<ProductModel>()
    let dataBaseManager: DataBaseManagerProtocol
    let locaFileManager: LocalFileManagerProtocol
    init(dataBaseManager: DataBaseManagerProtocol, locaFileManager: LocalFileManagerProtocol) {
        self.dataBaseManager = dataBaseManager
        self.locaFileManager = locaFileManager
    }
    
}
extension Interactor: InteractorProtocol {
    var productDeleted: RxSwift.Observable<ProductModel> {
        return dataBaseManager.productDeleted.asObservable()
    }

    func DeleteProductFromDb(id: Int32) {
        dataBaseManager.deleteProductWithId(id: id)
    }
    
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel {
        return ProductModel(id: id, nameProduct: nameProduct, phoneNumber: phoneNumber, overview: overview)
    }
    
    func getImageFromLocalFile(imageId: String) -> UIImage? {
        locaFileManager.getImageFromLocalFile(imageId: imageId)
    }
    
    func saveImageInLocalFile(image: UIImage, imageId: String) {
        locaFileManager.saveImageInLocalFile(image: image, imageId: imageId)
    }
    
    func getLastIdFromDb() -> Int32 {
        return dataBaseManager.getLastIdFromDb()
    }
    
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void) {
        dataBaseManager.getProductFromDb(completion: completion)
    }
    
    func saveProductInDb(product: ProductModel) {
        do {
            try dataBaseManager.saveProductInDb(product: product)
            rxProduct.onNext(product)
        } catch {
            
        }
        
        
    }
    
    
}
