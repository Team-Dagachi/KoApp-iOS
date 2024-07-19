//
//  Chatting.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI

struct ChattingView: View {
    // MARK: - Properties
    // MARK: 채팅 관련 프로퍼티
    /// 대화 주제
    let chatTopic: SpeakingSubTopic
    
    /// Gemini와 채팅기능 담당
    @StateObject private var chatService: ChatService
    
    /// 채팅 메시지 배열
    var chatMessages: [ChatMessage] {
        chatService.messages
    }
    
    /// 힌트 보기 버튼 상태
    @State var showHint: Bool = false
    
    // MARK: STT 관련 프로퍼티
    /// STT기능 담당
    @StateObject private var sttService = STTService()
    
    /// STT로 인식한 텍스트
    var recognizedText: String {
        return sttService.recognizedText
    }
    
    /// 녹음 진행 상태
    var isRecording: Bool {
        return sttService.isRecording
    }
    
    
    // MARK: 텍스트 메시지 없으면 불편해서 개발중에만 쓰려고 만들어둔 프로퍼티
    /// (임시!) textField에서 사용할 입력 텍스트
    @State private var textInput = ""
    /// (임시22) textField에서 전송할 때 사용
    @State private var sendByText: Bool = false
    
    /// 생성자
    init(chatTopic: SpeakingSubTopic) {
        self.chatTopic = chatTopic
        _chatService = StateObject(wrappedValue: ChatService(chatTopic: chatTopic))
    }


    //  MARK: - View
    var body: some View {
        VStack(alignment: .leading) {
            chatMessageList()
                .padding(.top)
            hintAndRecordingButtons()
            textInputField()
        }
        .navigationTitle(chatTopic.rawValue)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(content: {
            ToolbarItem(placement: .principal) {
                Text(chatTopic.rawValue).font(.H2)
                    .foregroundStyle(Color.black)
            }
        })
        .foregroundStyle(.white)
        .background {
            ZStack {
                Color(.gray100)
                    .ignoresSafeArea()
            }
        }
    }
    
    @ViewBuilder
    private func chatMessageList() -> some View {
        // MARK: Chat Message List
        ScrollViewReader { proxy in
            ScrollView {
                ForEach(chatService.messages) { chatMessage in
                    // Message 객체가 isShowing 상태일 때만 보여주기
                    if chatMessage.isShowing {
                        ChatBox(chatMessage: chatMessage)
                            .padding([.horizontal, .bottom])
                            .onTapGesture {
                                handleTapOnFeedbackMessage(chatMessage)
                            }
                    }
                }
            }
            .onChange(of: chatMessages.last) { _ in
                scrollToLastMessage(proxy: proxy)
            }
        }
    }
    
    /// 가장 마지막에 생성된 메시지로 스크롤
    private func scrollToLastMessage(proxy: ScrollViewProxy) {
        guard let recentMessage = chatMessages.last else { return }
        DispatchQueue.main.async {
            withAnimation {
                proxy.scrollTo(recentMessage.id, anchor: .bottom)
            }
        }
    }
    
    // 힌트 버튼 & 녹음 버튼
    @ViewBuilder
    private func hintAndRecordingButtons() -> some View {
        ZStack {
            hintButton()
            recordingButton()
        }
        .padding(.bottom, 40)
    }
    
    // MARK: 힌트 버튼
    @ViewBuilder
    private func hintButton() -> some View {
        Button(action: {
            withAnimation {
                // 힌트 버튼 보기 전환
                showHint.toggle()
                print("showHint: \(showHint)")
            }
            // 메시지에서 힌트 보기 전환
            toggleHint()
        }) {
            Image("ic_bulb")
            Text(showHint ? "힌트 숨기기" : "힌트 보기")
                .fontWeight(.bold)
        }
        .foregroundStyle(Color.white)
        .padding(15)
        .background(showHint ? .gray500 : .orangeMedium)
        .clipShape(RoundedRectangle(cornerRadius: 40))
        .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
        .padding(.bottom, 0)
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .disabled(isRecording)    // 모델의 답변에 대한 힌트만 가능
    }
    
