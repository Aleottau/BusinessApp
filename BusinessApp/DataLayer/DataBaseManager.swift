//
//  DataBaseManager.swift
//  BusinessApp
//
//  Created by alejandro on 8/03/23.
//

import Foundation
import CoreData
import RxSwift

enum DataBaseError: Error {
    case notSaved
    case notDeleted
}

protocol DataBaseManagerProtocol {
    static var persistentContainer: NSPersistentContainer { get }
    var productDeleted: PublishSubject<ProductModel> { get }
    func getContext() -> NSManagedObjectContext
    func saveContext() throws
    // save product
    func saveProductInDb(product: ProductModel) throws
    func getProductFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func deleteProductWithId(id: Int32)
    func saveCalification(with id: Int32, calification: Int32)
    func getAverageFromCalifications(idProduct: Int32)
}

class DataBaseManager {
    var productDeleted = PublishSubject<ProductModel>()
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
    func getAverageFromCalifications(idProduct: Int32) {
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalificationCoreData")
//        fetchRequest.predicate = NSPredicate(format: "product == %i", idProduct)
//        do {
//            guard let calificationResult = try self.getContext().fetch(fetchRequest) as? CalificationCoreData else {
//                return
//            }
//            
//        } catch {
//            
//        }
    }
    
    func saveCalification(with id: Int32, calification: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            guard let productResult = try self.getContext().fetch(fetchRequest).first as? ProductCoreData, let calificationCd = CalificationCoreData(managedObjectContext: self.getContext())  else {
                return
            }
            calificationCd.addData(with: calification)
            productResult.addToCalifications(calificationCd)
            try self.saveContext()
            self.getContext().reset()
        } catch {
        }
    }
    
    func deleteProductWithId(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            guard let productResult = try self.getContext().fetch(fetchRequest).first as? ProductCoreData else {
                return
            }
            getContext().delete(productResult)
            let product = ProductModel(productCoreData: productResult)
            productDeleted.onNext(product)
            try self.saveContext()
        } catch {
            
        }
        
    }
    
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
                _ = error as NSError
                throw DataBaseError.notSaved
            }
        }
    }
}
