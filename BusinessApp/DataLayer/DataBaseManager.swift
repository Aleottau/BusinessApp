//
//  DataBaseManager.swift
//  BusinessApp
//
//  Created by alejandro on 8/03/23.
//

import Foundation
import CoreData
enum DataBaseError: Error {
    case notSaved
    case notDeleted
}

protocol DataBaseManagerProtocol {
    static var persistentContainer: NSPersistentContainer { get }
    func getContext() -> NSManagedObjectContext
    func saveContext() throws
    // save product
    func saveProductInDb(product: ProductModel) throws
    func getProductFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
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
    func getLastIdFromDb() -> Int32 {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        guard let productResult = try? self.getContext().fetch(fetchRequest) as? [ProductCoreData], let lastId = productResult.last?.id else {
            return 1
        }
        return lastId + 1
    }
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
    
    func saveProductInDb(product: ProductModel) throws {
        let productCD = ProductCoreData(managedObjectContext: self.getContext())
        productCD?.addData(with: product)
        try self.saveContext()
        getContext().reset()
        // crear observable
    }
    // MARK: - CONTEXT FUNCTION
    func getContext() -> NSManagedObjectContext {
        return DataBaseManager.persistentContainer.viewContext
    }

    func saveContext() throws {
        let context = DataBaseManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                throw DataBaseError.notSaved
            }
        }
    }
}
