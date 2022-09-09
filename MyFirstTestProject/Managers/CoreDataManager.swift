//
//  CoreDataManager.swift
//  MyFirstTestProject
//
//  Created by Yaroslav on 08.09.2022.
//

import UIKit
import CoreData

// MARK: - CoreDataManagerProtocol
protocol CoreDataManagerProtocol {
    var context: NSManagedObjectContext { get }
    
    func fetchRequest() -> [Result]
    func saveContext()
    func deleteUsers(id: UUID, completion: @escaping EmptyClosure)
}

// MARK: - CoreDataManager
class CoreDataManager: CoreDataManagerProtocol {

    // MARK: - Core Data stack
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MyFirstTestProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Methods
    func fetchRequest() -> [Result] {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()

        do {
            let objects = try context.fetch(fetchRequest)
            return objects.map { Result(with: $0) }
        } catch let error {
            print(error)
        }

        return []
    }

    func deleteUsers(id: UUID, completion: @escaping EmptyClosure) {
        let fetchRequest: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let objects = try context.fetch(fetchRequest)
            for object in objects {
                context.delete(object)
            }
            saveContext()
            completion()
            print("Delete")
        } catch {
            print(error)
        }
    }

    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
