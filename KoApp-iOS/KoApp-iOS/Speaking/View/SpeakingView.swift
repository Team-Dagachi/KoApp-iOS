//
//  SpeakingView.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/3/24.
//

import SwiftUI

struct SpeakingView: View {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
        
    var body: some View {
        GeometryReader { geometry in
            // TODO: -100 나중에 상황에 맞게 바꾸기
            // 화면 높이에 맞춰 항목의 높이를 조정
            let itemHeight = (geometry.size.height - 100) / 3
            
            LazyVGrid(columns: columns, spacing: geometry.size.height > 700 ? 24 : 20) {
                ForEach(SpeakingTopic.allCases) { topic in
                    NavigationLink {
                        Speaking02View(mainTopic: topic)
                            .toolbar(.hidden)
                    } label: {
                        SketchbookItemView(topic: topic, height: itemHeight)
                    }
                }
            }
            .padding(.horizontal, geometry.size.width > 400 ? 20 : 10)
            .frame(width: geometry.size.width)
        }
        .background(Color.main10)
        .task {
            print("SpeakingView 켜짐!")
        }
    }
}

#Preview {
    SpeakingView()
}
