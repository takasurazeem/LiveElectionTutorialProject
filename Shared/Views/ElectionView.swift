//
//  ElectionView.swift
//  LiveElectionTutorialProject
//
//  Created by Takasur Azeem on 3/17/25.
//

import SwiftUI

struct ElectionView: View {
    let election: ElectionType
    
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                CircleImage(
                    candidateName: election.aName,
                    imageName: election.aImageName,
                    bgColor: .blue.mix(with: .black, by: 0.15)
                )
                Text("\(election.aCount)")
                    .font(.title)
                
                Spacer()
                
                Text("\(election.bCount)")
                    .font(.title)
                CircleImage(
                    candidateName: election.bName,
                    imageName: election.bImageName,
                    bgColor: .red.mix(with: .black, by: 0.15)
                )
            }
            CustomProgressView(
                leftValue: CGFloat(election.aPercent),
                rightValue: CGFloat(election.bPercent)
            )
            HStack {
                Text(election.aName)
                Spacer()
                Text(election.bName)
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
    }
}

struct CustomProgressView: View {
    var leftValue: CGFloat
    var rightValue: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            let totalWidth = geometry.size.width
            let leftWidth = min(totalWidth * (leftValue), totalWidth)
            let rightWidth = min(totalWidth * (rightValue), totalWidth)
            
            ZStack {
                HStack(spacing: 0) {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(width: leftWidth, height: 10)
                        .cornerRadius(5, corners: [.topLeft, .bottomLeft])
                    
                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: totalWidth - leftWidth - rightWidth, height: 10)
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: rightWidth, height: 10)
                        .cornerRadius(5, corners: [.topRight, .bottomRight])
                }
                
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 1, height: 10)
                    .position(x: totalWidth / 2, y: 5)
            }
        }
        .frame(height: 10)
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}


struct CircleImage: View {
    let candidateName: String
    let imageName: String?
    let bgColor: Color
    let textColor: Color = .white
    var size: CGSize = .init(width: 40, height: 40)
    var font: Font = .title2
    var body: some View {
        Group {
            if let imageName {
                Image(imageName)
                    .resizable()
            } else {
                bgColor
                    .overlay {
                        Text(candidateName.first!.uppercased())
                            .fontDesign(.rounded)
                            .font(font)
                            .fontWeight(.bold)
                            .foregroundStyle(textColor)
                    }
            }
        }
        .background(bgColor)
        .clipShape(Circle())
        .frame(
            width: size.width,
            height: size.height
        )
    }
}

#Preview {
    List {
        ElectionView(
            election: ElectionWidgetAttributes.ContentState.example2
        )
//        ElectionView(
//            election: ElectionWidgetAttributes.ContentState.example2
//        )
    }
}
