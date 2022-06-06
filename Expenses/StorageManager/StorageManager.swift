//
//  StorageManager.swift
//  Expenses
//
//  Created by Максим Гурков on 06.06.2022.
//

import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    
    private var viewContext: NSManagedObjectContext
    
    private init() {
        viewContext = persistentContainer.viewContext
    }
    
    
    var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "Expenses")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchData(completion: @escaping(Result<[Entity], Error>) -> Void) {
        let fetchRequest = Entity.fetchRequest()
        do {
            let expenses = try viewContext.fetch(fetchRequest)
            completion(.success(expenses))
        } catch let Error {
            completion(.failure(Error))
        }
    }
    
    func save(_ taskName: String, sum: Int, completion: @escaping (Entity) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Entity", in: viewContext) else { return }
        guard let expens = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? Entity else { return }
        expens.title = taskName
        expens.sumExpenses = Int64(sum)
        completion(expens)
        saveContext()
    }
    
    func delete(expenses: Entity) {
        viewContext.delete(expenses)
        saveContext()
    }
    
    func edit(expens: Entity, newTask: String) {
        expens.title = newTask
        saveContext()
    }
    
    func fetchDataExpense(completion: @escaping(Result<[EntityTwo], Error>) -> Void) {
        let fetchRequest = EntityTwo.fetchRequest()
        do {
            let expenses = try viewContext.fetch(fetchRequest)
            completion(.success(expenses))
        } catch let Error {
            completion(.failure(Error))
        }
    }
    
    func saveExpense(descriptionExpense: String, sumExpense: Int, completion: @escaping (EntityTwo) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "EntityTwo", in: viewContext) else { return }
        guard let expens = NSManagedObject(entity: entityDescription, insertInto: viewContext) as? EntityTwo else { return }
        expens.descriptionExpense = descriptionExpense
        expens.sumExpense = Int64(sumExpense)
        completion(expens)
        saveContext()
    }
    
    func deleteExpense(expense: EntityTwo) {
        viewContext.delete(expense)
        saveContext()
    }
    
    
    
}
