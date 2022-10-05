//
//  PlayerViewModel.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import Foundation
import SwiftUI

class PlayerListViewModel: ObservableObject {
    @Published var team: Team
    @Published var isDisplayingPlayerDetails = false
    @Published var selectedPlayer: Player?
    
    
    @Published var playerFirstName: String = ""
    @Published var playerLastName: String = ""
    @Published var playerPosition: String = ""
    @Published var playerNumber: String = ""
    
    @Published var newTeam: Team = Team()
    
    init(team: Team){
        self.team = team
    }
    
    func addPlayer() {
        let player = Player(context: CoreDataManager.shared.viewContext)
        player.firstName = playerFirstName
        player.lastName = playerLastName
        player.position = playerPosition
        player.number = Int16(playerNumber) ?? 0
        
        player.team = team
        CoreDataManager.shared.save()
        refreshTeam()
        
        
        playerFirstName = ""
        playerLastName = ""
        playerPosition = ""
        playerNumber = ""
        
    }
    
    var isFormValid: Bool {
        !playerFirstName.isEmpty &&
        !playerLastName.isEmpty &&
        !playerPosition.isEmpty &&
        !playerNumber.isEmpty
    }
    
    func refreshTeam() {
        if let team = CoreDataManager.shared.getTeam(name: team.unwrappedName) {
            self.team = team
        }
    }
    
    func deletePlayer(offsets: IndexSet) {
        withAnimation {
            let playersToDelete = offsets.map { team.playerArray[$0] }
            
            for player in playersToDelete {
                CoreDataManager.shared.viewContext.delete(player)
            }
            CoreDataManager.shared.save()
            self.refreshTeam()
        }
    }
    
    func deleteSelectedPlayer() {
        if let selectedPlayer = selectedPlayer {
            CoreDataManager.shared.viewContext.delete(selectedPlayer)
            
            CoreDataManager.shared.save()
            self.refreshTeam()
        }
    }
    
    
    func setEditPropertiesToSelectedPlayer() {
        if let selectedPlayer = selectedPlayer {
            playerFirstName = selectedPlayer.unwrappedFirstName
            playerLastName = selectedPlayer.unwrappedLastName
            playerPosition = selectedPlayer.unwrappedPosition
            playerNumber = "\(selectedPlayer.number)"
        }
    }
    
    func saveEdits() {
        if let selectedPlayer = selectedPlayer {
            
            selectedPlayer.firstName = playerFirstName
            selectedPlayer.lastName = playerLastName
            selectedPlayer.position = playerPosition
            selectedPlayer.number = Int16(playerNumber) ?? 0
        }
        
        CoreDataManager.shared.save()
        refreshTeam()
        
        
        playerFirstName = ""
        playerLastName = ""
        playerPosition = ""
        playerNumber = ""
        
    }
    
    func initializeNewTeam() {
        if let selectedPlayer = selectedPlayer, let team = selectedPlayer.team {
            newTeam = team
        }
    }
    
    func getAllTeams() -> [Team] {
        CoreDataManager.shared.getAllTeams()
    }
    
    func saveTeam() {
        if let selectedPlayer = selectedPlayer {
            
            selectedPlayer.team = newTeam
            CoreDataManager.shared.save()
            refreshTeam()
        }
    }
}
