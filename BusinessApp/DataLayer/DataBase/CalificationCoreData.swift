//
//  CalificationCoreData.swift
//  BusinessApp
//
//  Created by alejandro on 13/03/23.
//

import Foundation
import CoreData
class CalificationCoreData: NSManagedObject {
    @NSManaged var calification: Int32
    @NSManaged var product: ProductCoreData
    let productKey = "product"
    
    convenience init?(managedObjectContext: NSManagedObjectContext) {
       let entityDescription = NSEntityDescription.entity(forEntityName: "CalificationCoreData",
                                                      in: managedObjectContext)
       guard let entityDescription = entityDescription else {
           return nil
       }
       self.init(entity: entityDescription, insertInto: managedObjectContext)
    }

    func addData(with calification: Int32) {
        self.calification = calification
    }
    
    
//    func addToDetail(_ value: ProductCoreData) {
//        let productRelation = mutableSetValue(forKey: productKey)
//        productRelation.add(value)
//        product = productRelation as! Set<MovieDetailCoreData>
//    }
//
//    func removeFromDetail(_ value: ProductCoreData) {
//        let movieRelation = mutableSetValue(forKey: movieKey)
//        movieRelation.remove(value)
//        detail = movieRelation as! Set<MovieDetailCoreData>
//    }
//
//    func addToDetail(_ values: Set<MovieDetailCoreData>) {
//        let movieRelation = mutableSetValue(forKey: movieKey)
//        let movieCd: [Any] = values.map { $0 }
//        movieRelation.addObjects(from: movieCd)
//        detail = movieRelation as! Set<MovieDetailCoreData>
//    }
//
//    func removeFromDetail(_ values: Set<MovieDetailCoreData>) {
//        let movieRelation = mutableSetValue(forKey: movieKey)
//        _ = values.map { movieRelation.remove($0) }
//        detail = movieRelation as! Set<MovieDetailCoreData>
//    }
}
