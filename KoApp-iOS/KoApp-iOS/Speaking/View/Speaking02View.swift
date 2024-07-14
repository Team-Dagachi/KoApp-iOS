//
//  Speaking02View.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/7/24.
//

import SwiftUI

struct Speaking02View: View {
    /// 화면 전환용
    @Environment(\.presentationMode) var presentationMode
    
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
            Button(action: {
                // 이전 화면으로 이동
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("ic_chevron_left")
                        .padding(.leading, 16)
                    Spacer()
                }
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
                    
                    NavigationLink {
                        Speaking03View(subTopic: topic)
                            .toolbarRole(.editor)
                    } label: {
                        Speaking02Row(isCompleted: complete, subTopic: topic.rawValue)
                            .padding(.horizontal, 16)
                    }

                }
                
                Spacer()
            }
        }
        .background(Color.gray100)
        // 한땀한땀 수제 제작) 이전화면으로 이동하는 제스처
        .gesture(
            DragGesture()
                .onChanged { value in
                    let startLocation = value.startLocation.x
                    
                    // 왼쪽 끝에서 시작된 드래그인지 확인
                    if startLocation < 50 {
                        let dragDistance = value.translation.width
                        // 오른쪽으로의 드래그 거리가 충분한지 확인
                        if dragDistance > 30 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
        )
    }
}

#Preview {
    Speaking02View(mainTopic: .school)
}
