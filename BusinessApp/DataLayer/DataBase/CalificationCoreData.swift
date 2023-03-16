//
//  CalificationCoreData.swift
//  BusinessApp
//
//  Created by alejandro on 13/03/23.
//

import Foundation
import CoreData
class CalificationCoreData: NSManagedObject {
    @NSManaged var cantidadDeVotos: Int32
    @NSManaged var promedio: Int32
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

    func addData(calificationModel: CalificationModel) {
        self.cantidadDeVotos = calificationModel.cantidadDeVotos
        self.promedio = calificationModel.promedio
    }
    
}
