//
//  CoreDataManager.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let container: NSPersistentContainer
    
    static let shared = CoreDataManager ()
    
    private init() {
        container = NSPersistentContainer(name: "CoreDataTeams")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump

        
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        print(directories[0])
    }
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            print(error)
        }
    }
    
    func getAllTeams() -> [Team] {
        let request: NSFetchRequest<Team> = NSFetchRequest(entityName: "Team")
      
        
        do {
            let teams = try viewContext.fetch(request)
            return teams
        } catch {
            print(error)
        }
        
        return []
    }
    
    func getTeam(name: String) -> Team? {
        let request: NSFetchRequest<Team> = NSFetchRequest(entityName: "Team")
        request.predicate = NSPredicate(format: "name == %@", name)
      
        
        do {
            let teams = try viewContext.fetch(request)
            return teams[0]
        } catch {
            print(error)
        }
        return nil
    }
}
