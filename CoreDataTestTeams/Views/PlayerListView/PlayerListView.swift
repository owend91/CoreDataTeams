//
//  PlayerView.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import SwiftUI

struct PlayerListView: View {
    @ObservedObject var viewModel: PlayerListViewModel
    var body: some View {
        ZStack {
            VStack(spacing: 1) {
                VStack{
                    TextField("First Name", text: $viewModel.playerFirstName)
                        .padding(2.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        }
                    TextField("Last Name", text: $viewModel.playerLastName)
                        .padding(2.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        }
                    TextField("Position", text: $viewModel.playerPosition)
                        .padding(2.5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        }
                    TextField("Number", text: $viewModel.playerNumber)
                        .padding(2.5)
                        .keyboardType(.numberPad)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        }
                    
                    Button("Add Player") {
                        viewModel.addPlayer()
                    }
                    .disabled(!viewModel.isFormValid)
                }
                .padding()
                List {
                    ForEach(viewModel.team.playerArray, id: \.self) { player in
                        Text("\(player.unwrappedFirstName) \(player.unwrappedLastName)")
                            .onTapGesture {
                                viewModel.isDisplayingPlayerDetails = true
                                viewModel.selectedPlayer = player
                            }
                    }
                    .onDelete(perform: viewModel.deletePlayer)
                }
                
                Spacer()
            }
            .blur(radius: viewModel.isDisplayingPlayerDetails ? 20: 0)
            
            if viewModel.isDisplayingPlayerDetails {
                PlayerDetailView(viewModel: viewModel, isDisplayingPlayerDetail: $viewModel.isDisplayingPlayerDetails)
            }
            
        }
        .navigationTitle(viewModel.team.unwrappedName)
        .navigationBarBackButtonHidden(viewModel.isDisplayingPlayerDetails)
    }
}

struct PlayerListView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerListView(viewModel: PlayerListViewModel(team: Team()))
    }
}
