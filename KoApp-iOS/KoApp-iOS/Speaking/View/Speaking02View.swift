//
//  Speaking02View.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/7/24.
//

import SwiftUI

struct Speaking02View: View {
    let mainTopic: SpeakingTopic
    
    var vm: Speaking02ViewModel {
        Speaking02ViewModel(mainTopic: self.mainTopic)
    }
    
    var subTopics: [SpeakingSubTopic] {
        vm.subTopics
    }
    
    var completed: [Bool] {
        vm.completed
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            HStack {
                Image("ic_chevron_left")
                    .padding(.leading, 16)
                Spacer()
            }
            .padding(.top, 24)
            
            VStack(spacing: 16.0) {
                Image(mainTopic.icon)
                    .padding(.top, 16)
                
                Text(mainTopic.rawValue)
                    .font(.H2)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                ForEach(Array(subTopics.indices), id: \.self) { index in
                    let topic = subTopics[index]
                    let complete = completed[index]
                    
                    Speaking02Row(isCompleted: complete, subTopic: topic.rawValue)
                        .padding(.horizontal, 16)
                }
                
                Spacer()
            }
        }
        .background(Color.gray100)
    }
}

#Preview {
    Speaking02View(mainTopic: .school)
}
