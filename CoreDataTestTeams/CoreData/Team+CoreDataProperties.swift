//
//  Team+CoreDataProperties.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var name: String?
    @NSManaged public var player: NSSet?
    
    public var unwrappedName: String {
        name ?? "No Name"
    }
    
    public var playerArray: [Player] {
        let set = player as? Set<Player> ?? []
        
        return set.sorted { $0.unwrappedLastName < $1.unwrappedLastName }
    }

}

// MARK: Generated accessors for player
extension Team {

    @objc(addPlayerObject:)
    @NSManaged public func addToPlayer(_ value: Player)

    @objc(removePlayerObject:)
    @NSManaged public func removeFromPlayer(_ value: Player)

    @objc(addPlayer:)
    @NSManaged public func addToPlayer(_ values: NSSet)

    @objc(removePlayer:)
    @NSManaged public func removeFromPlayer(_ values: NSSet)

}

extension Team : Identifiable {

}
