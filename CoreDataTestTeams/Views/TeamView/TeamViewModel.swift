//
//  TeamViewModel.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import Foundation
import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var teamName: String = ""
    @Published var teams: [Team] = []
    
    func addTeam() {
        let team = Team(context: CoreDataManager.shared.viewContext)
        team.name = teamName
        teamName = ""
        
        CoreDataManager.shared.save()
        getAllTeams()

    }
    
    func getAllTeams() {
        teams = CoreDataManager.shared.getAllTeams()
    }
    
    func deleteTeam(offsets: IndexSet) {
        withAnimation {
            let teamsToDelete = offsets.map { teams[$0] }

            for team in teamsToDelete {
                CoreDataManager.shared.viewContext.delete(team)
            }
            CoreDataManager.shared.save()
            self.getAllTeams()
        }
    }

}
