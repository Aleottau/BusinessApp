//
//  ProductCoreData.swift
//  BusinessApp
//
//  Created by alejandro on 8/03/23.
//

import Foundation
import CoreData

class ProductCoreData: NSManagedObject {
    @NSManaged var id: Int32
    @NSManaged var nameProduct: String
    @NSManaged var phoneNumber: String
    @NSManaged var overview: String
    
    convenience init?(managedObjectContext: NSManagedObjectContext) {
       let entityDescription = NSEntityDescription.entity(forEntityName: "ProductCoreData",
                                                      in: managedObjectContext)
       guard let entityDescription = entityDescription else {
           return nil
       }
       self.init(entity: entityDescription, insertInto: managedObjectContext)
    }

    func addData(with product: ProductModel) {
        self.id = Int32(product.id)
        self.nameProduct = product.nameProduct
        self.phoneNumber = product.phoneNumber
        self.overview = product.overview
    }
}