    /// 메시지 상에서 힌트 보기/숨기기
    /// - 힌트 보기
    /// 1. 이미 요청한 힌트가 있는지 확인하고
    /// 2. 없다면 Gemini 요청
    /// 3. 없다면 배열에 있는 힌트 보여주기
    /// - 힌트 숨기기: showHint와 isShowing 같도록
    private func toggleHint() {
        print("toggleHint() 호출됨")
        // 힌트 보기
        if showHint {
            // 이전 대화에서 힌트 요청한 적 있는 경우
            if let lastHintIndex = chatMessages.lastIndex(where: { $0.role == .hint }) {
                // 힌트가 메시지의 마지막이 아니라면
                if (chatMessages.count - 1) != lastHintIndex {
                    // 힌트 요청
                    print("새로운 힌트 요청")
                    Task {
                        await chatService.requestHint()
                    }
                }
                // 이미 요청했고, 숨기기만 해둔 힌트가 있는 경우
                else {
                    chatService.toggleMessageShowing(index: lastHintIndex) // true
                    print("숨겨둔 힌트 꺼냄")
                }
            }
            // 힌트를 한 번도 요청한 적 없는 경우
            else {
                // 힌트 요청
                print("새로운 채팅에서 힌트 요청")
                Task {
                    await chatService.requestHint()
                }
            }
        }
        // 힌트 숨기기
        else {
            if let lastHintIndex = chatMessages.lastIndex(where: { $0.role == .hint }) {
                chatService.toggleMessageShowing(index: lastHintIndex) // false
            }
        }
    }
    
    // MARK: 녹음 버튼
    @ViewBuilder
    private func recordingButton() -> some View {
        Button(action: {
            // 정지버튼 누름
            if isRecording {
                sttService.stopRecording()
                sendMessage(usingVoice: true)
            }
            // 녹음 버튼 누름
            else {
                sttService.startRecording()
            }
        }) {
            
            if isRecording {
                // 녹음 시작했을 때 정지버튼 보여주기
                Image(systemName: "square.fill")
                    .font(.title)
                    .frame(width: 64, height: 64)
                    .foregroundStyle(Color.white)
                    .background(Color(.main100))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            } else {
                // 녹음중이 아닐 때(시작하기 전), 녹음 버튼 보여주기
                Image("ic_mic_36")
                    .frame(width: 64, height: 64)
                    .foregroundStyle(Color.white)
                    .background(Color(.main100))
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
    
    // MARK: (임시) 텍스트로 채팅 보내기 zone
    @ViewBuilder
    private func textInputField() -> some View {
        HStack {
            TextField("메세지를 입력해주세요...", text: $textInput)
                .textFieldStyle(.roundedBorder)
                .foregroundStyle(.black)
                .disabled(chatService.loadingResponse)
            
            // Loading indicator
            if chatService.loadingResponse {
                ProgressView()
                    .tint(.white)
                    .frame(width: 30)
            } else {
                sendButton()
            }
        }
        .padding()
        .background(Color.white)
    }
    
    // MARK: 전송 버튼
    @ViewBuilder
    private func sendButton() -> some View {
        Button(action: {
            sendMessage(usingVoice: false)
        }) {
            Image(systemName: "paperplane.fill")
                .padding(.horizontal)
                .foregroundStyle(Color.yellow)
        }
        .frame(width: 30)
        .disabled(textInput.isEmpty)
    }
    
    // MARK: - Fetch Response
    private func sendMessage(usingVoice: Bool) {
        Task {
            // (임시!!) 텍스트로 보낼 때는 TextField에 있던 텍스트로 메시지 보내기
            let message = usingVoice ? recognizedText : textInput
            await chatService.sendMessage(message: message)
            
            // await chatService.sendMessage(message: recognizedText)
        }
        
        // 한 턴의 대화가 끝났으므로, 다음 대답을 위한 힌트 보기 버튼으로 바꾸기
        withAnimation {
            showHint = false
        }
    }
    
    /// 피드백이 있는 유저 말풍선을 누르면 피드백 말풍선을 띄울 수 있도록 하는 함수
    private func handleTapOnFeedbackMessage(_ chatMessage: ChatMessage) {
        // 메시지 인덱스 찾아내기
        guard let index = chatService.messages.firstIndex(of: chatMessage) else {
            print("handleTapOnChatMessage firstIndex 없음")
            return
        }
        // 유저의 말풍선 왼쪽에 번개 있는 경우, 피드백 말풍선 보여주고 ButtomButtons 숨기기(두 개 변수 반대로 토글)
        if (chatMessage.role == .user) && ((chatMessage.isNatural ?? true) == false) {
            chatService.toggleMessageShowing(index: index+1)
            chatService.toggleUserBottomButtons(index: index)
        }
    }
}

#Preview {
    ChattingView(chatTopic: .travel_plan)
}
