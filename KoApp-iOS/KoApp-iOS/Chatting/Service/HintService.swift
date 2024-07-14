//
//  HintService.swift
//  KoApp-iOS
//
//  Created by 석민솔 on 6/13/24.
//

import SwiftUI
import GoogleGenerativeAI

/// 문장교정용 싱글턴 Gemini API 서비스
@Observable
class HintService {
    /// 모델별로 주제가 다르기 때문에 힌트도 다르게 입력되어야 함. 힌트용 systemInstruction
    /// ChatService에서 입력받을 예정
    let hintInstruction: String
    
    private(set) var loadingResponse: Bool
    
    init(hintInstruction: String) {
        self.hintInstruction = hintInstruction
        self.loadingResponse = false
    }
    
    func requestHint(sentence: String) async -> String? {
        
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
                // TODO: 모델에 따라 다른 systenInstruction 입력하기
                systemInstruction: hintInstruction
            )
            
            
            
            // 메시지 보내고 응답받기
            let response = try await model.generateContent(sentence)
            if let text = response.text {
                
                // 불필요한 \n 제거
                let processedText = text.replacingOccurrences(of: "\n", with: "")
                print("processedText:", processedText)
                
                return processedText
                
            }
                        

        }
        catch {
            loadingResponse = false
            print("힌트요청에서 에러났다\n", error.localizedDescription)
        }
        
        return nil
    }
    
    
}


