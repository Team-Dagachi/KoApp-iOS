//
//  Speaking04View.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 7/14/24.
//

import SwiftUI

struct Speaking04View: View {
    // MARK: - Properties
    /// 대화 주제
    let chatTopic: SpeakingSubTopic
    
//    /// Gemini와 채팅기능 담당
//    @StateObject private var chatService: ChatService
    
    // !!!: 이건 필요한거임. 그냥 아직 데이터 안들어가서 에러날까봐 주석처리해놓은거임!!
//    /// 채팅 메시지 배열
//    var chatMessages: [ChatMessage] /*{
//        chatService.messages
//    }*/
    
//    /// 힌트 보기 버튼 상태
//    @State var showHint: Bool = false
    
//    // MARK: STT 관련 프로퍼티
//    /// STT기능 담당
//    @StateObject private var sttService = STTService()
//    
//    /// STT로 인식한 텍스트
//    var recognizedText: String {
//        return sttService.recognizedText
//    }
//    
//    /// 녹음 진행 상태
//    var isRecording: Bool {
//        return sttService.isRecording
//    }
    
    
//    // MARK: 텍스트 메시지 없으면 불편해서 개발중에만 쓰려고 만들어둔 프로퍼티
//    /// (임시!) textField에서 사용할 입력 텍스트
//    @State private var textInput = ""
//    /// (임시22) textField에서 전송할 때 사용
//    @State private var sendByText: Bool = false
    
//    /// 생성자
//    init(chatTopic: SpeakingSubTopic) {
//        self.chatTopic = chatTopic
//    }


    //  MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            Text("안녕하십니다~!!")
//            chatMessageList()
//                .padding(.top)
//            hintAndRecordingButtons()
//            textInputField()
        }
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar(content: {
//            ToolbarItem(placement: .principal) {
//                Text("표현집").font(.H2)
//                    .foregroundStyle(Color.black)
//            }
//        })
//        .foregroundStyle(.white)
//        .background {
//            ZStack {
//                Color(.gray100)
//                    .ignoresSafeArea()
//            }
//        }
    }
    
//    @ViewBuilder
//    private func chatMessageList() -> some View {
//        // MARK: Chat Message List
//        ScrollViewReader { proxy in
//            ScrollView {
//                ForEach(chatService.messages) { chatMessage in
//                    // Message 객체가 isShowing 상태일 때만 보여주기
//                    if chatMessage.isShowing {
//                        ChatBox(chatMessage: chatMessage)
//                            .padding([.horizontal, .bottom])
//                    }
//                }
//            }
//        }
//    }
}

#Preview {
    Speaking04View(chatTopic: .family_introduce)
}
