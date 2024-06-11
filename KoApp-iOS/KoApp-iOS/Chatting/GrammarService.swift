//
//  GrammarService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/11/24.
//

import SwiftUI
import GoogleGenerativeAI

/// 문장교정용 싱글턴 Gemini API 서비스
@Observable
class GrammarService {
//    private(set) var loadingResponse = false
    
    func checkGrammar(sentence: String) async {
        
//        loadingResponse = true  // 로딩 시작
        
        do {
            let config = GenerationConfig(
                temperature: 1,
                maxOutputTokens: 50
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
                systemInstruction: "User가 문장을 입력할거야. 너는 문장이 자연스러운지 검사하는 검사기야. 문장 순서가 틀렸거나 문법이 틀린 부자연스러운 문장만 고쳐주면 돼. 너무 빡빡하게 하지 말라는 뜻이야. 친절하게 문법용어 최대한 쓰지 말고 쉽게 설명해줘\n대답의 형태는 다음과 같이 해줘\nUser의 문장이 자연스럽다면 0, 어색하거나 고쳐야되는 부분이 있다면 1 ; 고친 문장 추천; 문장을 고친 이유"
            )
            
            
            
            // 메시지 보내고 응답받기
            let response = try await model.generateContent(sentence)
            if let text = response.text {
                
                // 불필요한 \n 제거
                let precessedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
                
                print("맞춤법 검사 결과:", precessedText)
                
            }
                        
//            loadingResponse = false // 로딩 끝내기

        }
        catch {
//            loadingResponse = false
            print("에러남\n", error.localizedDescription)
        }
    }
    
    
}

