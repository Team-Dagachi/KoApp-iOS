//
//  Chatting.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI

struct ChattingView: View {
    /// Gemini와 채팅기능 담당
    @State private var chatService = ChatService()
    
    /// STT기능 담당
    @StateObject private var speechViewModel = SpeechViewModel()
    
    /// STT로 인식한 텍스트
    var recognizedText: String {
        return speechViewModel.recognizedText
    }
    
    /// 녹음 진행 상태
    var isRecording: Bool {
        return speechViewModel.isRecording
    }
    
    /// 힌트 보기 버튼 상태
    @State var showHint: Bool = false
    
    // 텍스트 메시지 없으면 불편해서 개발중에만 쓰려고 만들어두는 변수들
    /// (임시!) textField에서 사용할 입력 텍스트
    @State private var textInput = ""
    /// (임시22) textField에서 전송할 때 사용
    @State private var sendByText: Bool = false


    var body: some View {
        VStack(alignment: .leading) {
            //MARK: - Chat Message List
            ScrollViewReader(content: { proxy in
                ScrollView {
                    ForEach(chatService.messages) { chatMessage in
                        //MARK: - Chat Message View
//                        if chatMessage.isShowing {
                            ChatBox(chatMessage: chatMessage)
                                .padding([.horizontal, .bottom])
//                        }
                    }
                }
                // 가장 마지막에 생성된 메시지로 스크롤해주기
                .onChange(of: chatService.messages) {
                    guard let recentMessage = chatService.messages.last else { return }
                    
                    DispatchQueue.main.async {
                        withAnimation {
                            proxy.scrollTo(recentMessage.id, anchor: .bottom)
                        }
                    }
                }
            })
            
            VStack {
                ZStack() {
                    // MARK: - Hint Button
                    Button(action: {
                        print("힌트 보기")
                        withAnimation {
                            showHint.toggle()
                        }
                        // TODO: 힌트 보기 호출하기
                        
                    }, label: {
                        Image("ic_bulb")
                        Text(showHint ? "힌트 숨기기" : "힌트 보기")
                            .fontWeight(.bold)
                    })
                    .foregroundStyle(Color.white)
                    .padding(15)
                    // TODO: orange-medium으로 색이름 대체
                    .background(showHint ? Color(red: 0.57, green: 0.59, blue: 0.6) : Color(red: 0.99, green: 0.56, blue: 0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                    .padding(.bottom, 0)
                    .padding(.leading, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    // MARK: 녹음 버튼(&정지 버튼)
                    Button(action: {
                        speechViewModel.startRecording()
                        // 정지 버튼 눌렀을 때 메시지 전송
                        if !isRecording {
                            print(recognizedText)
                            sendMessage(usingVoice: true)
                        }
                    }) {
                        if isRecording {
                            // 녹음 시작했을 때 정지버튼 보여주기
                            Image(systemName: "square.fill")
                                .font(.title)
                                .frame(width: 64, height: 64)
                                .foregroundStyle(Color.white)
                                .background(Color(red: 0.99, green: 0.76, blue: 0.09))
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        } else {
                            // 녹음중이 아닐 때(시작하기 전), 녹음 버튼 보여주기
                            Image("ic_mic_36")
                                .frame(width: 64, height: 64)
                                .foregroundStyle(Color.white)
                                .background(Color(red: 0.99, green: 0.76, blue: 0.09))
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)

                }
                .padding(.bottom, 40)
                
                // MARK: - Text Input Field & Send Button
                HStack {
                    TextField("메세지를 입력해주세요...", text: $textInput)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(.black)
//                        .focused($isFocused)
                        .disabled(chatService.loadingResponse)
                    
                    if chatService.loadingResponse {
                        // Loading indicator
                        ProgressView()
                            .tint(.white)
                            .frame(width: 30)
                    } else {
                        // Send Button
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
                }
                .padding()
                .background(Color.white)
            }

        }
        .foregroundStyle(.white)
        .background {
            //MARK: - Background
            ZStack {
                Color(red: 247/255, green: 249/255, blue: 250/255)
            }
            .ignoresSafeArea()

        }
        
        

    }

    //MARK: - Fetch Response
    private func sendMessage(usingVoice: Bool) {
        Task {
            // (임시!!) 텍스트로 보낼 때는 TextField에 있던 텍스트로 메시지 보내기
            await chatService.sendMessage(message: usingVoice ? recognizedText : textInput)
            
//            await chatService.sendMessage(message: recognizedText)
        }
    }

    

}

#Preview {
    ChattingView()
}
