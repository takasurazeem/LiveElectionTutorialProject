//
//  ViewModel.swift
//  LiveElectionTutorialProject
//
//  Created by Takasur Azeem on 3/18/25.
//

import Foundation
import SwiftUI
import ActivityKit
import Observation
import FirebaseFirestore

@Observable
@MainActor class ViewModel {
    
    let db = Firestore.firestore()
    var elections : [Election] = []
    
    func listenToLiveElectionsCollection() {
        db.collection("elections")
            .addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    print("Error listening to elections collection: \(error?.localizedDescription ?? "No error")")
                    return
                }
                let docs = snapshot.documents
                let elections: [Election] = docs.compactMap { snapshot in
                    do {
                        var election = try snapshot.data(as: Election.self)
                        election.isLiveActivityRegistered = Activity<ElectionWidgetAttributes>.activities.contains(where: { $0.id == election.id
                        })
                        return election
                    } catch {
                        print(error)
                    }
                    return nil
                }
                
                withAnimation {
                    self.elections = elections
                }
            }
    }
    
    func startLiveActivity(election: Election, channelId: String) {
        guard ActivityAuthorizationInfo().frequentPushesEnabled else {
            return
        }
        do {
            let activityAttributes = ElectionWidgetAttributes(id: election.id)
            let activity = try Activity.request(
                attributes: activityAttributes,
                content: .init(
                    state: .init(
                        aName: election.aName,
                        bName: election.bName,
                        aCount: election.aCount,
                        bCount: election.bCount,
                        aPercent: election.aPercent,
                        bPercent: election.bPercent
                    ),
                    staleDate: nil
                ),
                pushType: .channel(channelId)
            )
            print("Requested a live activity \(String(describing: activity.id))")
            guard let index = self.elections.firstIndex(of: election) else { return }
            self.elections[index].isLiveActivityRegistered = true
        } catch {
            print("Error requesting live activity \(error.localizedDescription)")
        }
    }
}
