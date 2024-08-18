//
//  ChatBox.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI
import Foundation

struct ChatBox: View {
    // FIXME: 힌트 번역된 상태에서 말하거나 텍스트 입력하기 시작하면 progressView로 바뀐다...어째서....
    // MARK: - Property
    /// id, role, message 값 들어있는 메시지 객체
    let chatMessage: ChatMessage
    
    /// 메시지 텍스트
    var message: String {
        // 피드백 말풍선일 경우 reasonForChange가 번역될 예정
        if isTranslating == false || role == .feedback {
            chatMessage.message
        } else {
            translateService.translatedText
        }
    }
    
    /// role이 피드백일 경우, 바뀌는 이유 텍스트
    var reasonForChange: String? {
        if isTranslating == false {
            chatMessage.reasonForChange ?? "바뀌는 이유"
        } else {
            translateService.translatedText
        }
    }
    
    /// 메시지 역할
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
        case .ex_user:
            return .main50
        case .ex_model:
            return .white
        }
    }
    
    /// 하단 스피커버튼 실행중인지 여부에 따라 버튼 진하기(색상) 다르게
    var speakerButtonColor: Color {
        switch role {
        case .model:
            if isSpeaking {
                return .gray400
            } else { return .white }
        case .user:
            if isSpeaking {
                return .main70
            } else { return .main30 }
        case .hint:
            if isSpeaking {
                return .main70
            } else { return .main30 }
        case .feedback:
            if isSpeaking {
                return .orangeDark
            } else { return .orangeLight }
        case .ex_user:
            if isSpeaking {
                return .main70
            } else { return .main30 }
        case .ex_model:
            if isSpeaking {
                return .gray400
            } else { return .white }
        }
    }
    
    /// 하단 번역버튼 실행중인지 여부에 따라 버튼 진하기(색상) 다르게
    var translateButtonColor: Color {
        switch role {
        case .model:
            if isTranslating {
                return .gray400
            } else { return .white }
        case .user:
            if isTranslating {
                return .main70
            } else { return .main30 }
        case .hint:
            if isTranslating {
                return .main70
            } else { return .main30 }
        case .feedback:
            if isTranslating {
                return .orangeDark
            } else { return .orangeLight }
        case .ex_user:
            if isTranslating {
                return .main70
            } else { return .main30 }
        case .ex_model:
            if isTranslating {
                return .gray400
            } else { return .white }
        }
    }
    
    /// 책갈피 저장했는지 여부
    @State var saved: Bool = false
    
    /// TTS 호출용
    @ObservedObject var ttsService = TTSService()
    
    /// TTS 실행 상태를 나타내는 변수
    private var isSpeaking: Bool {
        ttsService.isSpeaking
    }
    
    /// 번역 호출용
    @ObservedObject var translateService = TranslateService()
    
    /// 번역된 텍스트가 보이는지
    @State var isTranslating: Bool = false
    
    /// user 말풍선 밑에 bottomButtons 보이게 할 것인지
    var showUserButtomButtons: Bool {
        self.chatMessage.showBottomButtons
    }
    
    // MARK: - View
    var body: some View {
        switch role {
        // 유저 말풍선
        case .user:
            userBubble
            
        // 모델 말풍선
        case .model:
            modelBubble
            
        // 피드백 말풍선
        case .feedback:
            feedbackBubble
                .padding(.top, -10)
            
        // 힌트 말풍선
        case .hint:
            hintBubble
            
        // 표현집-유저 말풍선
        case .ex_user:
            expressionUserBubble
            
        // 표현집-모델 말풍선
        case .ex_model:
            expressionModelBubble
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

// MARK: - Preview
#Preview {
    // 말풍선 모양 더 잘보이게 회색 화면 위에 띄워봄
    ZStack {
        Color.gray300
        
        ChatBox(chatMessage: ChatMessage(role: .hint, message: "여행 계획 있으신가요?"))
    }
}

// MARK: - extension
extension ChatBox {
    /// 일반 채팅용 유저 버블 UI
    private var userBubble: some View {
        VStack(spacing: 12) {
            // 말풍선
            HStack (spacing: 12) {
                Spacer()
                
                // 문장 피드백 아이콘
                if chatMessage.isNatural == nil {
                    ProgressView()
                } else if chatMessage.isNatural == false {
                    Image("ic_feedback_28")
                } else {
                    Image("ic_check_fill")
                }
                
                // 말풍선
                if message.isEmpty {
                    ProgressView()
                        .padding()
                        .background(boxColor)
                        .tint(.black)
                        .clipShape(ChatBubbleShape(role: role))
                } else {
                    Text(message)
                        .font(.body1)
                        .padding(16)
                        .background(boxColor)
                        .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))
                }
            }
            
            // 스피커, 번역 버튼
            // 피드백 말풍선 밑에 띄우는 경우에는 안보이도록 함
            if showUserButtomButtons {
                bottomButtons
            }
        }
    }
    
    /// 일반 채팅용 모델 버블 UI
    private var modelBubble: some View {
        VStack(spacing: 12) {
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
                        .font(.body1)
                        .padding(16)
                        .background(boxColor)
                        .foregroundColor(.black)
                        .clipShape(ChatBubbleShape(role: role))
                }
                
                // 북마크 저장하기 버튼
                bookmarkButton
                
                Spacer()
            }
            
            // 스피커, 번역 버튼
            bottomButtons
        }
    }
    
    /// 피드백용 버블 UI
    private var feedbackBubble: some View {
        VStack(spacing: 12) {
            HStack (spacing: 12) {
                Spacer()
                
                // 북마크 저장하기 버튼
                bookmarkButton
                
                // 말풍선
                if message.isEmpty {
                    ProgressView()
                        .padding()
                        .background(boxColor)
                        .tint(.black)
                        .clipShape(ChatBubbleShape(role: role))
                } else {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(message)
                            .font(.body1)
                        Divider()
                        Text(self.reasonForChange ?? "바뀌는 이유")
                            .font(.body1)
                            .lineLimit(5)
                    }
                    .padding(16)
                    .background(boxColor)
                    .foregroundColor(.black)
                    .clipShape(ChatBubbleShape(role: role))
                }
            }
            
            // 스피커, 번역 버튼
            bottomButtons
        }
    }
    
    /// 힌트용 버블 UI
    private var hintBubble: some View {
        VStack(spacing: 12) {
            HStack (spacing: 12) {
                Spacer()

                VStack(alignment: .leading) {
                    Text("💡힌트")
                        .font(.Popup1)
                        .foregroundStyle(Color.black)
                    
                    // 말풍선
                    if message.isEmpty {
                        ProgressView()
                            .padding()
                            .background(boxColor)
                            .tint(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    } else {
                        Text(message)
                            .font(.body1)
                            .padding(16)
                            .background(boxColor)
                            .foregroundColor(.black)
                            .clipShape(ChatBubbleShape(role: role))
                    }
                }
            }
            
            // 스피커, 번역 버튼
            bottomButtons
        }
    }
    
    /// 표현집용 유저 버블 UI
    private var expressionUserBubble: some View {
        VStack(spacing: 12) {
            // 말풍선
            HStack (spacing: 12) {
                Spacer()
                
                // 북마크 저장하기 버튼
                bookmarkButton
                                
                // 말풍선
                Text(message)
                    .font(.body1)
                    .padding(16)
                    .background(boxColor)
                    .foregroundColor(.black)
                    .clipShape(ChatBubbleShape(role: role))
            }
            
            // 스피커, 번역 버튼
            // 피드백 말풍선 밑에 띄우는 경우에는 안보이도록 함
            if showUserButtomButtons {
                bottomButtons
            }
        }
    }
    
    /// 표현집용 모델 버블 UI
    private var expressionModelBubble: some View {
        VStack(spacing: 12) {
            HStack (spacing: 12) {
                // 모델 메시지
                Text(message)
                    .font(.body1)
                    .padding(16)
                    .background(boxColor)
                    .foregroundColor(.black)
                    .clipShape(ChatBubbleShape(role: role))
                                
                Spacer()
            }
            
            // 스피커, 번역 버튼
            bottomButtons
        }
    }
    
    /// 스피커 & 번역 버튼용 UI
    private var bottomButtons: some View {
        HStack (spacing: 8) {
            // model 빼고 왼쪽에 Spacer(user, hint, feedback)
            if !(role == .model || role == .ex_model) {
                Spacer()
            }
            
            // MARK: 스피커 버튼
            Button(action: {
                // TTS 호출
                if role != .feedback {
                    // 피드백 아닌 말풍선일 경우, 메시지 텍스트 읽기
                    ttsService.speak(message)
                } else {
                    // 피드백 말풍선일 경우에 피드백 메시지와 고친 이유까지 같이 읽어주기
                    guard let reasonForChange = self.chatMessage.reasonForChange else { return }
                    ttsService.speak(message+reasonForChange)
                }
            }) {
                // 피드백 진한 주황버튼일 때는 버튼 아이콘 흰색이어야 함
                Image((role == .feedback && isSpeaking) ? "ic_volume_up_white" : "ic_volume_up")
                    .frame(width: 40, height: 40)
                    .background(speakerButtonColor)
                    .clipShape(Circle())
                    .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
            }
            // MARK: 번역 버튼
            Button(action: {
                isTranslating.toggle()

                if isTranslating {
                    // 번역할 텍스트 경우에 따라 나누기
                    // 피드백 말풍선일 경우, 바꾸는 이유(reasonForChange)를 번역해주기
                    // 피드백 이외 말풍선일 때는 기본 메시지 번역해주기
                    var textToTranslate = (role == .feedback && chatMessage.reasonForChange != nil) ? chatMessage.reasonForChange! : chatMessage.message
                    // 번역 호출
                    translateService.translateText(text: textToTranslate)
                }
            }) {
                // 피드백 진한 주황버튼일 때는 버튼 아이콘 흰색이어야 함
                Image((role == .feedback && isTranslating) ? "ic_translate_white" : "ic_translate")
                    .frame(width: 40, height: 40)
                    .background(translateButtonColor)
                    .clipShape(Circle())
                    .shadow(color: Color(red: 0.24, green: 0.26, blue: 0.27).opacity(0.12), radius: 4, x: 0, y: 4)
            }
            
            // 모델이라면 오른쪽에 Spacer
            if role == .model || role == .ex_model {
                Spacer()
            }
        }
    }
    
    /// 북마크(저장) 버튼 UI
    private var bookmarkButton: some View {
        Button {
            saved.toggle()
            // TODO: 누르면 저장되도록 하기(API 호출)
        } label: {
            Image(saved ? "ic_bookmark_fill" : "ic_bookmark")
        }
    }
}
