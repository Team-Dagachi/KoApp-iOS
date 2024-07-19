//
//  Speaking03View.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/14/24.
//

import SwiftUI

struct Speaking03View: View {
    let subTopic: SpeakingSubTopic
    
    var vm: Speaking03ViewModel {
        Speaking03ViewModel(subTopic: self.subTopic)
    }
    
    var body: some View {
        ZStack {
            Color.gray100
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                ScrollView {
                    Text("상황")
                        .font(.H4)
                        .foregroundStyle(Color.gray500)
                        .padding(.top, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(vm.situation)
                        .font(.subTitle)
                        .padding(.vertical, 24)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .foregroundStyle(Color.white)
                        )
                    
                    Text("대화 Tip")
                        .font(.H4)
                        .foregroundStyle(Color.gray500)
                        .padding(.top, 30)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // 대화 tip 리스트
                    VStack(alignment: .leading, spacing: 0) {
                        ForEach(Array(vm.speakingTips.enumerated()), id: \.element) { index, tip in
                            Text(tip)
                                .font(.H4)
                                .padding(.vertical, 24)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.white)
                            if index < vm.speakingTips.count - 1 {
                                Divider()
                            }
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                    NavigationLink {
                        ChattingView(chatTopic: self.subTopic)
                            .toolbarRole(.editor)
                    } label: {
                        Text("연습하기")
                            .font(.H3)
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 16)
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 48)
                                    .foregroundStyle(Color.main100)
                            )
                    }
                    .padding(.top, 40)
                }

                
            }
            .padding(.horizontal, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(subTopic.rawValue).font(.H2)
            }
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    Speaking04View()
                        .toolbarRole(.editor)
                } label: {
                    Image("ic_history_24")
                }
            }
        })
        
    }
}

#Preview {
    Speaking03View(subTopic: .travel_experience)
}
