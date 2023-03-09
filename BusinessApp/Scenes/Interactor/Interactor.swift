//
//  Interactor.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation

protocol InteractorProtocol {
    func saveProductInDb(product: ProductModel)
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void)
}

class Interactor {
    let dataBaseManager: DataBaseManagerProtocol
    init(dataBaseManager: DataBaseManagerProtocol) {
        self.dataBaseManager = dataBaseManager
    }
    
}
extension Interactor: InteractorProtocol {
    func getProductsFromDb(completion: @escaping ([ProductModel]) -> Void) {
        dataBaseManager.getProductFromDb(completion: completion)
    }
    
    func saveProductInDb(product: ProductModel) {
        dataBaseManager.saveProductInDb(product: product)
    }
    
    
}
