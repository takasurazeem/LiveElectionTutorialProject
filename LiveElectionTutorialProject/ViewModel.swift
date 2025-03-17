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
}
