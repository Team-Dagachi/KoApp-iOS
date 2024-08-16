//
//  ChatService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 5/31/24.
//

import SwiftUI
import GoogleGenerativeAI

/// 메인 대화용 멀티턴 Gemini API 서비스
/// - 대화 수행
/// - 문장검사 호출
/// - 요청한 경우 힌트 대답
@Observable
class ChatService: ObservableObject {
    // MARK: - Property
    /// 스피킹 데이터 모음
    let speakingData: SpeakingData
    
    /// 대화 주제
    let chatTopic: SpeakingSubTopic
    
    /// UI에서 메시지 보여주기 위한 배열
    private(set) var messages: [ChatMessage]
    
    /// Gemini API 멀티턴 대화를 위한 대화 맥락 히스토리
    private(set) var history: [ModelContent]
    
    /// 주제별 대화를 위해 다르게 입력되어야 하는 프롬프트 텍스트
    var systemInstruction: String
    
    /// 문법검사 완료됐는지 확인
    private(set) var loadingResponse = false
    
    /// 문장검사용 Gemini 모델
    var grammarService: GrammarService
    
    /// 힌트 요청용 Gemini 모델
    var hintService: HintService
    
    /// TTS 서비스
    var ttsService: TTSService
    
    
    // MARK: - Method
    init(chatTopic: SpeakingSubTopic, speakingData: SpeakingData = PlistDataLoader.loadSpeakingData()!) {
        self.speakingData = speakingData
        
        self.chatTopic = chatTopic
        
        let firstMsg = speakingData.firstMsg[chatTopic.rawValue] ?? ""
        self.messages = [ChatMessage(role: .model, message: firstMsg) ]
        self.history = [ ModelContent(role: "model", parts: firstMsg) ]
        
        self.systemInstruction = speakingData.chatInstruction[chatTopic.rawValue] ?? ""
        self.loadingResponse = false
        self.grammarService = GrammarService()
        
        // 베트남어 힌트 instruction 구하기
        var vietHintInstruction: String {
            // 공통 시작 텍스트: 당신은 베트남 사람이고 한국어를 모릅니다. 한국어로 질문하면 베트남어로 대답해야 합니다.
            var promptText: String = "Bạn là người Việt Nam và bạn không biết tiếng Hàn. Nếu hỏi bằng tiếng Hàn thì phải trả lời bằng tiếng Việt. "
            
            // 주제 안내하는 텍스트
            promptText += speakingData.vietHintInstruction[chatTopic.rawValue] ?? ""
            
            // 공통 마무리 텍스트: 답변은 짧게 유지하는 것을 잊지 마세요. 두 문장을 넘지 마세요. 답장할 때 이모티콘을 사용하지 마세요.
            promptText += "Hãy nhớ trả lời ngắn gọn, không quá hai câu. Không sử dụng biểu tượng cảm xúc khi trả lời."
            
            return promptText
        }
        self.hintService = HintService(hintInstruction: vietHintInstruction)
        
        self.ttsService = TTSService()
        
        DispatchQueue.main.async {
            self.ttsService.speak(self.messages.first!.message, .ko)
        }
        
    }
    
    
    /// Gemini API에 대화를 위한 문장 보내고 응답받기
    /// 1. 문장검사
    /// 2. 대화응답
    /// 3. AI 대답 받으면 그 대답에 대한 힌트 요청
    func sendMessage(message: String) async {
        
        loadingResponse = true  // 로딩 시작
        
        // MARK: - 유저 메시지, AI 메시지를 리스트에 추가
        messages.append(.init(role: .user, message: message))
        messages.append(.init(role: .model, message: ""))
        
        // MARK: - 문장검사
        do {
            // 문장검사 결과가 존재하는지 확인
            if let grammarCheck = try await grammarService.checkGrammar(sentence: message) {
                // grammarCheck 첫번째 값이 false일 경우: 문장을 고쳐야 하는 경우
                if grammarCheck.0 == false {
                    // messages 배열에서 role이 .user인 마지막 항목 찾기
                    if let index = messages.lastIndex(where: { $0.role == .user }) {
                        // 그 항목의 isNatural false로 채워넣기
                        messages[index].isNatural = false
                        
                        // 그 항목 다음에 role이 .feedback인 항목 추가하기
                        messages.insert(.init(role: .feedback, message: grammarCheck.1 ?? "어라라 에러가?", reasonForChange: grammarCheck.2), at: index + 1)
                    }
                } 
                // grammarCheck 첫번째 값이 true일 경우
                else {
                    // messages 배열에서 role이 .user인 마지막 항목 찾기
                    if let index = messages.lastIndex(where: { $0.role == .user }) {
                        // 그 항목의 isNatural true로 채워넣기
                        messages[index].isNatural = true
                    }
                }
                
            }
            
        } catch {
            print("문법 검사 중 에러 발생: \(error.localizedDescription)")
        }
        
        do {
            // MARK: - 멀티턴 대화
            let config = GenerationConfig(
                temperature: 1,
                maxOutputTokens: 100
            )
            
            let model = GenerativeModel(
                name: "gemini-1.5-flash",
                apiKey: APIKey.default,
                generationConfig: config,
                safetySettings: [
                    SafetySetting(harmCategory: .harassment, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .hateSpeech, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockOnlyHigh),
                    SafetySetting(harmCategory: .dangerousContent, threshold: .blockOnlyHigh)
                  ],
                systemInstruction: self.systemInstruction
            )
            
            
            // Initialize the chat
            let chat = model.startChat(history: history)
            
            // 메시지 보내고 응답받기
            let response = try await chat.sendMessage(message)
            if let text = response.text {
//                print("가공 전 text: \(text)")
                
                // 불필요한 \n 제거
                let processedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                
                print("응답메시지:", processedText)
                
                let lastChatMessageIndex = messages.count - 1
                messages[lastChatMessageIndex].message += processedText
                
                // 한국어 응답 TTS로 읽어주기
                print("sendMessage speak")
                ttsService.speak(processedText, .ko)
            }
            
            
            history.append(.init(role: "user", parts: message))
            history.append(.init(role: "model", parts: messages.last?.message ?? ""))
            
            loadingResponse = false // 로딩 끝내기

        }
        catch {
            loadingResponse = false
            messages.removeLast()
            messages.append(.init(role: .model, message: "다시 시도해주세요."))
            print("에러남\n", error.localizedDescription)
        }
    }
    
