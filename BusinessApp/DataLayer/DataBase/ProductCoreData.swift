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
    @NSManaged var califications: Set<CalificationCoreData>
    let calificationsKey = "califications"
    
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
    
    
    func addToCalifications(_ value: CalificationCoreData) {
        let calificationsRelation = mutableSetValue(forKey: calificationsKey)
        calificationsRelation.add(value)
        califications = calificationsRelation as! Set<CalificationCoreData>
    }

    func removeFromCalifications(_ value: CalificationCoreData) {
        let calificationsRelation = mutableSetValue(forKey: calificationsKey)
        calificationsRelation.remove(value)
        califications = calificationsRelation as! Set<CalificationCoreData>
    }

    func addToCalifications(_ values: Set<CalificationCoreData>) {
        let calificationsRelation = mutableSetValue(forKey: calificationsKey)
        let calificationsCd: [Any] = values.map { $0 }
        calificationsRelation.addObjects(from: calificationsCd)
        califications = calificationsRelation as! Set<CalificationCoreData>
    }

    func removeFromCalifications(_ values: Set<CalificationCoreData>) {
        let calificationsRelation = mutableSetValue(forKey: calificationsKey)
        _ = values.map { calificationsRelation.remove($0) }
        califications = calificationsRelation as! Set<CalificationCoreData>
    }
}
