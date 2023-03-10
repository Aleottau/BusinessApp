//
//  Interactor.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation
import RxSwift

protocol InteractorProtocol {
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    var rxProduct: PublishSubject<ProductModel> { get }
}

class Interactor {
    let rxProduct = PublishSubject<ProductModel>()
    let dataBaseManager: DataBaseManagerProtocol
    init(dataBaseManager: DataBaseManagerProtocol) {
        self.dataBaseManager = dataBaseManager
    }
    
}
extension Interactor: InteractorProtocol {
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
