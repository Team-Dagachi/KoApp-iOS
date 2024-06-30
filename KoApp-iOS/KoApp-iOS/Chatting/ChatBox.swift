//
//  ChatBox.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI
import Foundation

struct ChatBox: View {
    // MARK: - Property
    /// id, role, message 값 들어있는 메시지 객체
    let chatMessage: ChatMessage
    
    /// 메시지 텍스트
    var message: String {
        chatMessage.message
    }
    
    /// 메시지 역할(user || model)
    var role: ChatRole {
        chatMessage.role
    }
    
    /// 역할에 따라 달라지는 말풍선 색상 계산
    var boxColor: Color {
        switch role {
        case .model:
            return .white
        case .user:
            return .main50
        case .hint:
            return .main50
        case .feedback:
            return .orangeLight
        }
    }
    
    /// 책갈피 저장했는지 여부
    @State var saved: Bool = false
    
    // MARK: - View
    var body: some View {
        // TODO: 중복되는 스피커, 번역 버튼 bottomButtons로 리팩토링하기
        // TODO: extension에 변수 만드는 방식으로 body 깔끔하게 리팩토링하기
        VStack {
            // MARK: - .user 말풍선
            if role == .user {
                // 말풍선
                HStack (spacing: 12) {
                    Spacer()
                    
                    // MARK: 문장 피드백 아이콘
                    if chatMessage.isNatural == nil {
                        ProgressView()
                    } else if chatMessage.isNatural == false {
                        Image("ic_feedback_28")
                    } else {
                        Image("ic_check_fill")
                    }
                    
                    // MARK: 말풍선
                    if message.isEmpty {
                        ProgressView()
                            .padding()
                            .background(boxColor)
                            .tint(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    } else {
                        Text(message)
                            .padding(16)
                            .background(boxColor)
                            .foregroundColor(.black)
                            .clipShape(ChatBubbleShape(role: role))
                            .onTapGesture {
                                // TODO: 부자연스럽다고 뜰 경우에 말풍선 탭하면 밑에 feedback이 보이도록
                                if chatMessage.isNatural == false {
                                    print("feedback toggle")
                                }
                            }
                    }
                }
                
                // MARK: 스피커, 번역 버튼
                // 문장 바꿔야 하는 경우에는 안보이도록 함
                // TODO: 바꾼 문장 확인하기 눌렀을 때 없어지도록 추후 변경하기
                if chatMessage.isNatural == true || chatMessage.isNatural == nil {
                    HStack (spacing: 8) {
                        Spacer()
                        // 스피커 버튼
                        Button(action: {
                            // TODO: TTS 호출
                            print("user_TTS 호출")
                        }) {
                            Image("ic_volume_up")
                                .frame(width: 40, height: 40)
                                .background(Color(.main30))
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
                                .background(Color(.main30))
                                .clipShape(Circle())
                                .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                        }
                    }
                }
                
                
            // MARK: - .model 말풍선
            } else if role == .model {
                HStack (spacing: 12) {
                    // 로딩중일 때 ProgressView 보여주기
                    if message.isEmpty {
                        ProgressView()
                            .padding()
                            .background(boxColor)
                            .tint(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    } else {
                        // 로딩 끝나면 텍스트 띄우기
                        Text(message)
                            .padding(16)
                            .background(boxColor)
                            .foregroundColor(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    }
                    
                    // MARK: 북마크 저장하기 버튼
                    Button(action: {
                        saved.toggle()
                        // TODO: 누르면 저장되도록 하기
                    }, label: {
                        Image(saved ? "ic_bookmark_fill" : "ic_bookmark")
                    })
                    
                    Spacer()
                }
                
                // MARK: 스피커, 번역 버튼
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
            // MARK: - .feedback 말풍선
            } else if role == .feedback {
                HStack (spacing: 12) {
                    Spacer()
                    
                    // MARK: 북마크 저장하기 버튼
                    Button(action: {
                        saved.toggle()
                        // TODO: 누르면 저장되도록 하기
                    }, label: {
                        Image(saved ? "ic_bookmark_fill" : "ic_bookmark")
                    })
                    
                    // MARK: 말풍선
                    if message.isEmpty {
                        ProgressView()
                            .padding()
                            .background(boxColor)
                            .tint(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    } else {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(message)
                            Divider()
                            Text(chatMessage.reasonForChange ?? "바뀌는 이유")
                                .lineLimit(5)
                        }
                        .padding(16)
                        .background(boxColor)
                        .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))
                    }
                }
                .padding(.top, -10)
                
                // MARK: 스피커, 번역 버튼
                HStack (spacing: 8) {
                    Spacer()
                    // 스피커 버튼
                    Button(action: {
                        // TODO: TTS 호출
                        print("user_TTS 호출")
                    }) {
                        Image("ic_volume_up")
                            .frame(width: 40, height: 40)
                            .background(Color(.orangeLight))
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
                            .background(Color(.orangeLight))
                            .clipShape(Circle())
                            .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
                    }
                }

                
            // MARK: - .hint 말풍선
            } else if role == .hint {
                HStack (spacing: 12) {
                    Spacer()

                    VStack(alignment: .leading) {
                        Text("💡힌트")
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
                        
                        // MARK: 말풍선
                        if message.isEmpty {
                            ProgressView()
                                .padding()
                                .background(boxColor)
                                .tint(.black)
                                .clipShape(ChatBubbleShape(role: role))
                        } else {
                            Text(message)
                                .padding(16)
                                .background(boxColor)
                                .foregroundColor(.black)
                                .clipShape(ChatBubbleShape(role: role))
                        }
                    }
                }
                
                // MARK: 스피커, 번역 버튼
                HStack (spacing: 8) {
                    Spacer()
                    // 스피커 버튼
                    Button(action: {
                        // TODO: TTS 호출
                        print("user_TTS 호출")
                    }) {
                        Image("ic_volume_up")
                            .frame(width: 40, height: 40)
                            .background(Color(.main30))
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
                            .background(Color(.main30))
                            .clipShape(Circle())
                            .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
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
    /// 유저, 고친문장, 힌트면 오른쪽 끝 뾰족하게 계산
    var topRightRadius: CGFloat {
        return role == .user || role == .feedback || role == .hint ? 4 : 16
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

extension ChatBox {
    private var bottomButtons: some View {
        // TODO: chatBox 타입에 따라 버튼 색상 다르게
        // TODO: 스피킹, 번역 실행중인지 여부에 따라 버튼 진하기(색상) 다르게
        HStack (spacing: 8) {
            Spacer()
            // 스피커 버튼
            Button(action: {
                // TODO: TTS 호출
                print("user_TTS 호출")
            }) {
                Image("ic_volume_up")
                    .frame(width: 40, height: 40)
                    .background(Color(red: 1, green: 0.8, blue: 0.68)) // TODO: 이 부분
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
                    .background(Color(red: 1, green: 0.8, blue: 0.68)) // TODO: 이 부분
                    .clipShape(Circle())
                    .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
            }
        }
    }
}
