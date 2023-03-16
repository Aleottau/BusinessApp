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
    func saveProductInDb(product: ProductModel) throws
    func getProductFromDb(completion: @escaping ([ProductModel]) -> Void)
    func getLastIdFromDb() -> Int32
    func deleteProductWithId(id: Int32)
    func saveCalification(id: Int32, calificationModel: CalificationModel) throws
    func getAverageFromCalifications(idProduct: Int32) -> Int32?
    func getVoteCount(idProduct: Int32) -> Int32?
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel?
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
    func getCalificationCoreData(idProduct: Int32) -> CalificationCoreData? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CalificationCoreData")
        fetchRequest.predicate = NSPredicate(format: "product == %i", idProduct)
        do {
            guard let calificationResult = try self.getContext().fetch(fetchRequest).first as? CalificationCoreData else {
                return nil
            }
            return calificationResult
        } catch {
            return nil
        }
    }
}

extension DataBaseManager: DataBaseManagerProtocol {
    func getCalificationFromDb(idProduct: Int32) -> CalificationModel? {
        guard let calificationResult = self.getCalificationCoreData(idProduct: idProduct) else {
            return nil
        }
        return CalificationModel(calificacionCoreData: calificationResult)
    }
    func getAverageFromCalifications(idProduct: Int32) -> Int32? {
        guard let calificationResult = self.getCalificationCoreData(idProduct: idProduct) else {
            return 0
        }
        return calificationResult.promedio
    }
    
    func getVoteCount(idProduct: Int32) -> Int32? {
        guard let calificationResult = self.getCalificationCoreData(idProduct: idProduct) else {
            return 1
        }
        return calificationResult.cantidadDeVotos + 1
    }
    
    func saveCalification(id: Int32, calificationModel: CalificationModel) throws {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            let productResult = try self.getContext().fetch(fetchRequest).first as? ProductCoreData
            if let calification = productResult?.califications {
                calification.addData(calificationModel: calificationModel)
                productResult?.califications = calification
                try self.saveContext()
                self.getContext().reset()
            } else {
                guard let calificationCd = CalificationCoreData(managedObjectContext: self.getContext()) else {
                    return
                }
                calificationCd.addData(calificationModel: calificationModel)
                productResult?.califications = calificationCd
                try self.saveContext()
                self.getContext().reset()
            }
        } catch {
            print("error de func save calification")
            print(error)
        }
    }
    
    func deleteProductWithId(id: Int32) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductCoreData")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        do {
            guard let productResult = try self.getContext().fetch(fetchRequest).first as? ProductCoreData else {
                return
            }
            getContext().delete(productResult.califications)
            getContext().delete(productResult)
            let product = ProductModel(productCoreData: productResult)
            productDeleted.onNext(product)
            try self.saveContext()
        } catch {
            print("error de func delete product with id")
            print(error)
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
            print("error de func get product from db")
            print(error)
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
