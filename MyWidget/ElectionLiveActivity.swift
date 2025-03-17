//
//  ElectionLiveActivity.swift
//  MyWidgetExtension
//
//  Created by Takasur Azeem on 3/18/25.
//

import Foundation
import WidgetKit
import SwiftUI

struct ElectionWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ElectionWidgetAttributes.self) { context in
            ElectionView(election: context.state)
                .padding()
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.center) {
                    ElectionView(election: context.state)
                        .padding(.bottom)
                }
            } compactLeading: {
                HStack {
                    CircleImage(
                        candidateName: context.state.aName,
                        imageName: context.state.aImageName,
                        bgColor: .blue.mix(with: .black, by: 0.2),
                        size: CGSize(width: 20, height: 20),
                        font: .body
                    )
                    Text("\(context.state.aCount)")
                        .foregroundStyle(.blue)
                }
            } compactTrailing: {
                HStack {
                    Text("\(context.state.bCount)")
                    CircleImage(
                        candidateName: context.state.bName,
                        imageName: context.state.bImageName,
                        bgColor: .red.mix(with: .black, by: 0.2),
                        size: CGSize(width: 20, height: 20),
                        font: .body
                    )
                }
                .foregroundStyle(.red)
            } minimal: {
                
            }

        }

    }
}

extension ElectionWidgetAttributes {
    fileprivate static var preview: ElectionWidgetAttributes {
        ElectionWidgetAttributes(id: UUID().uuidString)
    }
}


#Preview(
    "Notification",
    as: .content,
    using: ElectionWidgetAttributes.preview,
    widget: {
        ElectionWidgetLiveActivity()
    },
    contentStates: {
        ElectionWidgetAttributes.ContentState.example2
    }
)


#Preview(
    "Dynamic Island Expanded",
    as: .dynamicIsland(.expanded),
    using: ElectionWidgetAttributes.preview,
    widget: {
        ElectionWidgetLiveActivity()
    },
    contentStates: {
        ElectionWidgetAttributes.ContentState.example2
    }
)


#Preview(
    "Dynamic Island Compact",
    as: .dynamicIsland(.compact),
    using: ElectionWidgetAttributes.preview,
    widget: {
        ElectionWidgetLiveActivity()
    },
    contentStates: {
        ElectionWidgetAttributes.ContentState.example2
    }
)
