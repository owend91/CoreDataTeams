//
//  TeamView.swift
//  CoreDataTestTeams
//
//  Created by David Owen on 10/5/22.
//

import SwiftUI

struct TeamView: View {
    @StateObject var viewModel = TeamViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    
                    TextField("Team Name", text: $viewModel.teamName)
                        .padding(5)
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.secondary, lineWidth: 1)
                        }
                        .padding(.leading)
                        
                    Button("Add Team") {
                        viewModel.addTeam()
                    }
                    .padding()
                    
                }
                List {
                    ForEach(viewModel.teams, id: \.self) { team in
                        NavigationLink {
                            PlayerListView(viewModel: PlayerListViewModel(team: team))
                        } label: {
                            Text(team.unwrappedName)
                        }

                        
                    }
                    .onDelete(perform: viewModel.deleteTeam)
                }
                Spacer()
            }
            
        }
        .task {
            viewModel.getAllTeams()
        }
        
        
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}
