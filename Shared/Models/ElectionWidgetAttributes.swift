//
//  ElectionWidgetAttributes.swift
//  LiveElectionTutorialProject
//
//  Created by Takasur Azeem on 3/17/25.
//

import Foundation
import ActivityKit

struct ElectionWidgetAttributes: ActivityAttributes {
    public struct ContentState: ElectionType, Codable, Hashable {
        var aName: String
        var bName: String
        var aCount: Int
        var bCount: Int
        var aPercent: Double
        var bPercent: Double
        var aImageName: String?
        var bImageName: String?
        
        static let example1: ContentState = .init(
            aName: "Takasur",
            bName: "Azeem",
            aCount: 150,
            bCount: 80,
            aPercent: 0.6,
            bPercent: 0.3,
            aImageName: nil,
            bImageName: nil
        )
        
        static let example2: ContentState = .init(
            aName: "Wajid A.",
            bName: "Usman A.",
            aCount: 50,
            bCount: 160,
            aPercent: 0.24,
            bPercent: 0.66,
            aImageName: nil,
            bImageName: nil
        )
    }
    
    let id: String
}
