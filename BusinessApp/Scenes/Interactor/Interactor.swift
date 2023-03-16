//
//  Interactor.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import RxSwift

protocol InteractorProtocol {
    var rxCalification: PublishSubject<CalificationModel> { get }
    var rxProduct: PublishSubject<ProductModel> { get }
    var productDeleted: Observable<Int32> { get }
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func getImageFromLocalFile(imageId: String) -> UIImage?
    func saveImageInLocalFile(image: UIImage, imageId: String)
    func createNewProduct(id: Int32, nameProduct: String, phoneNumber: String, overview: String) -> ProductModel
    func DeleteProductFromDb(id: Int32)
    func saveCalification(with id: Int32, currentVote: Int32)
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel?
    func deleteImageFromLocalFile(idProduct: Int32)
}

class Interactor {
    let rxCalification = PublishSubject<CalificationModel>()
    let rxProduct = PublishSubject<ProductModel>()
    let dataBaseManager: DataBaseManagerProtocol
    let locaFileManager: LocalFileManagerProtocol
    init(dataBaseManager: DataBaseManagerProtocol, locaFileManager: LocalFileManagerProtocol) {
        self.dataBaseManager = dataBaseManager
        self.locaFileManager = locaFileManager
    }
    
}
extension Interactor: InteractorProtocol {
    func deleteImageFromLocalFile(idProduct: Int32) {
        locaFileManager.deleteImageFromLocalFile(idProduct: idProduct)
    }
    
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel? {
        return dataBaseManager.getCalificationFromDb(idProduct: idProduct)
    }
    func saveCalification(with id: Int32, currentVote: Int32) {
        guard let voteCount = dataBaseManager.getVoteCount(idProduct: id), let averageFromCalification = dataBaseManager.getAverageFromCalifications(idProduct: id) else {
            return
        }
        do {
            let average = (averageFromCalification == 0) ? currentVote : (averageFromCalification + currentVote)/2
            let newCalification = CalificationModel(idProduct: id, cantidadDeVotos: voteCount, promedio: average)
            try dataBaseManager.saveCalification(id: id, calificationModel: newCalification)
            rxCalification.onNext(newCalification)
        } catch {
        }
        
    }
    
    var productDeleted: RxSwift.Observable<Int32> {
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
