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
    private(set) var loadingResponse = false
    
    func checkGrammar(sentence: String) async -> (Bool, String?, String?)? {
        
        loadingResponse = true  // 로딩 시작
        
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
                systemInstruction: "- 너는 문장이 자연스러운지 검사하는 검사기야.\n- 심각하게 틀린 문장만 고쳐주면 돼. 문장 부호(,.)나 띄어쓰기는 틀려도 괜찮으니까 고치지 마.\n- 어떻게 고쳐야할지는 모르겠으면 에러 내지 말고 \"1;문장의 의도를 모르겠음\"이라고 대답해.\n- 존댓말을 사용하며, \"-에요.\", \"-하더라고요.\" 말투를 사용해. 친절하게 문법용어 최대한 쓰지 말고 쉽게 설명해줘\n- 대답의 형태는 다음과 같이 해줘 \"User의 문장이 자연스럽다면 0, 어색하거나 고쳐야되는 부분이 있다면 1;고친 문장 추천;문장을 고친 이유\""
            )
            
            
            
            // 메시지 보내고 응답받기
            let response = try await model.generateContent(sentence)
            if let text = response.text {
                
                // 불필요한 \n 제거
                let processedText = text.replacingOccurrences(of: "\n", with: "")
                print("processedText:", processedText)
                
                // 맞춤법 검사 결과 배열 리턴하기
                let grammarCheck = processedText.components(separatedBy: ";")
                loadingResponse = false // 로딩 끝내기
                
                // 어떻게 나오나 체크 한 번..
                print(grammarCheck)
                

                if let isNatural = Int(grammarCheck[0]) {
                    if isNatural == 0 {
                        // 문장이 자연스러운 경우: 첫번째 튜플 값만 true로 리턴
                        print("자연스러운 문장!")
                        return (true, nil, nil)
                    } else if isNatural == 1 {
                        // 문장이 부자연스러운 경우: 바꾼 문장, 바꾼 이유와 같이 리턴
                        print("부자연스러운 문장...")
                        return (false, grammarCheck[1], grammarCheck[2])
                    }
                }
            }
                        

        }
        catch {
            loadingResponse = false
            print("문장검사에서 에러났다\n", error.localizedDescription)
        }
        
        return nil
    }
    
    
}