    /// 인덱스에 해당하는 메시지 보여줄지 안보여줄지 토글하기
    func toggleMessageShowing(index: Int) {
        withAnimation {
            messages[index].isShowing.toggle()
        }
        print("isShowing Toggled: index\(index) - \(messages[index].isShowing)")
    }
    
    /// 말풍선 밑에 스피커, 번역버튼이 보여줄지 안보여줄지 토글
    /// (role이 user일 때만 사용됨)
    /// - 유저의 ChatBox 밑에 피드백 메시지가 뜰 경우 user의 BottomButtons는 안보여야 함
    /// - 유저의 ChatBox 밑에 피드백 메시지가 없을 경우에는 BottomButtons 보여야 함
    func toggleUserBottomButtons(index: Int) {
        withAnimation {
            messages[index].showBottomButtons.toggle()
        }
    }
    
    /// 힌트는 요청한 경우에만 hintService 활용해 힌트 보여주기
    func requestHint() async {
        // 다시 시도해주세요가 아닐 경우(모델의 대답이 에러가 아닌 경우)에만 진행
        if let lastMessage = messages.last?.message, lastMessage != "다시 시도해주세요." {
            
            // 로딩되는 과정 보여주기 위해 일단 힌트 메시지 객체 추가
            withAnimation {
                messages.append(.init(role: .hint, message: ""))
            }
            
            // 힌트 요청
            if let hintMessage = await hintService.requestHint(sentence: lastMessage) {
                
                // 마지막 메시지 객체에 요청받은 힌트 메시지 추가
                withAnimation {
                    messages[messages.count - 1].message += hintMessage
                }
                
                print(messages.last ?? "마지막메시지 몰라유")
            }
        } else {
            messages.append(.init(role: .hint, message: "힌트를 요청할 수 없습니다"))
        }
    }
    
}
