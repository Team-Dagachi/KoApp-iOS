//
//  Speaking04View.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/14/24.
//

import SwiftUI

struct Speaking04View: View {
    /// 대화주제
    let subTopic: SpeakingSubTopic
    
    /// 뷰모델
    var vm: Speaking04ViewModel {
        Speaking04ViewModel(subTopic: self.subTopic)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            chatMessageList()
                .padding(.top)
        }
        .background {
            ZStack {
                Color(.gray100)
                    .ignoresSafeArea()
            }
        }
        // 네비게이션 바 UI
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("표현집").font(.H3)
                    .foregroundStyle(Color.black)
            }
        }
        .foregroundStyle(.white)
    }
    
    // 표현집용 간단한 메시지 UI
    @ViewBuilder
    private func chatMessageList() -> some View {
        ScrollView {
            ForEach(vm.expressionSet) { chatMessage in
                ChatBox(chatMessage: chatMessage)
                    .padding([.horizontal, .bottom])
            }
        }
    }
}

#Preview {
    Speaking04View(subTopic: .media_game)
}
