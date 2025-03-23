//
//  ContentView.swift
//  LiveElectionTutorialProject
//
//  Created by Takasur Azeem on 3/17/25.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.elections) { election in
                VStack(spacing: 8) {
                    ElectionView(election: election)
                    if let channelId = election.channelId, election.isLiveActivityRegistered == false {
                        Button("Get Real-Time Live Activity Updates") {
                            viewModel.startLiveActivity(election: election, channelId: channelId)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle("Live Elections")
            .onAppear {
                viewModel.listenToLiveElectionsCollection()
            }
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
}
