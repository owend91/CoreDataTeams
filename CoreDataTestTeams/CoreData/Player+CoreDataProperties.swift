//
//  Player+CoreDataProperties.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var number: Int16
    @NSManaged public var position: String?
    @NSManaged public var team: Team?
    
    public var unwrappedFirstName: String {
        firstName ?? "No First Name"
    }
    
    public var unwrappedLastName: String {
        lastName ?? "No Last Name"
    }
    
    public var unwrappedPosition: String {
        position ?? "No Position"
    }

}

extension Player : Identifiable {

}
