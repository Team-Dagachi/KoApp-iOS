//
//  Chatting.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI

struct ChattingView: View {
    @State private var textInput = ""
    @State private var chatService = ChatService()
    @FocusState private var isFocused: Bool
    
    @State var showHint: Bool = false


    var body: some View {
        VStack(alignment: .leading) {
            //MARK: - Chat Message List
            ScrollViewReader(content: { proxy in
                ScrollView {
                    ForEach(chatService.messages) { chatMessage in
                        //MARK: - Chat Message View
                        ChatBox(chatMessage: chatMessage)
                            .padding([.horizontal, .bottom])
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
            
            
            VStack(alignment: .leading) {
                // MARK: - Hint Button
                Button(action: {
                    print("힌트 보기")
                    showHint.toggle()
                    // TODO: 힌트 보기 호출하기
                    
                }, label: {
                    Image("ic_bulb")
                    Text(showHint ? "힌트 숨기기" : "힌트 보기")
                })
                .foregroundStyle(Color.white)
                // TODO: orange-medium으로 색이름 대체
                .padding()
                .background(showHint ? Color(red: 0.57, green: 0.59, blue: 0.6) : Color(red: 0.99, green: 0.56, blue: 0.3))
                .clipShape(RoundedRectangle(cornerRadius: 40))
                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                .padding(.bottom, 0)
                .padding(.leading, 10)
                
                // TODO: TextField -> STT 녹음 버튼으로 전환 필요
                // MARK: - Input Field
                HStack {
                    TextField("메세지를 입력해주세요...", text: $textInput)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(.black)
                        .focused($isFocused)
                        .disabled(chatService.loadingResponse)
                        
                    if chatService.loadingResponse {
                        //MARK: - Loading indicator
                        ProgressView()
                            .tint(.white)
                            .frame(width: 30)
                    } else {
                        //MARK: - Send Button
                        Button(action: sendMessage, label: {
                            Image(systemName: "paperplane.fill")
                                .padding(.horizontal)
                                .foregroundStyle(Color.yellow)
                        })
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
            .onTapGesture {
                isFocused = false
            }
        }
        
        

    }

    //MARK: - Fetch Response
    private func sendMessage() {
        Task {
            await chatService.sendMessage(message: textInput)
            textInput.removeAll()
        }
    }

    

}

#Preview {
    ChattingView()
}
