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

@Observable
@MainActor class ViewModel {
    var elections : [Election] = []
}
