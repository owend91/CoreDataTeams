//
//  PlayerDetailView.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import SwiftUI

struct PlayerDetailView: View {
    @ObservedObject var viewModel: PlayerListViewModel
    @Binding var isDisplayingPlayerDetail: Bool
    @State var isEditing = false
    @State var isChangingTeam = false

    var body: some View {
        ZStack {
            VStack {
                Text("\(viewModel.selectedPlayer!.unwrappedFirstName) \(viewModel.selectedPlayer!.unwrappedLastName)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                    .lineLimit(1)
                    .minimumScaleFactor(0.75)
                Text(viewModel.selectedPlayer!.team?.unwrappedName ?? "Unknown team")
                    .font(.title3)
                HStack {
                    Text("#\(viewModel.selectedPlayer!.number)")
                    Text("\(viewModel.selectedPlayer!.unwrappedPosition)")
                }
                .font(.title3)
                HStack(spacing: 50) {
                    Button("Edit") {
                        isEditing = true
                        viewModel.setEditPropertiesToSelectedPlayer()
                    }
                    //                .background(Color.yellow)
                    .tint(Color.yellow)
                    .padding(.top)
                    .scaleEffect(1.5)
                    .buttonStyle(.borderedProminent)
                    
                    Button("Delete") {
                        viewModel.deleteSelectedPlayer()
                        viewModel.isDisplayingPlayerDetails = false
                    }
                    .tint(Color.red)
                    .padding(.top)
                    .scaleEffect(1.5)
                    .buttonStyle(.borderedProminent)
                }
                Button("Change Team") {
                    viewModel.initializeNewTeam()
                    isChangingTeam = true
                }
                .tint(Color.blue)
                .padding(.top)
                .scaleEffect(1.5)
                .buttonStyle(.borderedProminent)
            }
            .opacity(isEditing || isChangingTeam ? 0 : 100)
            if isEditing {
                VStack {
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
                    Button("Save") {
                        viewModel.saveEdits()
                        isEditing = false
                    }
                    .padding(.top)
                    .scaleEffect(1.5)
                    .buttonStyle(.borderedProminent)
                }
                .padding()
            }
            
            if isChangingTeam {
                VStack {
                    Picker("Team", selection: $viewModel.newTeam) {
                        ForEach(viewModel.getAllTeams(), id: \.self) { team in
                            Text(team.unwrappedName).tag(team)
                        }
                    }
                    .pickerStyle(.wheel)
                    Button("Save") {
                        viewModel.saveTeam()
                        isChangingTeam = false
                    }
                    .padding(.vertical)
                    .scaleEffect(1.5)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .frame(width: 300, height: 300)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(Button
                 {
            isDisplayingPlayerDetail = false
        } label: {
            XDismissButton()
        }, alignment: .topTrailing)
    }
}

struct PlayerDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerDetailView(viewModel: PlayerListViewModel(team: Team()), isDisplayingPlayerDetail: .constant(true))
    }
}
