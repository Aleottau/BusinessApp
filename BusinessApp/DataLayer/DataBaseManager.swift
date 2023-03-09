//
//  DataBaseManager.swift
//  BusinessApp
//
//  Created by alejandro on 8/03/23.
//

import Foundation
import CoreData

protocol DataBaseManagerProtocol {
    static var persistentContainer: NSPersistentContainer { get }
    func getContext() -> NSManagedObjectContext
    func saveContext()
    // save product
    func saveProductInDb(product: ProductModel)
    func getProductFromDb(completion: @escaping ([ProductModel]) -> Void)
}

class DataBaseManager {
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ProductModelDb")
        container.loadPersistentStores(completionHandler: { (description, error) in
            print(description.url ?? "")
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        })
        return container
    }()
}

extension DataBaseManager: DataBaseManagerProtocol {
    func getProductFromDb(completion: @escaping ([ProductModel]) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        do {
            guard let productResult = try self.getContext().fetch(fetchRequest) as? [ProductCoreData] else {
                completion([])
                return
            }
            let product = productResult.map { ProductModel(productCoreData: $0)}
            completion(product)
        } catch {
            
        }
    }
    
    func saveProductInDb(product: ProductModel) {
        let productCD = ProductCoreData(managedObjectContext: self.getContext())
        productCD?.addData(with: product)
        self.saveContext()
        getContext().reset()
    }
    // MARK: - CONTEXT FUNCTION
    func getContext() -> NSManagedObjectContext {
        return DataBaseManager.persistentContainer.viewContext
    }

    func saveContext() {
        let context = DataBaseManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror)")
            }
        }
    }
}
