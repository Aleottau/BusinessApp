//
//  ProductModel.swift
//  BusinessApp
//
//  Created by alejandro on 6/03/23.
//

import Foundation

struct ProductModel {
    let id: Int32
    let nameProduct: String
    let phoneNumber: String
    let overview: String
}
extension ProductModel {
    init(productCoreData: ProductCoreData) {
        self.init(id: productCoreData.id, nameProduct: productCoreData.nameProduct, phoneNumber: productCoreData.phoneNumber, overview: productCoreData.overview)
    }
}
