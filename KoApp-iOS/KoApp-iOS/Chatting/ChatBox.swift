//
//  ChatBox.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI

struct ChatBox: View {
    let chatMessage: ChatMessage
    var message: String {
        chatMessage.message
    }
    var role: ChatRole {
        chatMessage.role
    }
    var boxColor: Color {
        return role == .model ? .white : Color(red: 253/255, green: 224/255, blue: 139/255)
    }
    @State var saved: Bool = false
    
    var body: some View {
        VStack {
            // 로딩중인 경우(모델 답변 기다리는중일 때)
            if message.isEmpty {
                HStack {
                    ProgressView()
                        .padding()
                        .background(boxColor)
                        .tint(.black)
                        .clipShape(ChatBubbleShape(role: role))
                    
                    Spacer()
                }
            }
            // 로딩 끝
            else {
                // 유저일 경우에 오른쪽부터 말풍선 띄워주기
                if role == .user {
                    // 말풍선
                    HStack (spacing: 12) {
                        Spacer()
                        
                        // TODO: 문장고침 여부에 따라 아이콘 바꾸기
                        Image("ic_check_fill")
                        
                        Text(message)
                            .padding(16)
                            .background(boxColor)
                            .foregroundColor(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    }
                    
                    // 버튼들
                    HStack (spacing: 8) {
                        Spacer()
                        // 스피커 버튼
                        Button(action: {
                            // TODO: TTS 호출
                            print("user_TTS 호출")
                        }) {
                            Image("ic_volume_up")
                                .frame(width: 40, height: 40)
                                .background(Color(red: 254/255, green: 236/255, blue: 186/255)) // TODO: 나중에 MainColor/Main-30으로 대체
                                .clipShape(Circle())
                                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                        }
                        // 번역 버튼
                        Button(action: {
                            // TODO: 번역 호출
                            print("user_번역 호출")
                        }) {
                            Image("ic_translate")
                                .frame(width: 40, height: 40)
                                .background(Color(red: 254/255, green: 236/255, blue: 186/255)) // 나중에 MainColor/Main-30으로 대체
                                .clipShape(Circle())
                                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                        }

                    }

                // 모델일 경우 왼쪽부터 말풍선 띄워주기
                } else {
                    HStack (spacing: 12) {
                        Text(message)
                            .padding(16)
                            .background(boxColor)
                            .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))
                        
                        Button(action: {
                            saved.toggle()
                            // TODO: 누르면 저장되도록 하기
                        }, label: {
                            Image(saved ? "ic_bookmark_fill" : "ic_bookmark")
                        })
                        
                        Spacer()
                    }
                    
                    HStack (spacing: 8) {
                        // 스피커 버튼
                        Button(action: {
                            // TODO: TTS 호출
                            print("model_tts 호출")
                        }) {
                            Image("ic_volume_up")
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                        }
                        
                        // 번역 버튼
                        Button(action: {
                            // TODO: 번역 호출
                            print("model_번역 호출")
                        }) {
                            Image("ic_translate")
                                .frame(width: 40, height: 40)
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                        }
                        
                        Spacer()
                    }
                    
                }
            }
            }
    }
}

struct ChatBubbleShape: Shape {
    /// 채팅 역할에 따라 모양 달라져야하기 때문에 채팅 역할이 모델인지, 유저인지 입력받음
    let role: ChatRole
    
    /// 모델이면 왼쪽 끝 뾰족하게 계산
    var topLeftRadius: CGFloat {
        return role == .model ? 4 : 16
    }
    /// 유저면 오른쪽 끝 뾰족하게 계산
    var topRightRadius: CGFloat {
        return role == .user ? 4 : 16
    }
    // 나머지는 16으로 고정
    let bottomLeftRadius: CGFloat = 16
    let bottomRightRadius: CGFloat = 16

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        
        // 시작점 설정
        path.move(to: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY))
        
        // 오른쪽 상단 모서리
        path.addArc(withCenter: CGPoint(x: rect.maxX - topRightRadius, y: rect.minY + topRightRadius),
                    radius: topRightRadius,
                    startAngle: .pi * 1.5,
                    endAngle: 0,
                    clockwise: true)
        
        // 오른쪽 하단 모서리
        path.addArc(withCenter: CGPoint(x: rect.maxX - bottomRightRadius, y: rect.maxY - bottomRightRadius),
                    radius: bottomRightRadius,
                    startAngle: 0,
                    endAngle: .pi * 0.5,
                    clockwise: true)
        
        // 왼쪽 하단 모서리
        path.addArc(withCenter: CGPoint(x: rect.minX + bottomLeftRadius, y: rect.maxY - bottomLeftRadius),
                    radius: bottomLeftRadius,
                    startAngle: .pi * 0.5,
                    endAngle: .pi,
                    clockwise: true)
        
        // 왼쪽 상단 모서리
        path.addArc(withCenter: CGPoint(x: rect.minX + topLeftRadius, y: rect.minY + topLeftRadius),
                    radius: topLeftRadius,
                    startAngle: .pi,
                    endAngle: .pi * 1.5,
                    clockwise: true)
        
        // 경로를 닫음
        path.close()
        
        return Path(path.cgPath)
    }
}

#Preview {
    ChatBox(chatMessage: ChatMessage(role: .user, message: "여행 계획 있으신가요?"))
}

